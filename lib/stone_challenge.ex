defmodule StoneChallenge do

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
      remainder = rem(amountToPay, length(custumers))

      Enum.reduce(custumers, %{:custumersTab=>%{}, :index=>0}, fn (email, acc) ->
        %{
          :custumersTab=>Map.put(acc.custumersTab, email, amountEvenlyDistributed + (acc.index < remainder && 1 || 0)),
          :index=>acc.index + 1
        }
      end).custumersTab
    end
  end

end
