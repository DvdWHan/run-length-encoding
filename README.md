`docker compose run --rm elixir sh`
`cd run_length_encoding`
`iex -S mix`
`RunLengthEncoding.encode("aaabbc")` -> `3a2bc`
`RunLengthEncoding.decode("3a2bc")` -> `aaabbc`
