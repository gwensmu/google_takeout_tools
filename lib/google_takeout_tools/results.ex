defmodule GoogleTakeoutTools.Results do
  use GenServer

  @moduledoc """
  Manages a collection of songs and writes details about them to a file,
  for consumption by the playlist import tool 'Tune My Music'.
  """

  @me __MODULE__

  # API

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def add_entry_for(song) do
    GenServer.cast(@me, {:add, song})
  end

  # Output format is list of songs: Artist - title
  # Suitable for import into tidal via tune my music "free text" field
  def save do
    GenServer.call(@me, :save)
  end

  # Server

  def init(:no_args) do
    {:ok, MapSet.new()}
  end

  def handle_call(:save, _from, results) do
    content =
      MapSet.to_list(results)
      |> Enum.sort_by(&Map.fetch(&1, :playcount), :desc)
      |> Enum.reduce("", fn song, string -> print(song, string) end)

    File.write(Application.fetch_env!(:google_takeout_tools, :output_file), content)
    {:reply, {:ok, MapSet.size(results)}, results}
  end

  def handle_cast({:add, song}, playlist) do
    playlist = MapSet.put(playlist, song)
    {:noreply, playlist}
  end

  defp print(song, string) do
    string <> "#{song.artist} - #{song.title}\n"
  end
end
