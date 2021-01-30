defmodule GoogleTakeoutTools.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GoogleTakeoutTools.Results,
      { GoogleTakeoutTools.PathFinder, "/Users/gwensmuda/dev/elixir/google_takeout_tools/music_takeout/Tracks" },
      GoogleTakeoutTools.SongReaderSupervisor,
      { GoogleTakeoutTools.Music, 3 },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoogleTakeoutTools.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
