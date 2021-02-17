defmodule Mix.Tasks.RunApp do
  use Mix.Task

  @shortdoc "Runs application with json filepaths as arguments."
  def run(args) do
    Enum.each(args, fn filepath ->
      json_parsed = filepath |> File.read! |> Poison.decode!(keys: :atoms)
      StoneChallenge.generateBill(json_parsed.shoplist, json_parsed.customers)
      |> IO.inspect(limit: :infinity)
    end)
  end
end
