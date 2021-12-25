defmodule GuessingGame do
  # guess between a low number and a high -> guess middle number
  # tell user our guess
  # 'yes' -> game over
  # 'bigger' -> bigger (low, high)
  # 'smaller' -> smaller (low, high)
  # anything else -> tell user to enter a valid reponse

  # if this matches it'd get executed and the 'guess' functions underneath will not and vive versa
  def guess(a, b) when a > b, do: guess(b, a)

  def guess(low, high) do
    # IO.puts(low)
    # IO.puts(high)
    IO.puts("Maybe your number is: #{mid(low, high)}\n")
    res = IO.gets("Is that your number (yes/bigger/smaller): ")
    # IO.puts(res)

    case String.trim(res) do
      "yes" ->
        IO.puts("Ha!, I'm an evil genuis!!!!")

      "bigger" ->
        smaller(low, high)

      "smaller" ->
        bigger(low, high)

      _ ->
        IO.puts(~s{Type "yes", "bigger" if it's bigger or "smaller" if it's smaller})
        guess(low, high)
    end
  end

  def mid(low, high) do
    div(low + high, 2)
  end

  def bigger(low, high) do
    new_low = min(high, mid(low, high) + 1)
    guess(new_low, high)
  end

  def smaller(low, high) do
    new_high = max(low, mid(low, high) - 1)
    guess(low, new_high)
  end
end
