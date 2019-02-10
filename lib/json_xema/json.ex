defmodule JsonXema.Json do
  @moduledoc false

  # Wrap json library.

  @default_jsom_library Jason

  def decode(input) do
    apply(json_library(), :decode, [input])
  end

  defp json_library,
    do: Application.get_env(:json_xema, :json_library, @default_jsom_library)
end
