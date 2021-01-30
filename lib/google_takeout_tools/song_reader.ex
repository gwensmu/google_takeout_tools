defmodule GoogleTakeoutTools.SongReader do
  use GenServer, restart: :transient

  defmodule Song do
    defstruct title: nil, album: nil, artist: nil, playcount: 1
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    Process.send_after(self(), :parse_one_file, 0)
    { :ok, nil }
  end

  def handle_info(:parse_one_file, _) do
    GoogleTakeoutTools.PathFinder.next_path()
    |> add_song()
  end

  def add_song(nil) do
    GoogleTakeoutTools.Music.done()
    {:stop, :normal, nil}
  end

  def add_song(file) do
    if Path.extname(file) == ".csv" do
      {:ok, row } = file
      |> Path.expand(__DIR__)
      |> File.stream!
      |> CSV.decode(headers: [:title, :album, :artist, :duration, :rating, :playcount, :removed])
      |> Enum.at(1)

      song = %Song{title: row[:title], album: row[:album], artist: row[:artist], playcount: row[:playcount]}
      GoogleTakeoutTools.Music.add_to_playlist(song)
    end

    send(self(), :parse_one_file)
    { :noreply, nil }
  end
end
