### 1. Start Docker (if elixir not installed)
`docker compose run --rm elixir sh`

### 2. Start Mix
`iex -S mix`

### 3. Test the encode method
`RunLengthEncoding.encode("aaabbc")` -> `3a2bc`

### 4. Test the decode method
`RunLengthEncoding.decode("3a2bc")` -> `aaabbc`
