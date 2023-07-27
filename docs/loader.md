# Configure a loader

A loader returns the data for a remote schema. The remote schemas are defined
in a schema like this.

```json
...
  "properties": {
    "int": {"$ref": "http://localhost:1234/int.json"}
  }
...
```

A loader will be configured like this.

```elixir
config :xema, loader: My.Loader
```

A loader is a module which use the behaviour `Xema.Loader`.

```elixir
defmodule My.Loader do
  @moduledoc false

  @behaviour Xema.Loader

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri) do
    case HTTPoison.get(uri) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Remote schema '#{uri}' not found."}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "HTTP Error - code: #{code}"}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
```

The function `fetch/1` will be called by `Xema` and expects an `%URI{}`. The
return value must be a tuple of `:ok` and the required data for a schema or an
error tuple.

## File loader

A loader to read schema from the local file system.

In the schema:
```elixir
...
  "properties": {
    "int": {"$ref": "integer.json"}
  }
...
```

The loader:
```elixir
defmodule My.Loader do
  @moduledoc false

  @behaviour Xema.Loader

  @impl Xema.Loader
  def fetch(uri) do
    "path/to/schemas"
    |> Path.join(uri.path)
    |> File.read!()
    |> Jason.decode()
  end
end
```
