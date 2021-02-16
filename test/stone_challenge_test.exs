defmodule StoneChallengeTest do
  use ExUnit.Case
  doctest StoneChallenge


  test "check if number of key-value pair in output of generateBillMap is equal to custumers list of length 3" do
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

  test "check if number of key-value pair in output of generateBillMap is equal to custumers list of length 1" do
    assert StoneChallenge.generateBill([
      %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
      %{:name=>"Gabinete", :count=>2, :unitPrice=>90000},
      %{:name=>"RAM", :count=>4, :unitPrice=>100000},
    ],
    [
      "sandesvitor@gmail.com",
    ])
      |> Map.keys()
      |> Enum.count()

    == 1

  end

  test "1) calculateAmountFunction with random shoplist" do
    assert StoneChallenge.calculateAmount([
      %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
      %{:name=>"Gabinete", :count=>2, :unitPrice=>90000},
      %{:name=>"RAM", :count=>4, :unitPrice=>100000},
    ])

    ==

    1480000

  end

  test "2) calculateAmountFunction with random shoplist" do
    assert StoneChallenge.calculateAmount([
      %{:name=>"Laptop", :count=>10, :unitPrice=>900000313},
      %{:name=>"Gabinete", :count=>12, :unitPrice=>900223100},
      %{:name=>"RAM", :count=>41, :unitPrice=>10009999}
    ])

    ==

    20213090289

  end

  test "1) generateBillMap function with both inputs non-empty lists" do
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

  test "2) generateBillMap function with both inputs non-empty lists" do
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

  test "generateBillMap function with custumers list containing not-unique items" do
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
        "otávio@gmail.com",
        "otávio@gmail.com",
        "otávio@gmail.com",
        "otávio@gmail.com",
      ])

    ==

    %{
      "otávio@gmail.com" => 236851,
      "otávio@gmail.com" => 236851,
      "otávio@gmail.com" => 236851,
      "joao@gmail.com" => 236852,
      "otávio@gmail.com" => 236852,
      "otávio@gmail.com" => 236852
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
