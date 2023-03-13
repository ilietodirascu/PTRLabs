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
