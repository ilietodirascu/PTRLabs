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
