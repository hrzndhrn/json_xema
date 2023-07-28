defmodule Test.FileLoader do
  @moduledoc false

  @behaviour Xema.Loader

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri),
    do:
      "test/fixtures/remote"
      |> Path.join(uri.path)
      |> File.read!()
      |> Jason.decode()
end
