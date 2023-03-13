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
