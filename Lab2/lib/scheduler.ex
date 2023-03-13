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
