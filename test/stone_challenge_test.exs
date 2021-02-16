defmodule StoneChallengeTest do
  use ExUnit.Case
  doctest StoneChallenge

  test "recursion billDistribution function with rem == 0" do
    assert StoneChallenge.billDistribution([%{"test@test.com"=>1000}], 0, 0) == [%{"test@test.com"=>1000}]
  end

  test " recursion billDistribution function with rem > 0" do
    assert StoneChallenge.billDistribution(
      [
        %{"test1@test.com"=>0},
        %{"test2@test.com"=>0},
        %{"test3@test.com"=>0},
      ], 2, 0)

    == [%{"test1@test.com" => 1}, %{"test2@test.com" => 1}, %{"test3@test.com" => 0}]
  end

  test "check if number of key-value pair in output of generateBillMap is equal to custumers list length" do
    assert StoneChallenge.generateBill([
      %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
      %{:name=>"Gabinete", :count=>2, :unitPrice=>90000},
      %{:name=>"RAM", :count=>4, :unitPrice=>100000},
    ],
    [
      "sandesvitor@gmail.com",
      "jonas@gmail.com",
      "ana@gmail"
    ])
      |> Map.keys()
      |> Enum.count()

    == 3

  end

  test "generateBillMap function with both inputs non-empty lists - 1" do
    assert StoneChallenge.generateBill(
      [
        %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
        %{:name=>"Gabinete", :count=>2, :unitPrice=>90000},
        %{:name=>"RAM", :count=>4, :unitPrice=>100000},
      ],
      [
        "sandesvitor@gmail.com",
        "jonas@gmail.com",
        "ana@gmail"
      ])

    ==

    %{
      "ana@gmail" => 493333,
      "jonas@gmail.com" => 493333,
      "sandesvitor@gmail.com" => 493334
    }
  end

  test "generateBillMap function with both inputs non-empty lists - 2" do
    assert StoneChallenge.generateBill(
      [
        %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
        %{:name=>"Gabinete", :count=>2, :unitPrice=>555},
        %{:name=>"RAM", :count=>4, :unitPrice=>100000},
        %{:name=>"Pen", :count=>2, :unitPrice=>9999},
        %{:name=>"Tire", :count=>1, :unitPrice=>100000},
      ],
      [
        "joao@gmail.com",
        "otávio@gmail.com",
        "viny@gmail",
        "almeida@gmail",
        "gustavo@gmail",
        "amelia@gmail"
      ])

    ==

    %{
      "almeida@gmail" => 236851,
      "amelia@gmail" => 236851,
      "gustavo@gmail" => 236851,
      "joao@gmail.com" => 236852,
      "otávio@gmail.com" => 236852,
      "viny@gmail" => 236852
    }
  end

  test "generateBillMap function with shoplist empty" do
    assert StoneChallenge.generateBill(
      [],
      [
        "joao@gmail.com",
        "otávio@gmail.com",
        "viny@gmail",
        "almeida@gmail",
        "gustavo@gmail",
        "amelia@gmail"
      ])

    ==

    %{
      "almeida@gmail" => 0,
      "amelia@gmail" => 0,
      "gustavo@gmail" => 0,
      "joao@gmail.com" => 0,
      "otávio@gmail.com" => 0,
      "viny@gmail" => 0
    }
  end

  test "generateBillMap function with custumers list empty" do
    assert StoneChallenge.generateBill(
      [
        %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
        %{:name=>"Gabinete", :count=>2, :unitPrice=>555},
        %{:name=>"RAM", :count=>4, :unitPrice=>100000},
        %{:name=>"Pen", :count=>2, :unitPrice=>9999},
        %{:name=>"Tire", :count=>1, :unitPrice=>100000},
      ],
      [])

    ==

    %{:error => :client_list_empty}
  end

  test "generateBillMap function with both lists empty" do
    assert StoneChallenge.generateBill([],[]) == %{:error => :lists_empty}
  end

end
