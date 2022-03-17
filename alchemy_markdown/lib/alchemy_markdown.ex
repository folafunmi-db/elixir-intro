defmodule AlchemyMarkdown do
  def to_html(string) do
    string
    |> hrs()
    |> earmark()
    |> big()
    |> small()
  end

  def earmark(string) do
    Earmark.as_html!(string || "", %Earmark.Options{smartypants: false})
  end

  def big(text) do
    Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
  end

  def small(text) do
    Regex.replace(~r/\-\-(.*)\-\-/, text, "<small>\\1</small>")
  end

  def hrs(text) do
    Regex.replace(~r{(^|\r\n|\r|\n)([-*])( *\2 *)+\2}, text, "\\1<hr />")
  end

  def test_str do
    """
    # Main title

    I *liked* this **thing**

    What did *you* think?

    My list

    - one
    - two
    - three

    ++big things++

    --small things--

    """
  end

  def write_to_file(output) do
    File.write("output.html", output)
  end

  def run() do
    test_str() |> to_html() |> write_to_file()
  end
end
