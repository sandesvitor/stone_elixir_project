defmodule StoneChallenge do

  def calculateAmount(shoplist) do
    Enum.map(shoplist, fn item -> item.count * item.unitPrice end)
    |> Enum.reduce(fn (curr, acc) -> curr + acc end)
  end

  def generateBill(products, customers) do
    case { length(products), length(customers) } do
      {0, 0} -> %{:error =>:lists_empty}
      {0, _} -> for key <- customers, into: %{}, do: {key, 0}
      {_, 0} -> %{:error =>:client_list_empty}
      _ ->

      amountToPay = calculateAmount(products)
      amountEvenlyDistributed = Integer.floor_div((amountToPay - rem(amountToPay, length(customers))), length(customers))
      remainder = rem(amountToPay, length(customers))

      Enum.reduce(customers, %{:customersTab=>%{}, :index=>0}, fn (email, acc) ->
        %{
          :customersTab=>Map.put(acc.customersTab, email, amountEvenlyDistributed + (acc.index < remainder && 1 || 0)),
          :index=>acc.index + 1
        }
      end).customersTab
    end
  end

end
