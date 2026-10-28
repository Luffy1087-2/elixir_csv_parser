defmodule CsvParser.Reader do
  @moduledoc """
  Documentation for `FileReader`.
  """

  @doc """
  Lists CSV files in the csv directory and returns the chosen file by the user.

  ## Examples

      iex> FileReader.read_csv_files()
      :Strings

  """

  def read_csv_files() do
    # Get the list of CSV files in the csv directory with the proper index
    files = Path.wildcard("csv/*.csv") |> Enum.with_index(1)
    case files do
      [] ->
        IO.puts("\nno CSV files found in the csv directory.")
        nil
      _ ->
        IO.puts("\ntype the index of the file you want to parse:")
        map = files
        |> Enum.map(fn {f, i} ->
          IO.puts("#{i}) #{f}")
          {"#{i}", f}
        end)
        |> Map.new()
        index = IO.gets("> ") |> String.trim()
        IO.puts("\nUser chose the index #{index}\n")
        chosenFile = map[index]
        chosenFile
    end #case
  end #method

 end #module
