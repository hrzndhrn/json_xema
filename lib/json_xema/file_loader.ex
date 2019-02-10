defmodule JsonXema.FileLoader do
  @moduledoc false

  @behaviour Xema.Loader

  alias JsonXema.Json

  @default_path "xema"

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri), do:
    path()
    |> Path.join(uri.path)
    |> File.read!()
    |> Json.decode()

  defp path do
    path =
      :json_xema
      |> Application.get_env(FileLoader)
      |> Keyword.get(:path, @default_path)

    case absolute?(path) do
      true -> path
      false -> app() |> :code.priv_dir() |> Path.join(path)
    end
  end

  defp app,
    do:
      :json_xema
      |> Application.get_env(FileLoader)
      |> Keyword.fetch!(:app)

  defp absolute?(path), do: path == Path.expand(path)
end
