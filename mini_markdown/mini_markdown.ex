defmodule MiniMarkdown do
  def to_html(text) do
    # do lots of transforms in a pipeline
    text
    |> bold()
    |> italics()
    |> p()
    |> output()
  end

  def bold(text) do
    Regex.replace(~r/\*\*(.*)\*\*/, text, "<strong>\\1</strong>")
  end

  def italics(text) do
    Regex.replace(~r/\*(.*)\*/, text, "<em>\\1</em>")
  end

  def p(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)+([^\r\n]+)((\r\n|\r|\n)+$)?/, text, "<p>\\2</p>")
  end

  def test_str do
    """
    I *liked* this **thing**

    What did *you* think?

    """
  end

  def finish(trimmed, md)
      when is_binary(trimmed) and
             byte_size(trimmed) > 0 do
    File.write!("#{trimmed}.html", md)
  end

  def output(md) do
    file_name = IO.gets("What do you want to name the output file: \n")

    trimmed = file_name |> String.trim()
    finish(trimmed, md)
  end
end
