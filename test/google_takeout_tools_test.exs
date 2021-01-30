defmodule GoogleTakeoutToolsTest do
  use ExUnit.Case
  alias GoogleTakeoutTools.Results
  alias GoogleTakeoutTools.SongReader.Song

  doctest GoogleTakeoutTools

  test "can create a list of tracks, sorted by play count" do
    Results.add_entry_for(%Song{title: "Happy", album: "Sad", artist: "Kid", playcount: 30})
    Results.add_entry_for(%Song{title: "Robble", album: "Sad", artist: "Kid", playcount: 3})
    Results.add_entry_for(%Song{title: "Roy", album: "Sad", artist: "Kid", playcount: 0})
    Results.add_entry_for(%Song{title: "Beans", album: "Sad", artist: "Kid", playcount: 122})

    assert Results.save() == { :ok, 4}
  end
end
