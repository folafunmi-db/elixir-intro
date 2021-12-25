defmodule Greeter do
  # greet a user
  # state your name
  # ask for their name
  # if they enter your name as theirs do something special

  def hello do
    IO.puts("Hi there, my name is Folafunmi. ")
    res = IO.gets("What is your name? \n")

    case String.trim(res) do
      "Folafunmi" -> IO.puts("No, that's my name.")
      _ -> IO.puts("Hi there, #{String.trim(res)} ")
    end
  end
end
