# FAF.PTR16.1 -- Project 0,1

> **Performed by:** Ilie Todirascu, group FAF-203
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W1

Please check the index.html from doc.

## Conclusion

This laboratory work helped me familiarize with the syntax of Elixir. I also learned about the inbuilt support for unit tests and code documentation
that comes out of the
box with elixir, which I used to a large extent. I also struggled and failed to change my mindset to align with the declarative paradigm. I find it
much harder to read and write. I still can't wrap my head around the fact that elixir doesn't care if the elements of a list coincide with the ascii value for
a character, which gave me a lot of headaches for the factorization function, since if I were to pass a prime number as an argument, more often than not it will return
something like '/r' a behaviour which can only be changed by configuring the configuration like so
IEx.configure(inspect: [charlists: :as_lists]).
But at the same time it was quite rewarding to learn something new.

## Bibliography

https://stackoverflow.com/
https://hexdocs.pm/elixir/1.12/
https://elixir-lang.org/getting-started/case-cond-and-if.html
https://elixirschool.com/en/lessons/basics/comprehensions
