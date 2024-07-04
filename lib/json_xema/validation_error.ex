defmodule JsonXema.ValidationError do
  @moduledoc """
  Raised when a validation fails.

  ## Example

      iex> schema = JsonXema.new(%{"type" => "string"})
      iex> {:error, error} = JsonXema.validate(schema, 6)
      iex> Exception.message(error)
      ~s|Expected "string", got 6.|
  """

  alias JsonXema.ValidationError
  alias JsonXema.ValidationError.Formatter

  @type path :: [atom | integer | String.t()]
  @type opts :: [] | [path: path]

  defexception [:message, :reason]

  @impl true
  def message(%{message: nil} = exception), do: format_error(exception)

  def message(%{message: message}), do: message

  @impl true
  def blame(exception, stacktrace) do
    message = message(exception)
    {%{exception | message: message}, stacktrace}
  end

  @doc """
  This function returns an error message for an error or error tuple.

  ## Example

      iex> schema = JsonXema.new(%{"type" => "integer"})
      iex> schema
      ...>   |> JsonXema.validate(1.1)
      ...>   |> JsonXema.ValidationError.format_error()
      ~s|Expected "integer", got 1.1.|
  """
  @spec format_error({:error, Exception.t()} | Exception.t(), opts :: keyword()) :: String.t()
  def format_error(error, inspect_opts \\ [])

  def format_error({:error, %ValidationError{} = error}, inspect_opts) do
    format_error(error, inspect_opts)
  end

  def format_error(%ValidationError{} = error, inspect_opts) do
    Formatter.format(error, inspect_opts)
  end

  @doc """
  Traverse the error tree and invokes the given function.

  ## Example

      iex> fun = fn _error, path, acc ->
      ...>   ["Error at " <> inspect(path) | acc]
      ...> end
      iex>
      iex> schema = JsonXema.new(%{
      ...>   "properties" => %{
      ...>     "int" => %{"type" => "integer"},
      ...>     "names" => %{
      ...>       "type" => "array",
      ...>       "items" => %{"type" => "string"}
      ...>     },
      ...>     "num" => %{"anyOf" => [
      ...>       %{"type" => "integer"},
      ...>       %{"type" => "number"}
      ...>     ]}
      ...>   }
      ...> })
      iex>
      iex> data = %{"int" => "x", "names" => [1, "x", 5], "num" => :foo}
      iex>
      iex> schema
      ...>   |> JsonXema.validate(data)
      ...>   |> JsonXema.ValidationError.travers_errors([], fun)
      [
        ~s|Error at ["num"]|,
        ~s|Error at ["names", 2]|,
        ~s|Error at ["names", 0]|,
        ~s|Error at ["names"]|,
        ~s|Error at ["int"]|,
        ~s|Error at []|
      ]
  """
  @spec travers_errors({:error, map} | map, acc, (map, path, acc -> acc), opts) :: acc
        when acc: any
  def travers_errors(error, acc, fun, opts \\ [])

  def travers_errors({:error, %__MODULE__{reason: reason}}, acc, fun, opts) do
    travers_errors(reason, acc, fun, opts)
  end

  def travers_errors(error, acc, fun, []) do
    travers_errors(error, acc, fun, path: [])
  end

  def travers_errors(%{properties: properties} = error, acc, fun, opts) do
    Enum.reduce(
      properties,
      fun.(error, opts[:path], acc),
      fn {key, value}, acc -> travers_errors(value, acc, fun, path: opts[:path] ++ [key]) end
    )
  end

  def travers_errors(%{items: items} = error, acc, fun, opts) do
    Enum.reduce(
      items,
      fun.(error, opts[:path], acc),
      fn {key, value}, acc -> travers_errors(value, acc, fun, path: opts[:path] ++ [key]) end
    )
  end

  def travers_errors(errors, acc, fun, opts) when is_list(errors) do
    errors
    |> Enum.flat_map(fn error ->
      travers_errors(error, [], fun, opts)
    end)
    |> Enum.concat(acc)
  end

  def travers_errors(error, acc, fun, opts), do: fun.(error, opts[:path], acc)
end
