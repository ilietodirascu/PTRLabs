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
