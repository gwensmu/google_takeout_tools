defmodule GoogleTakeoutTools.PathFinder do
  use GenServer

  @moduledoc """
  Serves paths from a directory to workers who want them.
  """

  @me PathFinder

  def start_link(root) do
    GenServer.start_link(__MODULE__, root, name: @me)
  end

  def next_path do
    GenServer.call(@me, :next_path)
  end

  # This is cool, the state here is encapsulated in a module that's
  # lazily traversing directory trees
  # As opposed to a simple data structure like a map or an integer
  def init(path) do
    DirWalker.start_link(path)
  end

  def handle_call(:next_path, _from, dir_walker) do
    path =
      case DirWalker.next(dir_walker) do
        [path] -> path
        other -> other
      end

    {:reply, path, dir_walker}
  end
end
