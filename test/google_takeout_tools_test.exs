defmodule GoogleTakeoutToolsTest do
  use ExUnit.Case
  alias GoogleTakeoutTools.Results
  alias GoogleTakeoutTools.SongReader.Song

  doctest GoogleTakeoutTools

  test "can export a list of tracks to a text file" do
    {:ok, pid} = Results.start_link({})

    Results.add_entry_for(%Song{title: "Happy", album: "Hoover", artist: "Kid", playcount: 30})
    Results.add_entry_for(%Song{title: "Robble", album: "Hoover", artist: "Kid", playcount: 3})
    Results.add_entry_for(%Song{title: "Roy", album: "Hoover", artist: "Kid", playcount: 0})
    Results.add_entry_for(%Song{title: "Beans", album: "Hoover", artist: "Kid", playcount: 122})

    output_file = Application.fetch_env!(:google_takeout_tools, :output_file)

    assert Results.save() == {:ok, 4}
    assert File.exists?(output_file)

    File.rm(output_file)
    Process.exit(pid, :kill)
  end
end
