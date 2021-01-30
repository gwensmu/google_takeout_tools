defmodule GoogleTakeoutTools.Results do
  use GenServer

  @me __MODULE__

  # API

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def add_entry_for(song) do
    GenServer.cast(@me, { :add, song })
  end

  def save() do
    GenServer.call(@me, :save)
  end

  # Server

  def init(:no_args) do
    { :ok, MapSet.new() }
  end

  def handle_call(:save, _from, results) do
    content = MapSet.to_list(results)
      |> Enum.sort_by(&Map.fetch(&1, :playcount), :desc)
      |> Enum.reduce("", fn song, string -> print(song, string) end)

      # todo: make this configurable
      File.write("playlist.txt", content)
    { :reply, {:ok, MapSet.size(results) }, results }
  end

  def handle_cast({ :add, song }, playlist) do
    playlist =
      MapSet.put(playlist, song)
    { :noreply, playlist }
  end

  defp print(song, string) do
    string <> "'#{song.title}', by #{song.artist} (#{song.playcount})\n"
  end
end
