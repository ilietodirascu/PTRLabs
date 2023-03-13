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
