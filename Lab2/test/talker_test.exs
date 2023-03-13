defmodule TalkerTest do
  use ExUnit.Case
  doctest Talker
  test "Talker" do
    pid = Talker.start_link
    send(pid,{self(),"hello"})
    message = receive do
      message -> message
    end
    assert "Talker says: hello" == "Talker says: #{message}"
  end
  test "Modifier" do
    pid = spawn(&Modifier.loop/0)
    assert Modifier.modify(pid,"HELLO") == "Received: hello"
    assert Modifier.modify(pid,1) == 2
    assert Modifier.modify(pid,%{}) == "I don't know how to HANDLE this!"
  end

end
