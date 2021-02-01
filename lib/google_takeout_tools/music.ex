defmodule GoogleTakeoutTools.Music do
  use GenServer

  @me Music

  # API
  def start_link(worker_count) do
    GenServer.start_link(__MODULE__, worker_count, name: @me)
  end

  def done() do
    GenServer.cast(@me, :done)
  end

  def add_to_playlist(song) do
    GenServer.cast(@me, {:add, song})
  end

  # server

  def init(worker_count) do
    Process.send_after(self(), :kickoff, 0)
    {:ok, worker_count}
  end

  def handle_info(:kickoff, worker_count) do
    1..worker_count
    |> Enum.each(fn _ -> GoogleTakeoutTools.SongReaderSupervisor.add_worker() end)

    {:noreply, worker_count}
  end

  def handle_cast(:done, _worker_count = 1) do
    save_playlist()
    System.halt(0)
  end

  def handle_cast(:done, worker_count) do
    {:noreply, worker_count - 1}
  end

  def handle_cast({:add, song}, worker_count) do
    GoogleTakeoutTools.Results.add_entry_for(song)
    {:noreply, worker_count}
  end

  defp save_playlist() do
    GoogleTakeoutTools.Results.save()
  end
end
