# FAF.PTR16.1 -- Project 0

> **Performed by:** Todirașcu Ilie, group FAF-203
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W1

The first week was for installing Elixir, creating a repository, and writing some simple code.

Here is the code for printing `Hello PTR` and the unit test required:

```elixir
test "was greeting received" do
      assert Ptrlabs.greetPTR === "hello PTR"
  end
  def greetPTR do
    "hello PTR"
  end
```

## P0W2

**Miminal Tasks**

Since there are way too many functions to comment them all, I will explain the easiest one - cylinderArea just uses the formula.

```elixir
  def prime?(n) do
    [1,n] === factors(n)
  end
  def factors(1), do: [1]
  def factors(n) when n < 1 do
    "Please input a number greater than 0"
  end
  def factors(2), do: [1,2]
  def factors(n) do
    Enum.filter(1..floor(n/2), fn x -> rem(n,x) == 0 end) ++ [n]
  end

  def cylinderArea(h,r) do
    2*@pi*r*h + 2*@pi * :math.pow(r,2)
  end

  def reverse(list) do
    Enum.reverse(list)
  end

  def uniqueSum(list) do
    Enum.uniq(list) |> Enum.sum
  end

 def extractRandomN(list, n) do
    Enum.take_random(list,n)
  end

  def firstFibonacciElements(n) when n < 3 do
    "first two elements are [1,1]"
  end

  def firstFibonacciElements(n) do
    fib([1,1],n)
  end
  def fib(list,n) do
    list = list ++ [Enum.slice(list,-2..-1) |> Enum.sum]
    case length(list) < n do
      true -> fib(list,n)
      false -> list
    end
  end

  def translator(dictionary,original_string) when not is_map(dictionary) do
    translator(@dictionary,original_string)
  end
  def translator(dictionary,original_string) when is_map(dictionary) do
    split_string = String.split(original_string, "\s")
    for word <- split_string do
      cond do
        dictionary[word] == nil -> word
        true -> dictionary[word]
      end
    end
    |> Enum.join(" ")
  end
  def smallestNumber([]), do: "Can't be empty"
  def smallestNumber(list) do
    {head , tail } = Enum.split_while(Enum.sort(list),fn x -> x === 0 end)
    List.insert_at(tail,1,head)
    |> List.flatten
    |> Enum.join
    |> String.to_integer
  end

  def rotateLeft(list,count) do
    {head,tail} = Enum.split(list,rem(count,length(list)))
    List.flatten([tail | head])
  end

  def listRightAngleTriangles do
    numbers = 1..20
    for a <- numbers, b <- numbers do
      power = :math.pow(a,2) + :math.pow(b,2)
      c = Enum.filter(1..20,fn x -> :math.pow(x,2) == power end)
      cond  do
        [] != c -> [a | [b | c]]
        true -> []
      end
  end
  |> Enum.filter(fn x -> x != [] end)
  |> Enum.uniq
end
```

**Main Tasks**

Functions are as follows:

- `llineWords` - define keyboard rows, filter the given list on the condition that a given word is a subset of a defined row. Return the filtered list.
- `encode(plaintext, key)` - for each char of string check if it is a letter and modify using some formula found on forums.
- `decode(ciphertext, key)` - same process as encoding but with negated key.
- `removeConsecutiveDuplicates(list)` - uses a standard library function that does just that.
- `groupAnagrams(list)` - uses the group_by on the words split as individual sorted chars.

```elixir
  def lineWords(list) do
    lines = ["qwertyuiop","asdfghjkl","zxcvbnm"]
    Enum.filter(list,
      fn lsItem ->
        Enum.any?(lines, fn lineItem -> MapSet.subset?(MapSet.new(String.codepoints(lsItem)), MapSet.new(String.codepoints(lineItem))) end )
      end)
    end

  def encode(plaintext,key) do
    to_string(Enum.map(to_charlist(plaintext),
    fn x ->
      shift(getCase(x),x,key)
      end
     ))
  end
  def decode(ciphertext,key) do
    encode(ciphertext,-key)
  end
  def shift(minmax,char,key) do
    [min | max] = minmax
    operation = char + rem(key,26)
    cond do
      operation < min ->
        26 + operation
      operation > List.first(max) ->
         operation - 26
      true -> operation
    end
  end
  def getCase(char) do
    case max(char,?Z) do
      ^char -> [?a | [?z|[]]]
      ?Z -> [?A | [?Z | []]]
    end
 end

  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end

  def groupAnagrams(strings) do
    Enum.group_by(strings, &(String.codepoints(&1) |> Enum.sort |> Enum.join))
  end
```

**Bonus Tasks**

These would take also way too long to explain, so I'll comment the hardest one, `letters_combos(string)`. Create a map called @dict with all the possible values for each number. Then we take the combination as a string "234" for example and we recursively combine every value by using comprehensions.

```elixir
def commonPrefix(words) do
  for word <- words do
    String.codepoints(word)
  end
  |> magic(1)
 end

 def magic(words,count) when count <= length(words) do
  cond do
   Enum.all?(words, fn x -> Enum.slice(List.first(words),0,count) == Enum.slice(x,0,count) end) === true -> magic(words,count+1)
   true -> Enum.join(Enum.slice(List.first(words),0,count-1))
  end
 end

  def to_roman(0, acc), do: acc
  def to_roman(n, acc) do
    roman_numerals = [
      {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
      {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
      {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"},
      {1, "I"}
    ]

    case roman_numerals |> Enum.find(fn({decimal, _}) -> n >= decimal end) do
      nil -> acc
      {decimal, roman} ->
        to_roman(n - decimal, acc <> roman)
    end
  end
  def to_roman(n) when n >= 1 and n <= 3999 do
    to_roman(n, "")
  end

 def factorize(number) when number <= 1 ,do: []
 def factorize(number) do
  # factorize(Enum.filter(factors(number),fn x -> prime?(x) == true end),number)
  factorize(Enum.filter(factors(number),&prime?(&1) == true),number)
 end
 def factorize([head | tail],number) do
  factorsProduct = Enum.product([head | tail])
  cond do
    factorsProduct != number -> factorize([head | tail] ++ [Enum.max(factorize(Integer.floor_div(number,factorsProduct)))],number)
    true -> Enum.sort([head | tail])
  end
 end

 def letterCombination(""), do: [""]

 def letterCombination(<<key::binary-1, rest::binary>>) do
   for letter <- @dict[key], tail <- letterCombination(rest), do: letter <> tail
 end
```

## POW3

**Minimal Tasks**

- Actor that prints any message it receives:

```elixir
defmodule Talker do
  def start_link() do
    pid = spawn_link(__MODULE__,:actor,[])
    Process.register(pid,:talker)
    pid
  end
  def actor() do
    receive do
      {caller_pid, message} when is_pid(caller_pid) ->
        send(caller_pid, message)
      {:shutdown} ->
        exit(:normal)
      {:oops} -> exit(:big_bad)
    end
    actor()
  end
  def talk(value) do
    send(:talker,{self(), value})
    receive do
      phrase when is_bitstring(phrase) -> "Talker says: #{phrase}"
    end
  end
  def kill do
    send(:talker,{:shutdown})
  end
  def err do
    send(:talker,{:oops})
  end
end

```

- Actor that modifies messages it receives:

```elixir
defmodule Modifier do
  def loop do
    receive do
      {from,message} when is_pid(from) ->
        send(from,message)
    end
    loop()
  end
  def modify(modifier,value) do
    send(modifier,{self(), value})
    receive do
      value when is_integer(value) -> value + 1
      value when is_bitstring(value) -> "Received: #{String.downcase(value)}"
      _ -> "I don't know how to HANDLE this!"
    end

  end
end
```

- Two actors monitoring each other.

```elixir
defmodule Monitor do
  def start do
    spawn(__MODULE__,:loop_system,[])
  end
  def loop do
    pid = Talker.start_link()
    receive do
      {:EXIT,^pid,:normal} ->
        IO.puts("Talker exited normally")
        :ok
      {:EXIT,^pid,reason} ->
        IO.puts("Talker Failed with reason #{inspect reason} restarting it")
        loop()
    end
  end
  def loop_system do
    Process.flag(:trap_exit, true)
    loop()
    end
end
```

**Main Tasks**

- Queue actor with API helper functions.

As you can see, the actor has helper functions (`pop`, `push`, etc.) which send messages to itself. I've learned more about GenServer behaviour from this task.

```elixir
defmodule Queue do
  def start do
    pid = spawn(__MODULE__,:loop,[[]])
    Process.register(pid,:queue)
    pid
  end
  def loop(queue) do
    receive do
      {pid,:push,value} ->
        queue = queue ++ [value]
        send(pid,queue)
        loop(queue)
      {pid,:pop} ->
        send(pid,List.first(queue))
        cond do
          length(queue) < 1 -> loop([])
          true ->
            [_ | tail] = queue
            loop(tail)
        end
    end
  end
  def push(value) do
    send(:queue,{self(),:push,value})
    receive do
      value -> value
    end
  end

  def pop do
    send(:queue,{self(),:pop})
    receive do
      nil -> "Queue is empty"
      value -> value
    end

  end
end
```

- Semaphore.

On acquire, the actor sends a message to itself, which is granted if there are permits available and the number of permits is reduced by 1. If the number of permits reach 0, the actor is blocked in waiting for a release message, which bumps the nr of free permits back to 1.

```elixir
defmodule Semaphore do
  def start(maxValue) do
    pid = spawn(__MODULE__,:loop,[maxValue,maxValue])
    Process.register(pid,:semaphore)
    pid
  end

  def loop(counter,maxValue) do
    receive do
      {pid,:lock} ->
        case counter do
          0 ->
            send(pid,{:error,"Max permits given.Can't acces critical section.Counter:#{counter}"})
            loop(counter,maxValue)
          _ ->
            send(pid,{:ok,"Welcome to critical Section.Counter:#{counter- 1}"})
            loop(counter - 1,maxValue)
        end
      {pid,:release} ->
        case counter do
          ^maxValue ->
            send(pid,{:error,"Nothing to release.Counter:#{counter}"})
            loop(counter,maxValue)
          _ ->
            send(pid,{:ok,"Lock released.Counter:#{counter+1}"})
            loop(counter+1,maxValue)
        end
    end
  end
  def lock do
    send(:semaphore,{self(),:lock})
    receive do
      value -> value
    end
  end
  def release do
    send(:semaphore,{self(),:release})
    receive do
      value -> value
    end
  end
end
```

**Bonus Tasks**

- Scheduler actor that creates nodes to complete risky biz.

On receiving task, the Scheduler creates a worker and starts monitoring. If it receives a message saying the worker died, it considers the job done if it died for a normal reason, else it creates a new node for the job.

Scheduler:

```elixir
defmodule Scheduler do

  def start do
    pid = spawn(__MODULE__,:loop_system,[])
    Process.register(pid,:scheduler)
    pid
  end
  def loop_system do
    Process.flag(:trap_exit,true)
    loop()
  end
  def loop do
    receive do
      {:gen_worker} ->
        spawn_link(&lousy_worker/0)
      {:EXIT,_,:success} ->
        IO.puts("Task succeeded!")
    end
    loop()
  end
  def lousy_worker do
    send(self(),:work)
    receive do
      _ ->
        cond do
          :rand.uniform(100) <= 50 ->
            IO.puts("Task failed.")
            send(:scheduler,{:gen_worker})
          true ->
            exit(:success)
          end
        end
    end
  def attempt_work do
    send(:scheduler,{:gen_worker})
    "Miau"
  end
end
```

Averager:

```elixir
  defmodule Average do
    def start(initState) do
      IO.puts("The current average is #{initState}")
      spawn(__MODULE__,:loop,[{1,initState}])
    end

    def loop({count,sum}) do
      receive do
        value when is_integer(value) ->
          sum = sum+value
          count = count+1
          IO.puts("The current average is #{sum / count}")
          loop({count,sum})
      end
    end
  end

```

## P0W4

**Minimal Tasls**

- Identical pool of supervised actors.

The Supervisor receives the nr of children as initial argument. It creates the required number of children and gives them all IDs (to be able to address them later, with `get_process`).

```elixir
defmodule SupervisedPool do
    def start(nrOfActors) do
    pid = spawn(__MODULE__,:loop_system,[nrOfActors])
    Process.register(pid,:main)
    pid
  end
  def loop(actors) do
    receive do
      {:EXIT,pid,:normal} ->
        actor = get_actor(actors,pid)
        if actor != nil do
          actors = List.delete(actors,actor)
          pid = spawn_link(__MODULE__,:actor,[actor.id])
          IO.puts("Reviving Actor #{actor.id}")
          loop(actors ++ [%{:pid => pid,:id => actor.id}])
        end
      {:talk,id,phrase} ->
        actor = get_actor(actors,id)
        if actor != nil do
          send(actor.pid,{:talk,phrase})
        end
      {:kill,id} ->
        actor = get_actor(actors,id)
        if actor != nil do
          send(actor.pid,{:kill})
        end
    end
    loop(actors)
  end
  def get_actor(actors,identifier) when is_number(identifier) do
     actor = Enum.find(actors, &(&1.id == identifier))
     cond do
       actor == nil ->
        IO.puts("No such actor")
        nil
       true ->
        actor
     end
  end
  def get_actor(actors,identifier) when is_pid(identifier) do
     actor = Enum.find(actors, &(&1.pid == identifier))
     cond do
       actor == nil ->
        IO.puts("No such actor")
        nil
       true ->
        actor
     end
  end
  def loop_system(nrOfActors) do
    Process.flag(:trap_exit, true)
    actors = spawnActors(nrOfActors)
    loop(actors)
    end
  def actor(id) do
    receive do
      {:talk,phrase} ->
        IO.puts("Actor #{id} says: #{phrase}")
      {:kill} ->
        IO.puts("Actor #{id} was tragically killed.")
        exit(:normal)
    end
    actor(id)
  end
  def kill(id) do
    send(:main,{:kill,id})
  end
  def talk(id,phrase) do
    send(:main,{:talk,id,phrase})
  end
  def spawnActors(nrOfActors,list \\ [])
  def spawnActors(0,list), do: list
  def spawnActors(nrOfActors,_) when nrOfActors < 0, do: "number can't be less than zero"
  def spawnActors(nrOfActors,list) do
    pid = spawn_link(__MODULE__,:actor,[nrOfActors])
    spawnActors(nrOfActors - 1,list ++ [%{:pid => pid,:id => nrOfActors}])
  end
end
```

N actors are initialized upon launch, all of them are addressable by their number, if one is killed it is brought back to life.

**Main Tasks**

- Supervised string processing line.

The Supervisor completes the processing. If any worker dies, all of them are restarted.

```elixir
defmodule ProcessingLine do
  def start do
    pid = spawn(__MODULE__,:loop_system,[])
    send(pid,{:launch,"Monster Energy"})
    pid
  end
  def loop() do
    receive do
      {:EXIT,_,reason} ->
        send(self(),{:launch,Atom.to_string(reason)})
      {:launch,phrase} ->
        splitterPid = spawn_link(__MODULE__,:splitter,[])
        lowerSwapperPid = spawn_link(__MODULE__,:lower_swapper,[])
        joinerPid = spawn_link(__MODULE__,:joiner,[])
        send(splitterPid,{:work,phrase,lowerSwapperPid,joinerPid})
    end
    loop()
  end
  def loop_system do
    Process.flag(:trap_exit,true)
    loop()
  end
    def splitter() do
      receive do
        {:work, string,lowerSwapperPid,joinerPid} ->
          cond do
            :rand.uniform(100) <= 50 ->
              IO.puts("Forgive me, for I have failed you.")
              exit(String.to_atom(string))
            true ->
              IO.puts("Splitter deployed. Initiating split protocol")
              Process.sleep(2500)
              splitString = String.split(string)
              IO.puts("Here is what I did:")
              IO.inspect(splitString)
              send(lowerSwapperPid,{:work,splitString,joinerPid,string})
            end

      end
      splitter()
    end
   def lower_swapper() do
     receive do
       {:work,words,joinerPid,original} ->
        cond do
            :rand.uniform(100) <= 50 ->
              IO.puts("How low have I stooped.")
              exit(String.to_atom(original))
             true ->
               IO.puts("Lower_Swapper deployed. Initiating algorithm...")
               Process.sleep(2500)
               words = Enum.map(words,&(String.downcase(&1)))
              |> Enum.map(&String.replace(&1,~w|m n|, fn
                    "m" -> "n"
                    "n" -> "m" end))
              IO.puts("Here is what I did:")
              IO.inspect(words)
              send(joinerPid,{:work,words,original})
          end
     end
     lower_swapper()
   end
   def joiner() do
     receive do
      {:work, words,original} ->
        cond do
          :rand.uniform(100) <= 50 ->
            IO.puts("I have joined my last join.")
            exit(String.to_atom(original))
          true ->
             IO.puts("Joiner deployed. Prepare to be joined!")
             Process.sleep(2500)
            IO.puts(Enum.join(words," "))
        end
     end
     joiner()
   end
end
```

## P0W5

**Minimal Tasks**

- Application that would:
  - visit the quotes link and print response;
  - extract quotes to list of maps;
  - persists quotes to json.

As you can see, HTTPoison is used to get the HTML, then it is parsed using Floki. Tags and the author are extracted from each quote and added to the map. Lastly, `save_json` persists the extracted quotes to a JSON file.

```elixir
defmodule Quotes do
  def launch do
    response = HTTPoison.get!("https://quotes.toscrape.com/")
    get_request_info(response)
    quotes = get_quotes(response.body)
    save_json(quotes)
  end
  def get_request_info(response) do
    IO.puts(response.body)
    IO.puts("Status code: #{response.status_code}")
    IO.inspect(response.headers)
  end
  def get_quotes(body) do
    Floki.find(body,".quote")
    |> Enum.map(&(%{
      quote: get_quote_text(&1),
      author: get_author(&1),
      tags: get_tags(&1)
    }))
  end
  def get_quote_text(div) do
    Floki.find(div,".text")
    |> Floki.text()
  end
  def get_author(div) do
    Floki.find(div,".author")
    |> Floki.text()
  end
  def get_tags(div) do
    Floki.find(div,".tag")
    |> Enum.map(&(Floki.text(&1)))
  end
   def save_json(quotes) do
    data = Jason.encode!(quotes) |> Jason.Formatter.pretty_print()
    File.write!("quotes.json", data)
  end
end
```

**Main Tasks**

- Star Wars API

For this I used the ETS (a built-in in-memory storage).

The Application itself just starts the DB and Router:

```elixir
defmodule StarWars.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: StarWars.Router, options: [port: 8080]},
      StarWars.Db
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
```

The Router is done using Plug. It has the following endpoints:

```elixir
  get "/movies" do
    movies = StarWars.Db.get_movies()
    send_resp(conn, 200, encode(movies))
  end

  get "/movies/:id" do
    id = String.to_integer(id)
    movie = StarWars.Db.get_movie(id)

    if(movie == nil) do
      send_resp(conn, 200, encode("Movie not found"))
    else
      send_resp(conn, 200, encode(movie))
    end
  end

  post "/movies" do
    movie = for {key, val} <- conn.body_params, into: %{}, do: {String.to_atom(key), val}
    response = StarWars.Db.create_movie(movie)
    send_resp(conn, 201, encode(response))
  end

  put "/movies/:id" do
    id = String.to_integer(id)
    movie = conn.body_params
    response = StarWars.Db.update_movie(id, movie)
    send_resp(conn, 200, encode(response))
  end

  patch "/movies/:id" do
    id = String.to_integer(id)
    movie = StarWars.Db.get_movie(id)

    modified = for {key, val} <- conn.body_params, into: %{}, do: {String.to_atom(key), val}
    needed_modified = Map.take(modified, [:director, :release_year, :title])
    movie = Map.merge(movie, needed_modified)

    response = StarWars.Db.update_movie(id, movie)

    send_resp(conn, 200, encode(response))
  end

  delete "/movies/:id" do
    id = String.to_integer(id)
    StarWars.Db.delete_movie(id)
    send_resp(conn, 200, "Deleted")
  end
```

The DB uses ETS and it has a simple interface supplied by helper functions.

```elixir
defmodule StarWars.Db do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    :ets.new(:movies_table, [:set, :public, :named_table])
    :ok = load_movies_into_table(:movies_table)
    {:ok, :movies_table}
  end

  defp load_movies_into_table(table) do
    movies = ["Excluded big ass list from report"]

    Enum.each(movies, fn movie ->
      :ets.insert(table, {movie[:id], movie})
    end)

    Logger.info("DB initialized & seeded")
  end

  def handle_call(:get_movies, _from, table) do
    Logger.info("Got all movies")
    movies = for {_id, m} <- :ets.tab2list(table), do: m
    {:reply, movies, table}
  end

  def handle_call({:get_movie, id}, _from, table) do
    movies = :ets.lookup(table, id)

    if length(movies) == 0 do
      {:reply, nil, table}
    else
      {_key, movie} = List.first(movies)
      Logger.info("Got movie #{id}")
      {:reply, movie, table}
    end
  end

  def handle_call({:create_movie, movie}, _from, table) do
    id = :ets.info(table, :size) + 1
    created = Map.put(movie, :id, id)
    :ets.insert(table, {id, created})
    Logger.info("Created movie #{inspect(created)}")
    {:reply, :ok, table}
  end

  def handle_call({:update_movie, id, movie}, _from, table) do
    :ets.insert(table, {id, movie})
    Logger.info("Updated movie #{id}: #{inspect(movie)}")
    {:reply, :ok, table}
  end

  def handle_call({:delete_movie, id}, _from, table) do
    :ets.delete(table, id)
    Logger.info("Deleted movie #{id}")
    {:reply, :ok, table}
  end

  def get_movies do
    GenServer.call(__MODULE__, :get_movies)
  end

  def get_movie(id) do
    GenServer.call(__MODULE__, {:get_movie, id})
  end

  def create_movie(movie) do
    GenServer.call(__MODULE__, {:create_movie, movie})
  end

  def update_movie(id, movie) do
    GenServer.call(__MODULE__, {:update_movie, id, movie})
  end

  def delete_movie(id) do
    GenServer.call(__MODULE__, {:delete_movie, id})
  end
end
```

## Conclusion

After completing this laboratory work, I familiarized myself with a large number of concepts regarding functional and declarative programming. It was pretty challenging to find examples or answers to questions since it is not a very wide-spread language, but surprisingly the stack-overflow community was pretty beginner-friendly and my questions were answered in a swift enough manner, giving me a lot of insight into how the lanugage is supposed to be used, for which I am grateful. I found elixir to be quite fun to play with, and I think it would serve as an incredibly potent tool to build backend scalable applications, because of their lightweight processes among many other factors.

## Bibliography

- Elixir Documentation https://elixir-lang.org/docs.html
- Plug Documentation https://hexdocs.pm/plug/readme.html
- Floki Documentation https://github.com/philss/floki
- Jason Documentation https://hexdocs.pm/jason/Jason.html#encode/2
- Supervisor/GenServer Documentation https://hexdocs.pm/elixir/1.12/Supervisor.html
- Elixir in Action, Sasa Juric, 2019, Manning Publications
- Seven Concurrency Models in Seven Weeks (Ch. 5), Paul Butcher
