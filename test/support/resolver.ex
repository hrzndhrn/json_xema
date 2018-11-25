defmodule Test.Resolver do
  @moduledoc false

  @behaviour Xema.Resolver

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri) do
    case remote?(uri) do
      true -> get(uri)
      false -> {:ok, nil}
    end
  end

  defp get(uri) do
    case HTTPoison.get(uri) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Remote schema '#{uri}' not found."}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "HTTP Error - code: #{code}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp remote?(%URI{path: nil}), do: false

  defp remote?(%URI{path: path}), do: String.ends_with?(path, ".json")
end
