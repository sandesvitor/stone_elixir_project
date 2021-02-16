# StoneChallenge

This is application represents the challenge propouse by **Stone Pagamentos** for its selection process, **Programa de Formação em Elixir** due to end on february 19<sup>th</sup>.

---


## **Data**:

This project uses *mix* for a much easier compilation and testing of the application. The **./lib** folder contains the *stone_challenge.ex* file, with the only module for this app. The function *StoneChallenge.generateBill* is the main function that correspond to the propoused challenge, along with other function that compose the calculations, the recursive function *StoneChallenge.billDistribution*

The paramethers for *StoneChallenge.generateBill* are:

### **1. products**:

A **list** of **maps**, each of it containing the key-value pairs %{:name=>string, :count=>integer, :unitPrice=>integer}. In this case, the keys are all atoms.

```elixir
[
    %{:name=>"Laptop", :count=>1, :unitPrice=>900000},
    %{:name=>"Gabinete", :count=>2, :unitPrice=>90000},
    %{:name=>"RAM", :count=>4, :unitPrice=>100000},
]
```

As stated by the command of the challenge, this projects uses integers numbers for the *unitPrice* value, representing the unit scale for monetary currency by *brazilian cents*, or *centavos*, being 100 *centavos* equals to 1 *real* (R$1,00), avoiding the use of float numbers.


### **2. custumers**:

A list of strings representing all the custumers emails (one custumer is represented by their single email).

```elixir
[
    "sandesvitor@gmail.com",
    "jonas@gmail.com",
    "ana@gmail"
]
```

The expected output will be a **map** containing key-value pair of %{email=>integer, ...}. In this case the keys are strings, and the number of key-value pair is equal to the length of the custumers list.

```elixir
%{
    "ana@gmail" => 493333,
    "jonas@gmail.com" => 493333,
    "sandesvitor@gmail.com" => 493334
}
```


## **Running the Application**:

Firstly, make sure that **mix** is installed:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4481]
└─[$] mix --version                                                                   
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [hipe]

Mix 1.11.2 (compiled with Erlang/OTP 23)
```

Now, get dependencies and compile the application:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4520]
└─[$] mix deps.get             
Resolving Hex dependencies...
Dependency resolution completed:
Unchanged:
  poison 3.1.0
All dependencies are up to date

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

The simplest way to run inside **Elixir's interactive shell** (iex), passing the paramenters inside the shell, as shown bellow:

```shell                                                                                     
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4437]
└─[$] iex -S mix                                                                                                                                                                                        
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [hipe]

Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> x = [%{:name=>"Laptop", :count=>1, :unitPrice=>900000}, %{:name=>"Gabinete", :count=>2, :unitPrice=>90000}, %{:name=>"RAM", :count=>4, :unitPrice=>100000}]
[
  %{count: 1, name: "Laptop", unitPrice: 900000},
  %{count: 2, name: "Gabinete", unitPrice: 90000},
  %{count: 4, name: "RAM", unitPrice: 100000}
]
iex(2)> y = ["sandesvitor@gmail.com", "jonas@gmail.com", "ana@gmail"]
["sandesvitor@gmail.com", "jonas@gmail.com", "ana@gmail"]
iex(3)> StoneChallenge.generateBill(x,y)
%{
  "ana@gmail" => 493333,
  "jonas@gmail.com" => 493333,
  "sandesvitor@gmail.com" => 493334
}
iex(4)>
```

A second method is to use the task **run_app**, configure inside the ./lib/mix/tasks folder, with the parameters hardcoded inside the task function. You can optionally redirect the stdout to a file, as shown bellow:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4483]
└─[$] mix run_app > results.out
```

## **Testing**:

Softwares versions used by the host machine to perform the tests:

```shell
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:6:6] [ds:6:6:10] [async-threads:1] [hipe]

Elixir 1.11.2 (compiled with Erlang/OTP 23)

Mix 1.11.2 (compiled with Erlang/OTP 23)
```

Host machne operating system:

```shell
Linux pop-os 5.8.0-7642-generic #47~1612288990~20.04~b8113e7-Ubuntu SMP Wed Feb 3 02:25:36 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```

For unit testing, this application uses **ExUnit**.

The **./test** folder contains the .exs file *stone_challenge_test.exs*. To run it type:

```shell
┌─[sandesvitor@pop-os] - [~/stone_challenge] - [4398]
└─[$] mix test
[11:33:03]
........

Finished in 0.05 seconds
8 tests, 0 failures

Randomized with seed 507635
```

The following statements were proposed for unit testing the application functions:

- test "check if number of key-value pair in output of generateBillMap is equal to custumers list length"
- test "generateBillMap function with both inputs non-empty lists - 1" 
- test "generateBillMap function with both inputs non-empty lists - 2" 
- test "generateBillMap function with shoplist empty"
- test "generateBillMap function with custumers list empty"
- test "generateBillMap function with both lists empty" 