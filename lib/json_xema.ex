defmodule JsonXema do
  @moduledoc """
  TODO: Documentation for JsonXema.
  """
  use Xema.Base

  import ConvCase
  import String, only: [to_existing_atom: 1]

  alias Jason
  alias Xema.Schema
  alias Xema.Validator

  @type_map %{
    "array" => :list,
    "boolean" => :boolean,
    "integer" => :integer,
    "number" => :number,
    "object" => :map,
    "string" => :string
  }

  @keywords [
    :additionalItems,
    :additionalProperties,
    :exclusiveMaximum,
    :exclusiveMinimum,
    :maxItems,
    :maxLength,
    :maxProperties,
    :minItems,
    :minLength,
    :minProperties,
    :multipleOf,
    :uniqueItems
  ]

  @on_load :load_atoms
  @doc false
  def load_atoms, do: Enum.each(@keywords, &Code.ensure_loaded/1)

  @spec is_valid?(JsonXema.t() | Schema.t(), any) :: boolean
  def is_valid?(schema, value), do: validate(schema, value) == :ok

  @spec validate(JsonXema.t() | Schema.t(), any) :: Validator.result()
  def validate(schema, value) do
    case Validator.validate(schema, value) do
      :ok -> :ok
      {:error, reason} -> {:error, error_to_camel_case(reason)}
    end
  end

  @spec new(String.t() | map) :: JsonXema.t()

  def new(string)
      when is_binary(string),
      do: string |> Jason.decode!(keys: :strings) |> new()

  def new(map)
      when is_map(map),
      do: map |> schema() |> create()

  def to_xema(%JsonXema{} = jsonXema), do: Xema.create(jsonXema.content)

  defp schema(map),
    do:
      map
      |> map_keys(&update_keys/1)
      |> update_type()
      |> update()
      |> Map.to_list()
      |> Schema.new()

  defp update_type(map),
    do:
      map
      |> Map.update(:type, :any, &Map.get(@type_map, &1))
      |> Map.put(:as, Map.get(map, :type, "any"))

  defp update_keys(key)
       when is_binary(key),
       do:
         key
         |> to_snake_case()
         |> to_existing_atom()

  defp update(map),
    do:
      map
      |> Map.update(:additional_items, nil, &bool_or_schema/1)
      |> Map.update(:additional_properties, nil, &bool_or_schema/1)
      |> Map.update(:dependencies, nil, &dependencies/1)
      |> Map.update(:items, nil, &items/1)
      |> Map.update(:not, nil, &schema/1)
      |> Map.update(:pattern_properties, nil, &schemas/1)
      |> Map.update(:properties, nil, &schemas/1)
      |> Map.update(:required, nil, &MapSet.new/1)

  defp items(map)
       when is_map(map),
       do: schema(map)

  defp items(list)
       when is_list(list),
       do: Enum.map(list, &schema/1)

  defp bool_or_schema(map)
       when is_map(map),
       do: schema(map)

  defp bool_or_schema(bool)
       when is_boolean(bool),
       do: bool

  defp schemas(map)
       when is_map(map),
       do:
         map
         |> map_values(&schema/1)
         |> Enum.into(%{})

  @spec dependencies(map) :: map
  defp dependencies(map),
    do:
      Enum.into(map, %{}, fn
        {key, dep} when is_list(dep) -> {key, dep}
        {key, dep} -> {key, schema(dep)}
      end)

  @spec error_to_camel_case(any) :: any
  defp error_to_camel_case(:mixed_map), do: :mixed_map

  defp error_to_camel_case(%{__struct__: _} = struct), do: struct

  defp error_to_camel_case(error) when is_map(error) do
    for {key, value} <- error, into: %{}, do: error_to_camel_case(key, value)
  end

  defp error_to_camel_case(error), do: ConvCase.to_camel_case(error)

  @spec error_to_camel_case(any, any) :: any
  defp error_to_camel_case(:properties, value),
    do: {:properties, map_values(value, &error_to_camel_case/1)}

  defp error_to_camel_case(key, value),
    do: {ConvCase.to_camel_case(key), error_to_camel_case(value)}

  @spec map_keys(map, function) :: map
  defp map_keys(map, fun)
       when is_map(map),
       do: for({k, v} <- map, into: %{}, do: {fun.(k), v})

  @spec map_values(map, function) :: map
  defp map_values(map, fun)
       when is_map(map),
       do: for({k, v} <- map, into: %{}, do: {k, fun.(v)})
end
