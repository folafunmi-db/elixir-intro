defmodule Todo do
  def start do
    filename = IO.gets("Name of .csv to load: ") |> String.trim()

    read(filename)
    |> parse
    |> get_command

    # ask user for file name - done
    # open the file - done
    # parse the data
    # ask user for command
    # read todo
    # add todo
    # delete todo
    # load file
    # save file
  end

  def get_command(data) do
    prompt = """
    Type the first letter of the command you want to run
    Read Todos(r)
    Add Todos(a)
    Delete Todos(d)
    Load a csv file(l)
    Save a csv file(s)
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    case command do
      "r" -> read(data)
      "d" -> delete_todos(data)
      "q" -> IO.puts("Goodbye!")
      _ -> get_command(data)
    end
  end

  def delete_todos(data) do
    todo = IO.gets("Which of the todos do you want to delete?\n") |> String.trim()

    if Map.has_key?(data, todo) do
      IO.puts("Ok")
      new_map = Map.drop(data, [todo])
      IO.puts(~s("#{todo}" has been deleted.))
      get_command(new_map)
    else
      IO.puts(~s(There's is no todo named "#{todo}"!))
      show_todo(data, false)
      delete_todos(data)
    end
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s(Could not open file "#{filename}"\n))
        # to provide human readable errors
        IO.puts(~s("#{:file.format_error(reason)}"\n))
        start()
    end
  end

  def parse(body) do
    [header | lines] =
      body
      |> String.split(~r{(\r\n|\n|\r)})
      |> Enum.filter(fn x -> x != "" end)

    # number_of_todos = lines |> Enum.count() |> IO.puts()
    titles = header |> String.split(",") |> tl

    parse_lines(lines, titles)
  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) == Enum.count(titles) do
        line_data = Enum.zip(titles, fields) |> Enum.into(%{})
        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  def show_todo(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following Todos: \n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")

    if next_command? do
      get_command(data)
    end
  end
end
