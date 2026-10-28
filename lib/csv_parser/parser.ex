defmodule CsvParser.Parser do
  @moduledoc """
  Documentation for `CsvParser`.
  """

  defp get_json_line(header, line) do
    map = line
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.with_index(0)
    |> Enum.reduce(%{}, fn {colValue, index}, acc ->
      Map.put(acc, header[index], colValue)
    end )

    IO.inspect(JSON.encode!(map))
  end

  def parse_csv_to_json(file_path) do
    IO.puts("Parsing CSV file: #{file_path}\n")
    stream = File.stream!(file_path)

    # Header
    [headerString] = stream |> Enum.take(1)
    header = headerString
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.with_index(0)
    |> Map.new(fn {col, i} -> {i, col} end)

    # Line data
    stream
    |> Stream.drop(1)
    |> Stream.map(fn line -> get_json_line(header, line) end)
    |> Stream.run()

  end
end
