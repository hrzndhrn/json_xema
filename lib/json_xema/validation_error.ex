defmodule JsonXema.ValidationError do
  @moduledoc """
  Raised when a validation fails.

  ## Example

      iex> schema = JsonXema.new(%{"type" => "string"})
      iex> {:error, error} = JsonXema.validate(schema, 6)
      iex> Exception.message(error)
      ~s|Expected "string", got 6.|
  """

  @type path :: [atom | integer | String.t()]
  @type opts :: [] | [path: path]

  defexception [:message, :reason]

  @impl true
  def message(%{message: nil} = exception), do: format_error(exception.reason)

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
  @spec format_error({:error, map} | map) :: String.t()
  def format_error({:error, %__MODULE__{reason: reason}}), do: format_error(reason)

  def format_error({:error, error}), do: format_error(error)

  def format_error(error),
    do:
      error
      |> travers_errors([], &format_error/3)
      |> Enum.reverse()
      |> Enum.join("\n")

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

  def travers_errors({:error, %__MODULE__{reason: reason}}, acc, fun, opts),
    do: travers_errors(reason, acc, fun, opts)

  def travers_errors(error, acc, fun, []), do: travers_errors(error, acc, fun, path: [])

  def travers_errors(%{properties: properties} = error, acc, fun, opts),
    do:
      Enum.reduce(
        properties,
        fun.(error, opts[:path], acc),
        fn {key, value}, acc -> travers_errors(value, acc, fun, path: opts[:path] ++ [key]) end
      )

  def travers_errors(%{items: items} = error, acc, fun, opts),
    do:
      Enum.reduce(
        items,
        fun.(error, opts[:path], acc),
        fn {key, value}, acc -> travers_errors(value, acc, fun, path: opts[:path] ++ [key]) end
      )

  def travers_errors(error, acc, fun, opts), do: fun.(error, opts[:path], acc)

  @spec to_jsonable({:error, map} | map) :: map()
  def to_jsonable({:error, %__MODULE__{reason: reason}}), do: to_jsonable(reason)

  def to_jsonable({:error, error}), do: to_jsonable(error)

  def to_jsonable(error), do: do_to_jsonable(error)

  # Helpers

  defp do_to_jsonable(%{properties: properties}) do
    %{properties: Enum.into(properties, %{}, fn {key, error} -> {key, do_to_jsonable(error)} end)}
  end

  defp do_to_jsonable(%{items: items}) do
    %{items: Enum.into(items, %{}, fn {index, error} -> {index, do_to_jsonable(error)} end)}
  end

  defp do_to_jsonable(error), do: error

  defp format_error(%{exclusiveMinimum: minimum, value: value}, path, acc)
       when minimum == value do
    msg = "Value #{inspect(minimum)} equals exclusive minimum value of #{inspect(minimum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minimum: minimum, exclusiveMinimum: true, value: value}, path, acc)
       when minimum == value do
    msg = "Value #{inspect(value)} equals exclusive minimum value of #{inspect(minimum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minimum: minimum, exclusiveMinimum: true, value: value}, path, acc) do
    msg = "Value #{inspect(value)} is less than minimum value of #{inspect(minimum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{exclusiveMinimum: minimum, value: value}, path, acc) do
    msg = "Value #{inspect(value)} is less than minimum value of #{inspect(minimum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minimum: minimum, value: value}, path, acc) do
    msg = "Value #{inspect(value)} is less than minimum value of #{inspect(minimum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{exclusiveMaximum: maximum, value: value}, path, acc)
       when maximum == value do
    msg = "Value #{inspect(maximum)} equals exclusive maximum value of #{inspect(maximum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maximum: maximum, exclusiveMaximum: true, value: value}, path, acc)
       when maximum == value do
    msg = "Value #{inspect(value)} equals exclusive maximum value of #{inspect(maximum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maximum: maximum, exclusiveMaximum: true, value: value}, path, acc) do
    msg = "Value #{inspect(value)} exceeds maximum value of #{inspect(maximum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{exclusiveMaximum: maximum, value: value}, path, acc) do
    msg = "Value #{inspect(value)} exceeds maximum value of #{inspect(maximum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maximum: maximum, value: value}, path, acc) do
    msg = "Value #{inspect(value)} exceeds maximum value of #{inspect(maximum)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maxLength: max, value: value}, path, acc) do
    msg = "Expected maximum length of #{inspect(max)}, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minLength: min, value: value}, path, acc) do
    msg = "Expected minimum length of #{inspect(min)}, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{multipleOf: multiple_of, value: value}, path, acc) do
    msg = "Value #{inspect(value)} is not a multiple of #{inspect(multiple_of)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{enum: _enum, value: value}, path, acc) do
    msg = "Value #{inspect(value)} is not defined in enum"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minProperties: min, value: value}, path, acc) do
    msg = "Expected at least #{inspect(min)} properties, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maxProperties: max, value: value}, path, acc) do
    msg = "Expected at most #{inspect(max)} properties, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{additionalProperties: false}, path, acc) do
    msg = "Expected only defined properties, got key #{inspect(path)}."
    [msg | acc]
  end

  defp format_error(%{additionalItems: false}, path, acc) do
    msg = "Unexpected additional item"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{format: format, value: value}, path, acc) do
    msg = "String #{inspect(value)} does not validate against format #{inspect(format)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{then: error}, path, acc) do
    msg = ["Schema for then does not match#{at_path(path)}"]

    error =
      error
      |> travers_errors([], &format_error/3, path: path)
      |> indent()

    Enum.concat([error, msg, acc])
  end

  defp format_error(%{else: error}, path, acc) do
    msg = ["Schema for else does not match#{at_path(path)}"]

    error =
      error
      |> travers_errors([], &format_error/3, path: path)
      |> indent()

    Enum.concat([error, msg, acc])
  end

  defp format_error(%{not: :ok, value: value}, path, acc) do
    msg = "Value is valid against schema from not, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{contains: errors}, path, acc) do
    msg = ["No items match contains#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn {index, reason} ->
        travers_errors(reason, [], &format_error/3, path: path ++ [index])
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{anyOf: errors}, path, acc) do
    msg = ["No match of any schema" <> at_path(path)]

    errors =
      errors
      |> Enum.flat_map(fn reason ->
        reason |> travers_errors([], &format_error/3, path: path) |> Enum.reverse()
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{allOf: errors}, path, acc) do
    msg = ["No match of all schema#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn reason ->
        travers_errors(reason, [], &format_error/3, path: path)
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{oneOf: {:error, errors}}, path, acc) do
    msg = ["No match of any schema#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn reason ->
        travers_errors(reason, [], &format_error/3, path: path)
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{oneOf: {:ok, success}}, path, acc) do
    msg = "More as one schema matches (indexes: #{inspect(success)})"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{required: required}, path, acc) do
    msg = "Required properties are missing: #{inspect(required)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{propertyNames: errors, value: _value}, path, acc) do
    msg = ["Invalid property names#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn {key, reason} ->
        "#{inspect(key)} : #{format_error(reason, [], [])}"
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{dependencies: deps}, path, acc) do
    msg =
      deps
      |> Enum.reduce([], fn
        {key, reason}, acc when is_map(reason) ->
          sub_msg =
            reason
            |> format_error(path, [])
            |> Enum.reverse()
            |> indent()
            |> Enum.join("\n")

          ["Dependencies for #{inspect(key)} failed#{at_path(path)}\n#{sub_msg}" | acc]

        {key, reason}, acc ->
          [
            "Dependencies for #{inspect(key)} failed#{at_path(path)}" <>
              " Missing required key #{inspect(reason)}."
            | acc
          ]
      end)
      |> Enum.reverse()
      |> Enum.join("\n")

    [msg | acc]
  end

  defp format_error(%{minItems: min, value: value}, path, acc) do
    msg = "Expected at least #{inspect(min)} items, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maxItems: max, value: value}, path, acc) do
    msg = "Expected at most #{inspect(max)} items, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{uniqueItems: true, value: value}, path, acc) do
    msg = "Expected unique items, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{const: const, value: value}, path, acc) do
    msg = "Expected #{inspect(const)}, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{pattern: pattern, value: value}, path, acc) do
    msg = "Pattern #{inspect(pattern)} does not match value #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{type: type, value: value}, path, acc) do
    msg = "Expected #{inspect(type)}, got #{inspect(value)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{type: false}, path, acc) do
    msg = "Schema always fails validation"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{properties: _}, _path, acc), do: acc

  defp format_error(%{items: _}, _path, acc), do: acc

  defp format_error(_error, path, acc) do
    msg = "Unexpected error"
    [msg <> at_path(path) | acc]
  end

  defp at_path([]), do: "."

  defp at_path(path), do: ", at #{inspect(path)}."

  defp indent(list), do: Enum.map(list, fn str -> "  #{str}" end)
end
