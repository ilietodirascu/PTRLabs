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
