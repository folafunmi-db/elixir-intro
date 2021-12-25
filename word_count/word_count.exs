filename =
  IO.gets("File to count the words from: ")
  |> String.trim()

# In iex use Code.load_file "***name_of_file"
words =
  File.read!(filename)
  # regex to catch contractions and non word characters
  |> String.split(~r{(\\n|[^\w'])+})
  # filter for empty string using an anonymous function
  |> Enum.filter(fn x -> x != "" end)

# IO.inspect(words)

words |> Enum.count() |> IO.puts()
