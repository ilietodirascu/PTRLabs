defmodule Ptrlabs do
  @pi 3.14159
  @dictionary %{
    "mama" => "mother",
    "papa" => "father"
  }
  @dict %{"2" => ["a","b","c"], "3" => ["d","e","f"], "4" => ["g","h","i"], "5" => ["j","k","l"], "6" => ["m","n","o"], "7" => ["p","q","r"], "8" => ["s","t","u"],"9" => ["v","w","x"]}

   @moduledoc """
    Provides methods for passing the PTR course.
  """

@doc """
  Returns an honest greeting.
## Examples
      iex> Ptrlabs.greetPTR
      "hello PTR"

"""
  def greetPTR do
    "hello PTR"
  end
  def factors(1), do: [1]
  def factors(n) when n < 1 do
    "Please input a number greater than 0"
  end
  def factors(2), do: [1,2]
  def factors(n) do
    Enum.filter(1..floor(n/2), fn x -> rem(n,x) == 0 end) ++ [n]
  end
@doc """
  Checks if a given number is prime
## Examples
      iex> Ptrlabs.prime?(3)
      true
"""
  def prime?(n) do
    [1,n] === factors(n)
  end

@doc """
  Returns the area of a cylinder given the radius and the height
## Examples
      iex> Ptrlabs.cylinderArea(3,4)
      175.92904
"""
  def cylinderArea(h,r) do
    2*@pi*r*h + 2*@pi * :math.pow(r,2)
  end
@doc """
  Returns the reverse of a given list
## Examples
      iex> Ptrlabs.reverse([1,2,3])
      [3,2,1]
"""
  def reverse(list) do
    Enum.reverse(list)
  end

@doc """
  Returns the sum of unique elements of a given list
## Examples
      iex> Ptrlabs.uniqueSum([1,2,4,8,4,2])
      15
"""
  def uniqueSum(list) do
    Enum.uniq(list) |> Enum.sum
  end
@doc """
  Returns a list of n elements randomly selected from a given list
## Examples
      iex>test = Ptrlabs.extractRandomN([1,2,3,4,8,4],3)
      iex>length(test) == 3 && MapSet.subset?(MapSet.new(test),MapSet.new([1,2,3,4,8,4]))
      true
"""
  def extractRandomN(list, n) do
    Enum.take_random(list,n)
  end

  def firstFibonacciElements(n) when n < 3 do
    "first two elements are [1,1]"
  end
@doc """
  Return n fibonacci numbers,starting from 1
## Examples
      iex>Ptrlabs.firstFibonacciElements(7)
      [1,1,2,3,5,8,13]
"""
  def firstFibonacciElements(n) do
    fib([1,1],n)
  end
  def fib(list,n) do
    list = list ++ [Enum.slice(list,-2..-1) |> Enum.sum]
    case length(list) < n do
      true -> fib(list,n)
      false -> list
    end
  end
  def translator(dictionary,original_string) when not is_map(dictionary) do
    translator(@dictionary,original_string)
  end
@doc """
  Given a dictionary and a string returns a string containing the translated version of all the words that matched. A word is considered a substring that is followed
  by a ' ' character. If the first argument is not a map the default dictionary will be used stored in the module as @dictionary.
## Examples
      iex> Ptrlabs.translator(1,"mama is with papa")
      "mother is with father"
"""
  def translator(dictionary,original_string) when is_map(dictionary) do
    split_string = String.split(original_string, "\s")
    for word <- split_string do
      cond do
        dictionary[word] == nil -> word
        true -> dictionary[word]
      end
    end
    |> Enum.join(" ")
  end
  def smallestNumber([]), do: "Can't be empty"
@doc """
  Given a list of numbers returns the smallest number that can be obtained by arranging the numbers. A number can't start with a 0
## Examples
      iex>Ptrlabs.smallestNumber([3,2,1])
      123
      iex>Ptrlabs.smallestNumber([0,5,1])
      105
      iex>Ptrlabs.smallestNumber([])
      "Can't be empty"
"""
  def smallestNumber(list) do
    {head , tail } = Enum.split_while(Enum.sort(list),fn x -> x === 0 end)
    List.insert_at(tail,1,head)
    |> List.flatten
    |> Enum.join
    |> String.to_integer
  end

@doc """
  Rotates a given list count number of places and returns it.
## Examples
      iex>Ptrlabs.rotateLeft([1,2,4,8,4],3)
      [8,4,1,2,4]
      iex>Ptrlabs.rotateLeft([1,2,4,8,4],5)
      [1,2,4,8,4]
      iex>Ptrlabs.rotateLeft([1,2,4,8,4],101)
      [2,4,8,4,1]
"""
  def rotateLeft(list,count) do
    {head,tail} = Enum.split(list,rem(count,length(list)))
    List.flatten([tail | head])
  end
@doc """
  Returns a list of all the possible values for the lengths of the sides of a valid right angled triangle, where the length of the base
  and the perpendicular can't exceed 20.
"""
  def listRightAngleTriangles do
    numbers = 1..20
    for a <- numbers, b <- numbers do
      power = :math.pow(a,2) + :math.pow(b,2)
      c = Enum.filter(1..20,fn x -> :math.pow(x,2) == power end)
      cond  do
        [] != c -> [a | [b | c]]
        true -> []
      end
  end
  |> Enum.filter(fn x -> x != [] end)
  |> Enum.uniq
end

@doc """
  Returns a given list without consecutive duplicates
## Examples
      iex>Ptrlabs.removeConsecutiveDuplicates([1,2,2,2,4,8,4])
      [1,2,4,8,4]
"""
  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end

@doc """
  Given a list of strings returns the ones that could be written using only the buttons from one row of a qwerty keyboard
## Examples
      iex>Ptrlabs.lineWords(["hello","alaska","dad","peace"])
      ["alaska","dad"]
"""
  def lineWords(list) do
    lines = ["qwertyuiop","asdfghjkl","zxcvbnm"]
    Enum.filter(list,
      fn lsItem ->
        Enum.any?(lines, fn lineItem -> MapSet.subset?(MapSet.new(String.codepoints(lsItem)), MapSet.new(String.codepoints(lineItem))) end )
      end)
    end
  def encode(plaintext,0) do
    plaintext
  end
@doc """
  Returns the ciphertext of a caesar cipher encoding given a plaintext and a key.Works with upper and lower case.
## Examples
      iex>Ptrlabs.encode("lorem",3)
      "oruhp"
      iex>Ptrlabs.encode("lOrEm",3)
      "oRuHp"
"""
  def encode(plaintext,key) do
    to_string(Enum.map(to_charlist(plaintext),
    fn x ->
      shift(getCase(x),x,key)
      end
     ))
  end
@doc """
  Returns the plaintext of a caesar cipher encoding given a ciphertext and a key.Works with upper and lower case.
## Examples
      iex>Ptrlabs.decode("oRuHp",3)
      "lOrEm"
      iex>Ptrlabs.decode("oruhp",3)
      "lorem"
"""
  def decode(ciphertext,key) do
    encode(ciphertext,-key)
  end
  def shift(minmax,char,key) do
    [min | max] = minmax
    operation = char + rem(key,26)
    cond do
      operation < min ->
        26 + operation
      operation > List.first(max) ->
         operation - 26
      true -> operation
    end
  end
 def getCase(char) do
    case max(char,?Z) do
      ^char -> [?a | [?z|[]]]
      ?Z -> [?A | [?Z | []]]
    end
 end
 def letterCombination(""), do: [""]

 @doc """
  Given a string of digits from 2 to 9 returns all possible letter combinations that the number could represent
## Examples
    iex>Ptrlabs.letterCombination("23")
    ["ad","ae","af","bd","be","bf","cd","ce","cf"]
"""
 def letterCombination(<<key::binary-1, rest::binary>>) do
   for letter <- @dict[key], tail <- letterCombination(rest), do: letter <> tail
 end

 def comb(list,k,fList) do
  case length(fList) < arrangements(length(list),k) do
    true ->
      comb(list,k,Enum.uniq(fList ++ [Enum.join(Enum.take_random(list,k))]))
    false -> fList
  end
 end
 def factorial(0) do
  1
 end
 def factorial(number) do
  number * factorial(number-1)
 end
 def arrangements(n,r) do
  factorial(n) /(factorial(r) * (factorial(n-r)))
 end
@doc """
  Returns the prime factors of a given number
## Examples
      iex>Ptrlabs.factorize(42)
      [2,3,7]
"""
 def factorize(number) when number <= 1 ,do: []
 def factorize(number) do
  # factorize(Enum.filter(factors(number),fn x -> prime?(x) == true end),number)
  factorize(Enum.filter(factors(number),&(prime?(&1)) == true),number)
 end
 def factorize([head | tail],number) do
  factorsProduct = Enum.product([head | tail])
  cond do
    factorsProduct != number -> factorize([head | tail] ++ [Enum.max(factorize(Integer.floor_div(number,factorsProduct)))],number)
    true -> Enum.sort([head | tail])
  end
 end
 def commonPrefix([]), do: []
@doc """
 Returns the longest common prefix from a given list of strings
## Examples
      iex>Ptrlabs.commonPrefix(["alpha" , "beta" , "gamma"])
      ""
      iex>Ptrlabs.commonPrefix (["flower" ,"flow" ,"flight"])
      "fl"
"""
 def commonPrefix(words) do
  for word <- words do
    String.codepoints(word)
  end
  |> magic(1)

 end
@doc """
 Given an array of strings, returns a map with the grouped anagrams
## Examples
      iex>Ptrlabs.groupAnagrams(["eat","tea","tan","ate","nat","bat"])
      %{"abt" => ["bat"], "aet" => ["eat", "tea", "ate"], "ant" => ["tan", "nat"]}
"""
 def groupAnagrams(strings) do
  Enum.group_by(strings, &(String.codepoints(&1) |> Enum.sort |> Enum.join))
end
 def magic(words,count) when count <= length(words) do
  cond do
   Enum.all?(words, fn x -> Enum.slice(List.first(words),0,count) == Enum.slice(x,0,count) end) === true -> magic(words,count+1)
   true -> Enum.join(Enum.slice(List.first(words),0,count-1))
  end
 end
end
