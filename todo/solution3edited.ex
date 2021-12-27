matcher = ~r/\.(jpg|jpeg|gif|png|bmp)$/
matched_files = File.ls!() |> Enum.filter(&Regex.match?(matcher, &1))
# same as Enum.filter(fn x -> Regex.match?(matcher, x) end)

num_matched = matched_files |> Enum.count()

msg_end =
  case num_matched do
    1 -> "file"
    _ -> "files"
  end

IO.puts("Matched #{num_matched} #{msg_end}")

case File.mkdir("./images") do
  :ok ->
    IO.puts("./images directory succesfully created")

  {:error, reason} ->
    IO.puts("Could not create ./images directory\n Reason: #{:file.format_error(reason)}")
end

Enum.each(matched_files, fn filename ->
  case File.rename(filename, "./images/#{filename}") do
    :ok -> IO.puts("#{filename} successfully moved to images directory")
    {:error, reason} -> IO.puts("Error moving #{filename} to images directory\n Reason: #{:file.format_error(reason)")
  end
end)
