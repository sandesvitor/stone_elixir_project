# StoneChallenge

This repository represents the challenge proposed by **Stone Pagamentos** for its selection process, **Programa de Formação em Elixir**, due on february 19<sup>th</sup>, and contains the main application with its tasks and unit tests.

---


## **Data**:

This project uses *mix* for a easier compilation, usage and testing of the application. The **./lib** folder contains the *stone_challenge.ex* file, with the module for this app, *StoneChallenge*. The function *StoneChallenge.generateBill* is the main function that correspond to the propoused challenge.

The paramethers for *StoneChallenge.generateBill* are:

### **1. products**:

A **list** of **maps**, each containing the key-value pairs *%{:name=>string, :count=>integer, :unitPrice=>integer}*. In this case, the keys are **atoms**.

```elixir
[
    %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
    %{:name=>"Gabinete", :count=>2, :unitPrice=>90000},
    %{:name=>"RAM", :count=>4, :unitPrice=>100000},
]
```

As stated by the command of the challenge, this project uses integer numbers for the *unitPrice* value. The used currency is the Brazilian cents, or *centavos*, 100 *centavos* being equal to 1 Real (R$1,00), thus avoiding the use of float numbers.


### **2. customers**:

A list of strings representing all the customer emails (one custumer is represented by their single email).

```elixir
[
    "sandesvitor@gmail.com",
    "jonas@gmail.com",
    "ana@gmail"
]
```

The expected output is **map** containing key-value pairs of %{email=>integer, ...}. In this case the keys are **strings**, and the number of the key-value pairs is equal to the length of the customer list.

```elixir
%{
    "ana@gmail" => 493333,
    "jonas@gmail.com" => 493333,
    "sandesvitor@gmail.com" => 493334
}
```


## **Running the Application**:

Software versions used:

```shell
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [hipe]

Elixir 1.11.2 (compiled with Erlang/OTP 23)

Mix 1.11.2 (compiled with Erlang/OTP 23)
```

Host machine operating system:

```shell
Linux pop-os 5.8.0-7642-generic #47~1612288990~20.04~b8113e7-Ubuntu SMP Wed Feb 3 02:25:36 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```

*For Elixir and the Erlang virtual machine installation, visit Elixir's web page on https://elixir-lang.org/install.html.*

Firstly, open up a terminal in your computer and make sure that **mix** is installed:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4481]
└─[$] mix --version                                                                   
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [hipe]

Mix 1.11.2 (compiled with Erlang/OTP 23)
```

Now, to get the dependencies stated in the dependencies list (**./mix.exs**), use **mix** command:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4520]
└─[$] mix deps.get             
Resolving Hex dependencies...
Dependency resolution completed:
Unchanged:
  poison 3.1.0
All dependencies are up to date
```

Compile the application:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4521]
└─[$] mix compile                                                                                   
==> poison
Compiling 4 files (.ex)
warning: Integer.to_char_list/2 is deprecated. Use Integer.to_charlist/2 instead
  lib/poison/encoder.ex:173: Poison.Encoder.BitString.seq/1

Generated poison app
==> stone_challenge
Compiling 2 files (.ex)
Generated stone_challenge app
```

This application runs with a task called **run_app**, that receives a list of arguments and returns a map that represents the customers'bill (amount in *centavos*). The arguments must be the paths of json files, containing the shoplist and the customer email list, as follows:

```json
{
  "shoplist": [
      {"name":"Laptop", "count":1, "unitPrice": 900000},
      {"name":"Gabinete", "count":2, "unitPrice": 555},
      {"name":"RAM", "count":4, "unitPrice": 100000},
      {"name":"Pen", "count":2, "unitPrice": 9999},
      {"name":"Tire", "count":1, "unitPrice": 100000}
    ],
  "customers": [
      "joao@gmail.com",
      "otávio@gmail.com",
      "viny@gmail",
      "almeida@gmail",
      "gustavo@gmail",
      "amelia@gmail"
  ]
}
```

You may pass any number of json paths as arguments, and the task will concatenate every resulting map on the *stdout*, using Elixir's **IO** module. In this repository, you will find under the **./test/json.d/** folder, two json examples (the **./test/json.d/test2.json**, for instance, has a list containing 10.000 unique email entries). Run it using **mix run_app <args>**.

NOTE: In the examples bellow, the **time** binary was used only to check performance between different sized lists. 

For a single file:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4544]
└─[$] time mix run_app test/json.d/test1.json                                                                                                                                                 
%{
  "almeida@gmail" => 236851,
  "amelia@gmail" => 236851,
  "gustavo@gmail" => 236851,
  "joao@gmail.com" => 236852,
  "otávio@gmail.com" => 236852,
  "viny@gmail" => 236851
}
mix run_app test/json.d/test1.json  0.56s user 0.09s system 212% cpu 0.302 total
```

For two files:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4545]
└─[$] time mix run_app test/json.d/test1.json test/json.d/test1.json                                                                                                                          
%{
  "almeida@gmail" => 236851,
  "amelia@gmail" => 236851,
  "gustavo@gmail" => 236851,
  "joao@gmail.com" => 236852,
  "otávio@gmail.com" => 236852,
  "viny@gmail" => 236851
}
%{
  "almeida@gmail" => 236851,
  "amelia@gmail" => 236851,
  "gustavo@gmail" => 236851,
  "joao@gmail.com" => 236852,
  "otávio@gmail.com" => 236852,
  "viny@gmail" => 236851
}
mix run_app test/json.d/test1.json test/json.d/test1.json  0.65s user 0.06s system 230% cpu 0.308 total
```

Running both json files and redirecting the output to a file named *results.out*:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4549]
└─[$] time mix run_app test/json.d/test1.json test/json.d/test2.json > results.out
mix run_app test/json.d/test1.json test/json.d/test2.json > results.out  0.66s user 0.12s system 207% cpu 0.372 total
```


## **Testing**:

For unit testing, this application uses **ExUnit**, standard for *mix's* projects.

The **./test** folder contains the .exs file *stone_challenge_test.exs*. To run it, type:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4398]
└─[$] mix test
[11:33:03]
........

Finished in 0.06 seconds
9 tests, 0 failures

Randomized with seed 536858
```

The following statements were proposed for unit testing the application functions:

- test "check if the number of key-value pairs in the output of StoneChallenge.generateBill is equal to the customer list of length 3";
- test "check if the number of key-value pairs in the output of StoneChallenge.generateBill is equal to the customer list of length 1" 
- test "StoneChallenge.calculateAmount function with random shoplist - nº 1" 
- test "StoneChallenge.calculateAmount function with random shoplist - nº 2"
- test "StoneChallenge.generateBill function with both inputs non-empty lists - nº 1"
- test "StoneChallenge.generateBill function with both inputs non-empty lists - nº 2" 
- test "StoneChallenge.generateBill function with shoplist empty" 
- test "StoneChallenge.generateBill function with customers list empty" 
- test "StoneChallenge.generateBill function with both lists empty" 
