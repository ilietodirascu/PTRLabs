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
