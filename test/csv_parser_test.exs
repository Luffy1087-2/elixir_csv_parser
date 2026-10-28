defmodule CsvParserTest do
  use ExUnit.Case
  doctest CsvParser.Parser

  import ExUnit.CaptureIO # Read the output

  # This creates a temporary csv file and remove it after the process exits
  setup do
    csv_content = """
    name,age,city
    Alice,30,Roma
    Bob,25,Milano
    """

    file_path = "test_reader.csv"
    File.write!(file_path, csv_content)

    on_exit(fn ->
      if File.exists?(file_path), do: File.rm!(file_path)
    end)

    %{file_path: file_path}
  end

  test "converte il CSV stampando i JSON corretti a schermo", %{file_path: file_path} do
    # Capture the output
    output = capture_io(fn ->
      CsvParser.Parser.parse_csv_to_json(file_path)
    end)

    # Verify the outout contains this:
    assert output =~ "\"{\\\"age\\\":\\\"30\\\",\\\"city\\\":\\\"Roma\\\",\\\"name\\\":\\\"Alice\\\"}\""
    # And this:
    assert output =~ "\"{\\\"age\\\":\\\"25\\\",\\\"city\\\":\\\"Milano\\\",\\\"name\\\":\\\"Bob\\\"}\""
  end

end
