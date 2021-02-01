import Config

config :google_takeout_tools,
  music_import_dir: ".",
  music_workers: 2,
  output_file: "playlist.txt"

import_config "#{config_env()}.exs"
