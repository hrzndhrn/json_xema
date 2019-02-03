defmodule Test.FileLoader do
  @moduledoc false

  @behaviour Xema.Loader

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri),
    do:
      "test/support/remote"
      |> Path.join(uri.path)
      |> File.read!()
      |> Jason.decode()
end

defmodule RemoteLoader do
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
