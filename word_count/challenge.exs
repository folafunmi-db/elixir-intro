# user should be able to count the number of words,
# characters or lines in a file

IO.puts("Welcome User,")

filename =
  IO.gets("What's the file name: ")
  |> String.trim()

res = IO.gets("What would you like to count (words(w)/characters(ch)/lines(l)): \n")

case String.trim(res) do
  "words" ->
    words =
      File.read!(filename)
      |> String.split(~r{(\\n|[^\w'])+})
      # filter for empty string using an anonymous function
      |> Enum.filter(fn x -> x != "" end)

    words |> Enum.count() |> IO.puts()

  "w" ->
    words =
      File.read!(filename)
      |> String.split(~r{(\\n|[^\w'])+})
      # filter for empty string using an anonymous function
      |> Enum.filter(fn x -> x != "" end)

    words |> Enum.count() |> IO.puts()

  "characters" ->
    characters =
      File.read!(filename)
      |> String.split("")
      # filter for empty string using an anonymous function
      |> Enum.filter(fn x -> x != "" end)

    characters |> Enum.count() |> IO.puts()

  "ch" ->
    characters =
      File.read!(filename)
      |> String.split("")
      # filter for empty string using an anonymous function
      |> Enum.filter(fn x -> x != "" end)

    characters |> Enum.count() |> IO.puts()

  "lines" ->
    lines =
      File.read!(filename)
      |> String.split(~r{(\r\n|\n|\r)})
      # filter for empty string using an anonymous function
      |> Enum.filter(fn x -> x != "" end)

    lines |> Enum.count() |> IO.puts()

  "l" ->
    lines =
      File.read!(filename)
      |> String.split(~r{(\r\n|\n|\r)})
      # filter for empty string using an anonymous function
      |> Enum.filter(fn x -> x != "" end)

    lines |> Enum.count() |> IO.puts()

  _ ->
    IO.puts(~s{Type "words" or "w" for words,
              "characters" or "ch" for characters or,
              "lines or "l" for lines})
end
