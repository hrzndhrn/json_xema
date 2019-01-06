# Configure a resolver

A resolver returns the data for a remote schema. The remote schemas are defined
in a schema like this.

```json
...
  "properties": {
    "int": {"$ref": "http://localhost:1234/int.json"}
  }
...
```

A resolver will be configured like this.

```elixir
config :xema, resolver: My.Resolver
```

A resolver is a module which use the behaviour `Xema.Resolver`.

```elixir
defmodule My.Resolver do
  @moduledoc false

  @behaviour Xema.Resolver

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

## File resolver

A resolver to read schema from the local file system.

In the schema:
```elixir
...
  "properties": {
    "int": {"$ref": "integer.json"}
  }
...
```

The resolver:
```elixir
defmodule My.Resolver do
  @moduledoc false

  @behaviour Xema.Resolver

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri),
    do:
      "path/to/schemas"
      |> Path.join(uri.path)
      |> File.read!()
      |> Jason.decode()

end
```
