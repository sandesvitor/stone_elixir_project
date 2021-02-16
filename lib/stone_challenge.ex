defmodule StoneChallenge do

  # return list of maps containing email and amount to pay
  defp billDistribution(custumersTab, rem, _) when rem == 0 do
    custumersTab
  end

  # makes recursive calls until the remaider of the bill is zero
  defp billDistribution(custumersTab, rem, index) do
    Enum.map(custumersTab, fn custumer ->
      case Enum.find_index(custumersTab, fn x -> x == custumer end) == index do
        true -> for {key, value} <- Enum.at(custumersTab, index), into: %{}, do: {key, value + 1}
        false -> custumer
      end
    end)
    |> billDistribution(rem - 1, index + 1)
  end

  def calculateAmount(shoplist) do
    Enum.map(shoplist, fn item -> item.count * item.unitPrice end)
    |> Enum.reduce(fn (curr, acc) -> curr + acc end)
  end

  def generateBill(products, custumers) do
    case { length(products), length(custumers) } do
      {0, 0} -> %{:error =>:lists_empty}
      {0, _} -> for key <- custumers, into: %{}, do: {key, 0}
      {_, 0} -> %{:error =>:client_list_empty}
      _ ->

      amountToPay = calculateAmount(products)
      amountEvenlyDistributed = Integer.floor_div((amountToPay - rem(amountToPay, length(custumers))), length(custumers))
      remaider = rem(amountToPay, length(products))

      Enum.map(custumers, fn custumer -> %{custumer=>amountEvenlyDistributed} end)
      |> billDistribution(remaider, 0)
      |> Enum.reduce(%{}, fn (mapTab, acc) -> Map.merge(acc, mapTab) end)
    end
  end

end
