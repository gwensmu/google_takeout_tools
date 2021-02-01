import Config

config :google_takeout_tools,
  music_import_dir: "#{Path.expand(__DIR__)}/../test/music_takeout",
  output_file: "playlist-test.txt"
