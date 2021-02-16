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

## **Recursive Function**:

Since Elixir threat its data immutably, the *StoneChallenge.billDistribution* function serves as a while loop, in order to distribute the remainerd of the division between the amount to pay and the number of custumers (i.e. If there is a tab with 3 custumers and the bill is 5 *centavos*, this function will determine that 2 custumers will have to pay 2 *centavos* leaving the other to pay only 1 *centavo*).

Recursive functions should be used with caution, especially if dealt with code deployed in public clouds, such as AWS or Azure, that having a infinite recursive call could exhaust all the resources of such application in minutes. Therefore, *StoneChallenge.billDistribution* stablish some constrains in its call. Always when the remainder paramether goes to zero (0), the recursiveness comes to an end andthe stack is cleaned, returning a list of maps with the custumer email as a key and its bill as a value:

```elixir
[
    %{"ana@gmail" => 493333}, 
    %{"jonas@gmail.com" => 493333}, 
    %{"sandesvitor@gmail.com" => 493334}
]
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

For unit testing, this application uses **ExUnity**..

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

- test "recursion billDistribution function with rem == 0";
- test " recursion billDistribution function with rem > 0"
- test "check if number of key-value pair in output of generateBillMap is equal to custumers list length"
- test "generateBillMap function with both inputs non-empty lists - 1" 
- test "generateBillMap function with both inputs non-empty lists - 2" 
- test "generateBillMap function with shoplist empty"
- test "generateBillMap function with custumers list empty"
- test "generateBillMap function with both lists empty" 