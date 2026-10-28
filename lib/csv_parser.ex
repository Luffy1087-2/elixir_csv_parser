defmodule CsvParser do
  use Application

  @impl true
  def start(_type, _args) do
    chosen_file = CsvParser.Reader.read_csv_files()
    case chosen_file do
      file when is_binary(file) and file != "" ->
        CsvParser.Parser.parse_csv_to_json(chosen_file)

      _ ->
        IO.puts("No CSV file was chosen. Please select a valid CSV file to proceed.")
    end
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
