defmodule AlchemyMarkdownTest do
  use ExUnit.Case
  doctest AlchemyMarkdown

  test "italicizes" do
    str = "New *stuff*"
    assert AlchemyMarkdown.to_html(str) =~ "<em>stuff</em>"
  end

  test "expand big tags" do
    str = "New ++stuff++"
    assert AlchemyMarkdown.to_html(str) =~ "<big>stuff</big>"
  end

  test "expand small tags" do
    str = "New --stuff--"
    assert AlchemyMarkdown.to_html(str) =~ "<small>stuff</small>"
  end

  test "expand hr tags" do
    str1 = "Stuff over the line\n---"
    str2 = "Stuff over the line\n***"
    str3 = "Stuff over the line\n-  -  -"
    str4 = "Stuff over the line\n*  *  *"
    str5 = "Stuff over the line*  *  *"

    Enum.map(
      [str1, str2, str3, str4],
      fn str -> assert(AlchemyMarkdown.hrs(str) == "Stuff over the line\n<hr />") end
    )

    assert(AlchemyMarkdown.hrs(str5) == str5)
  end
end
