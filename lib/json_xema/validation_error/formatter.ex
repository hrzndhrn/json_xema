defmodule JsonXema.ValidationError.Formatter do
  @moduledoc ~S"""
  The formatter for `JsonXema.ValidationError`s.

  TODO: add more docs

  ## Examples

      iex> defmodule MyValidationErrorFormatter do
      ...>   alias JsonXema.ValidationError
      ...>
      ...>   @behaviour JsonXema.ValidationError.Formatter
      ...>
      ...>   @impl true
      ...>   def format(error, _opts) do
      ...>     error
      ...>     |> ValidationError.travers_errors([], &format_error/3)
      ...>     |> Enum.reverse()
      ...>     |> Enum.join("\n")
      ...>   end
      ...>
      ...>   def format_error(error, path, acc) do
      ...>     [inspect([error: error.reason, path: path], pretty: true) | acc]
      ...>   end
      ...> end
      ...>
      ...> schema = ~s|{"type": "integer"}| |> Jason.decode!() |> JsonXema.new()
      ...>
      ...> Application.put_env(:json_xema, ValidationError,
      ...>   formatter: MyValidationErrorFormatter)
      ...>
      ...> {:error, error} = JsonXema.validate(schema, "one")
      ...> message = JsonXema.ValidationError.message(error)
      ...> Application.delete_env(:json_xema, ValidationError)
      ...> message
      "[error: %{type: \"integer\", value: \"one\"}, path: []]"

  """

  alias JsonXema.ValidationError.DefaultFormatter

  @callback format(error :: JsonXema.ValidationError.t(), opts :: keyword()) :: String.t()

  def format(error, opts), do: impl().format(error, opts)

  defp impl do
    :json_xema
    |> Application.get_env(ValidationError, [])
    |> Keyword.get(:formatter, DefaultFormatter)
  end
end

# ...>
# ...>   @behaviour JsonXema.ValidationError.Formatter
# ...>
# ...>   @impl true
# ...>   def format(error, _opts) do
# ...>     error
# ...>     |> ValidationError.travers_errors([], &format_error/3)
# ...>     |> Enum.reverse()
# ...>     |> Enum.join("\n")
# ...>   end
# ...>
# ...>   def format_error(error, path, acc) do
# ...>     [inspect([error: error, path: path], pretty: true) | acc]
# ...>   end
# ...> end
# ...>
# ...> schema = ~s|{"type": "integer"}| |> Jason.decode!() |> JsonXema.new()
# ...>
# ...> Application.put_env(:json_xema, ValidationError,
# ...>   formatter: MyValidationErrorFormatter)
# ...>
# ...> JsonXema.validate!(schema, "one")
# ""
