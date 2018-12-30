defmodule Test.Resolver do
  @moduledoc false

  defmodule FileResolver do
    @behaviour Xema.Resolver

    @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
    def fetch(uri), do:
      "test/support/remote"
      |> Path.join(uri.path)
      |> File.read!()
      |> Jason.decode()
  end

  defmodule RemoteResolver do
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

  @behaviour Xema.Resolver

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri) do
    case uri.host do
      nil -> FileResolver.fetch(uri)
      _ -> RemoteResolver.fetch(uri)
    end
  end
end
