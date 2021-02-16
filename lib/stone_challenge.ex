defmodule StoneChallenge do

  def billDistribution(custumersTab, change, _) when change == 0 do
    custumersTab
  end

  def billDistribution(custumersTab, change, index) do
    Enum.map(custumersTab, fn custumer ->
      case Enum.find_index(custumersTab, fn x -> x == custumer end) == index do
        true -> for {key, value} <- Enum.at(custumersTab, index), into: %{}, do: {key, value + 1}
        false -> custumer
      end
    end)
    |> billDistribution(change - 1, index + 1)
  end

  def generateBillMap(products, custumers) do
    case { length(products), length(custumers) } do
      {0, _} -> for key <- custumers, into: %{}, do: {key, 0}
      {_, 0} -> %{:error =>:client_list_empty}
      {0, 0} -> %{:error =>:lists_empty}
      _ ->

      amount = Enum.map(products, fn item -> item.count * item.unitPrice end)
      |> Enum.reduce(fn (curr, acc) -> curr + acc end)

      spareChange = rem(amount, length(products))
      amountPerPerson = Integer.floor_div((amount - rem(amount, length(custumers))), length(custumers))

      Enum.map(custumers, fn custumer -> %{custumer=>amountPerPerson} end)
      |> billDistribution(spareChange, 0)
      |> Enum.reduce(%{}, fn (mapTab, acc) -> Map.merge(acc, mapTab) end)
    end
  end

end
