defmodule Mix.Tasks.RunApp do
  use Mix.Task

  @shortdoc "Runs application with the parameters in ./lib/mix/tasks/run_app.ex"
  def run(args) do
    Enum.each(args, fn filepath ->
      json_parsed = filepath |> File.read! |> Poison.decode!(keys: :atoms)
      StoneChallenge.generateBill(json_parsed.shoplist, json_parsed.custumers)
      |> IO.inspect(limit: :infinity)
    end)
  end
end
