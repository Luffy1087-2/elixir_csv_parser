defmodule CsvParser.CsvSelectorTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias CsvParser.CsvSelector

  # Automatically creates a unique, isolated temporary directory for each test
  @moduletag :tmp_dir

  describe "read_csv_files/1" do
    test "returns nil when there are no csv", %{tmp_dir: tmp_dir} do
      # tmp_dir is an empty temporary folder provided by ExUnit
      assert CsvSelector.read_csv_files(tmp_dir) == nil
    end

    test "the directory contains two files and the user select the second one", %{tmp_dir: tmp_dir} do
      # Create mock CSV files inside the isolated directory
      file1 = Path.join(tmp_dir, "file1.csv")
      file2 = Path.join(tmp_dir, "file2.csv")
      File.touch!(file1)
      File.touch!(file2)

      # Simulate the user typing "2" followed by the Enter key
      capture_io([input: "2\n"], fn ->
        result = CsvSelector.read_csv_files(tmp_dir)
        assert result == file2
      end)
    end

    test "returns nil when the user inputs a wrong index", %{tmp_dir: tmp_dir} do
      file1 = Path.join(tmp_dir, "file1.csv")
      File.touch!(file1)

      # Simulate the user entering a non-existent index ("99")
      capture_io([input: "7\n"], fn ->
        result = CsvSelector.read_csv_files(tmp_dir)
        assert result == nil
      end)
    end
  end
end
