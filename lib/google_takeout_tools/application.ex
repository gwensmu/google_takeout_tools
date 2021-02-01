defmodule GoogleTakeoutTools.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GoogleTakeoutTools.Results,
      {GoogleTakeoutTools.PathFinder,
       Application.fetch_env!(:google_takeout_tools, :music_import_dir)},
      GoogleTakeoutTools.SongReaderSupervisor,
      {GoogleTakeoutTools.Music, Application.fetch_env!(:google_takeout_tools, :music_workers)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoogleTakeoutTools.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
