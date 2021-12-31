defmodule Todo do
  def start do
    load_csv()

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

  def add_todo(data) do
    # get name
    name = get_item_name(data)
    # get titles
    titles = get_fields(data)

    # get field values from user
    fields = Enum.map(titles, fn field -> field_from_user(field) end)

    # create todo
    new_todo = %{name => Enum.into(fields, %{})}
    IO.puts("New todo #{name} added.")

    # merge into data
    new_data = Map.merge(data, new_todo)

    # what next
    get_command(new_data)
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

  def field_from_user(name) do
    field = IO.gets("#{name}: ") |> String.trim()

    case field do
      _ -> {name, field}
    end
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
      "a" -> add_todo(data)
      "r" -> read(data)
      "d" -> delete_todos(data)
      "l" -> load_csv()
      "q" -> IO.puts("Goodbye!")
      _ -> get_command(data)
    end
  end

  def get_fields(data) do
    data[hd(Map.keys(data))] |> Map.keys()
  end

  def get_item_name(data) do
    name =
      IO.gets("Enter the name of the new todo: ")
      |> String.trim()

    if Map.has_key?(data, name) do
      IO.puts("Todo with the name already exists!\n")
      get_item_name(data)
    else
      name
    end
  end

  def load_csv() do
    filename = IO.gets("Name of .csv to load: ") |> String.trim()

    read(filename)
    |> parse
    |> get_command
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
