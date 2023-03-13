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
