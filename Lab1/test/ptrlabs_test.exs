defmodule PtrlabsTest do
  use ExUnit.Case
  doctest Ptrlabs

  test "was greeting received" do
      assert Ptrlabs.greetPTR === "hello PTR"
  end

  test "primes" do
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]
    assert Enum.all?(primes,fn x -> Ptrlabs.prime?(x) end)
  end

  test "right Angles" do
    assert Ptrlabs.listRightAngleTriangles === [
      [3, 4, 5],
      [4, 3, 5],
      [5, 12, 13],
      [6, 8, 10],
      [8, 6, 10],
      [8, 15, 17],
      [9, 12, 15],
      [12, 5, 13],
      [12, 9, 15],
      [12, 16, 20],
      [15, 8, 17],
      [16, 12, 20]
    ]
  end
  test "factorize returns prime factors of a number" do
    assert Ptrlabs.factorize(1) == []
    assert Ptrlabs.factorize(2) == [2]
    assert Ptrlabs.factorize(3) == [3]
    assert Ptrlabs.factorize(4) == [2, 2]
    assert Ptrlabs.factorize(12) == [2, 2, 3]
    assert Ptrlabs.factorize(13) == [13]
    assert Ptrlabs.factorize(29) == [29]
    assert Ptrlabs.factorize(42) == [2,3,7]
    assert Ptrlabs.factorize(56) == [2, 2, 2, 7]
    assert Ptrlabs.factorize(100) == [2, 2, 5, 5]
    assert Ptrlabs.factorize(1000000) == [2, 2, 2, 2, 2, 2, 5, 5, 5, 5, 5, 5]
  end

  test "factorize returns an empty list for 1" do
    assert Ptrlabs.factorize(1) == []
  end
end
