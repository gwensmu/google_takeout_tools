# Google Takeout Tools

Currently just a utility to take the massive collection of CSVs that Google sends you when you do Google Takeout on your Google Music (RIP) and turn it into a text summary of your music life, sutible for import via Tune My Music.

Presumably its a generic dump of their bigtable or something but, I mean, really, why did they send me thousands of individual CSV files of one row each, where each row is a song?

On the plus side, a project to practice an Elixir / OTP application.

## Run Music Takeout tools

```bash
mix run --no-halt
```

## Run Tests

```bash
mix test --no-start
```

## Run static analysis

```bash
mix dialyzer --no-check --halt-exit-status
```

## Performance Comparison to Plain Old Ruby:

Not actually trying to make the case here that Ruby is superior (well, for this use case maybe) - just good to get data.

With 5 workers:

```bash
gwensmuda@MacBook-Pro google_takeout_tools % time mix run --no-halt   
mix run --no-halt  4.97s user 1.84s system 555% cpu 1.227 total
```

With 1 Worker:

```bash
gwensmuda@MacBook-Pro google_takeout_tools % time mix run --no-halt
mix run --no-halt  9.32s user 1.75s system 440% cpu 2.511 total
```

Compare to this Ruby script that took 5 min to code:

```bash
gwensmuda@MacBook-Pro google_takeout_tools % time ruby naive_export.rb 
ruby naive_export.rb  0.47s user 0.16s system 99% cpu 0.634 total
```

```ruby
require 'csv'

csvs = Dir['./music_takeout/**/*.csv']

playlist = File.open('ruby-playlist.txt', 'w+')

csvs.each do |csv|
  track = CSV.parse(File.read(csv), headers: true)[0]
  playlist.puts "#{track['Artist']} - #{track['Title']}\n"
end

playlist.close
```
