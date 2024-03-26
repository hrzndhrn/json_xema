defmodule JsonXema.ValidationError.DefaultFormatter do
  @moduledoc """
  The default formatter for `JsonXema.ValidationError`s.

  TODO: add more docs

  ## Examples

      iex> schema = ~s|{"type": "integer"}| |> Jason.decode!() |> JsonXema.new()
      ...> error = JsonXema.validate(schema, %{one: 1})
      ...> JsonXema.ValidationError.format_error(error)
      ~S|Expected "integer", got %{one: 1}.|
      ...> inspect_fun = fn value, _opts -> Jason.encode!(value) end
      ...> JsonXema.ValidationError.format_error(error, inspect_fun: inspect_fun)
      ~S|Expected "integer", got {"one":1}.|
      ...> Application.put_env(:json_xema, ValidationError, inspect_fun: inspect_fun)
      ...> JsonXema.ValidationError.format_error(error)
      ~S|Expected "integer", got {"one":1}.|
      ...> Application.delete_env(:json_xema, ValidationError)
      :ok

  """

  import JsonXema.ValidationError, only: [travers_errors: 3, travers_errors: 4]

  @behaviour JsonXema.ValidationError.Formatter

  @impl true
  def format(%JsonXema.ValidationError{reason: error}, opts) do
    opts = Keyword.merge(opts, opts())

    error
    |> travers_errors([], format_error_fun(opts))
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  defp opts, do: Application.get_env(:json_xema, ValidationError, [])

  defp format_error_fun(opts) do
    fn error, path, acc ->
      format_error(error, path, opts, acc)
    end
  end

  defp format_error(%{exclusiveMinimum: minimum, value: value}, path, inspect_opts, acc)
       when minimum == value do
    msg =
      "Value #{inspect(value, inspect_opts)} equals exclusive minimum value of #{inspect(minimum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(
         %{minimum: minimum, exclusiveMinimum: true, value: value},
         path,
         inspect_opts,
         acc
       )
       when minimum == value do
    msg =
      "Value #{inspect(value, inspect_opts)} equals exclusive minimum value of #{inspect(minimum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(
         %{minimum: minimum, exclusiveMinimum: true, value: value},
         path,
         inspect_opts,
         acc
       ) do
    msg =
      "Value #{inspect(value, inspect_opts)} is less than minimum value of #{inspect(minimum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{exclusiveMinimum: minimum, value: value}, path, inspect_opts, acc) do
    msg =
      "Value #{inspect(value, inspect_opts)} is less than minimum value of #{inspect(minimum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minimum: minimum, value: value}, path, inspect_opts, acc) do
    msg =
      "Value #{inspect(value, inspect_opts)} is less than minimum value of #{inspect(minimum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{exclusiveMaximum: maximum, value: value}, path, inspect_opts, acc)
       when maximum == value do
    msg =
      "Value #{inspect(value, inspect_opts)} equals exclusive maximum value of #{inspect(maximum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(
         %{maximum: maximum, exclusiveMaximum: true, value: value},
         path,
         inspect_opts,
         acc
       )
       when maximum == value do
    msg =
      "Value #{inspect(value, inspect_opts)} equals exclusive maximum value of #{inspect(maximum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(
         %{maximum: maximum, exclusiveMaximum: true, value: value},
         path,
         inspect_opts,
         acc
       ) do
    msg =
      "Value #{inspect(value, inspect_opts)} exceeds maximum value of #{inspect(maximum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{exclusiveMaximum: maximum, value: value}, path, inspect_opts, acc) do
    msg =
      "Value #{inspect(value, inspect_opts)} exceeds maximum value of #{inspect(maximum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maximum: maximum, value: value}, path, inspect_opts, acc) do
    msg =
      "Value #{inspect(value, inspect_opts)} exceeds maximum value of #{inspect(maximum)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maxLength: max, value: value}, path, inspect_opts, acc) do
    msg =
      "Expected maximum length of #{inspect(max)}, got #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minLength: min, value: value}, path, inspect_opts, acc) do
    msg =
      "Expected minimum length of #{inspect(min)}, got #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{multipleOf: multiple_of, value: value}, path, inspect_opts, acc) do
    msg =
      "Value #{inspect(value, inspect_opts)} is not a multiple of #{inspect(multiple_of)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{enum: _enum, value: value}, path, inspect_opts, acc) do
    msg = "Value #{inspect(value, inspect_opts)} is not defined in enum"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{minProperties: min, value: value}, path, inspect_opts, acc) do
    msg =
      "Expected at least #{inspect(min)} properties, got #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maxProperties: max, value: value}, path, inspect_opts, acc) do
    msg =
      "Expected at most #{inspect(max)} properties, got #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{additionalProperties: false}, path, _inspect_opts, acc) do
    msg = "Expected only defined properties, got key #{inspect(path)}."
    [msg | acc]
  end

  defp format_error(%{additionalItems: false}, path, _inspect_opts, acc) do
    msg = "Unexpected additional item"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{format: format, value: value}, path, inspect_opts, acc) do
    msg =
      "String #{inspect(value, inspect_opts)} does not validate against format #{inspect(format)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{then: error}, path, inspect_opts, acc) do
    msg = ["Schema for then does not match#{at_path(path)}"]

    error =
      error
      |> travers_errors([], format_error_fun(inspect_opts), path: path)
      |> indent()

    Enum.concat([error, msg, acc])
  end

  defp format_error(%{else: error}, path, inspect_opts, acc) do
    msg = ["Schema for else does not match#{at_path(path)}"]

    error =
      error
      |> travers_errors([], format_error_fun(inspect_opts), path: path)
      |> indent()

    Enum.concat([error, msg, acc])
  end

  defp format_error(%{not: :ok, value: value}, path, inspect_opts, acc) do
    msg = "Value is valid against schema from not, got #{inspect(value, inspect_opts)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{contains: errors}, path, inspect_opts, acc) do
    msg = ["No items match contains#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn {index, reason} ->
        travers_errors(reason, [], format_error_fun(inspect_opts), path: path ++ [index])
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{anyOf: errors}, path, inspect_opts, acc) do
    msg = ["No match of any schema" <> at_path(path)]

    errors =
      errors
      |> Enum.flat_map(fn reason ->
        reason
        |> travers_errors([], format_error_fun(inspect_opts), path: path)
        |> Enum.reverse()
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{allOf: errors}, path, inspect_opts, acc) do
    msg = ["No match of all schema#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn reason ->
        travers_errors(reason, [], format_error_fun(inspect_opts), path: path)
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{oneOf: {:error, errors}}, path, inspect_opts, acc) do
    msg = ["No match of any schema#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn reason ->
        travers_errors(reason, [], format_error_fun(inspect_opts), path: path)
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{oneOf: {:ok, success}}, path, inspect_opts, acc) do
    msg = "More as one schema matches (indexes: #{inspect(success, inspect_opts)})"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{required: required}, path, _inspect_opts, acc) do
    msg = "Required properties are missing: #{inspect(required)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{propertyNames: errors, value: _value}, path, inspect_opts, acc) do
    msg = ["Invalid property names#{at_path(path)}"]

    errors =
      errors
      |> Enum.map(fn {key, reason} ->
        "#{inspect(key)} : #{format_error(reason, [], inspect_opts, [])}"
      end)
      |> Enum.reverse()
      |> indent()

    Enum.concat([errors, msg, acc])
  end

  defp format_error(%{dependencies: deps}, path, inspect_opts, acc) do
    msg =
      deps
      |> Enum.reduce([], fn
        {key, reason}, acc when is_map(reason) ->
          sub_msg =
            reason
            |> format_error(path, inspect_opts, [])
            |> Enum.reverse()
            |> indent()
            |> Enum.join("\n")

          [
            "Dependencies for #{inspect(key)} failed#{at_path(path)}\n#{sub_msg}"
            | acc
          ]

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

  defp format_error(%{minItems: min, value: value}, path, inspect_opts, acc) do
    msg =
      "Expected at least #{inspect(min)} items, got #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{maxItems: max, value: value}, path, inspect_opts, acc) do
    msg =
      "Expected at most #{inspect(max)} items, got #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{uniqueItems: true, value: value}, path, inspect_opts, acc) do
    msg = "Expected unique items, got #{inspect(value, inspect_opts)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{const: const, value: value}, path, inspect_opts, acc) do
    msg = "Expected #{inspect(const)}, got #{inspect(value, inspect_opts)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{pattern: pattern, value: value}, path, inspect_opts, acc) do
    msg =
      "Pattern #{inspect(pattern)} does not match value #{inspect(value, inspect_opts)}"

    [msg <> at_path(path) | acc]
  end

  defp format_error(%{type: type, value: value}, path, inspect_opts, acc) do
    msg = "Expected #{inspect(type)}, got #{inspect(value, inspect_opts)}"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{type: false}, path, _inspect_opts, acc) do
    msg = "Schema always fails validation"
    [msg <> at_path(path) | acc]
  end

  defp format_error(%{properties: _}, _path, _inspect_opts, acc), do: acc

  defp format_error(%{items: _}, _path, _inspect_opts, acc), do: acc

  defp format_error(_error, path, _inspect_opts, acc) do
    msg = "Unexpected error"
    [msg <> at_path(path) | acc]
  end

  defp at_path([]), do: "."

  defp at_path(path), do: ", at #{inspect(path)}."

  defp indent(list), do: Enum.map(list, fn str -> "  #{str}" end)
end
