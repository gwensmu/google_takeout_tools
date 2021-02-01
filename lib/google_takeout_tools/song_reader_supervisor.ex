defmodule GoogleTakeoutTools.SongReaderSupervisor do
  use DynamicSupervisor

  @me SongReaderSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_worker() do
    {:ok, _pid} = DynamicSupervisor.start_child(@me, GoogleTakeoutTools.SongReader)
  end
end
