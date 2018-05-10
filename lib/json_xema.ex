defmodule JsonXema do
  @moduledoc """
  TODO: Documentation for JsonXema.
  """
  use Xema.Base

  import ConvCase
  import String, only: [to_existing_atom: 1]

  alias Jason
  alias Xema.Schema

  @type format_attribute ::
          :date_time
          | :email
          | :ipv4
          | :ipv6
          | :uri

  @format_attributes [
    :date_time,
    :email,
    :ipv4,
    :ipv6,
    :uri
  ]

  @type_map %{
    "array" => :list,
    "boolean" => :boolean,
    "integer" => :integer,
    "number" => :number,
    "object" => :map,
    "string" => :string
  }

  @types Map.keys(@type_map)

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
  def load_atoms do
    Enum.each(@keywords, &Code.ensure_loaded/1)
    Enum.each(@format_attributes, &Code.ensure_loaded/1)
  end

  @spec new(String.t() | map) :: JsonXema.t()

  def init(string, _)
      when is_binary(string),
      do: string |> Jason.decode!(keys: :strings) |> init(nil)

  def init(value, _)
      when is_map(value) or is_boolean(value),
      do: schema(value)

  def on_error(error), do: error_to_camel_case(error)

  @spec to_xema(JsonXeam.t()) :: Xema.t()
  def to_xema(%JsonXema{} = jsonXema),
    do:
      jsonXema.content
      |> to_xema_convert()
      |> Xema.new()

  defp to_xema_convert(%Xema.Schema{} = schema),
    do:
      %{schema | as: schema.type}
      |> map_values(&to_xema_convert/1)

  defp to_xema_convert(map)
       when is_map(map),
       do: map_values(map, &to_xema_convert/1)

  defp to_xema_convert(list)
       when is_list(list),
       do: Enum.map(list, &to_xema_convert/1)

  defp to_xema_convert(value), do: value

  defp schema(bool)
       when is_boolean(bool),
       do: Schema.new(type: bool)

  defp schema(map)
       when is_map(map),
       do:
         map
         |> map_keys(&update_keys/1)
         |> update_type()
         |> update()
         |> Map.to_list()
         |> Schema.new()

  defp schema(list)
       when is_list(list),
       do: Schema.new(type: update_type(list))

  defp update_type(map)
       when is_map(map),
       do:
         map
         |> Map.update(:type, :any, &update_type/1)
         |> Map.put(:as, Map.get(map, :type, "any"))

  defp update_type(type)
       when is_list(type),
       do: Enum.map(type, &get_type/1)

  defp update_type(type), do: get_type(type)

  defp get_type("null"), do: nil

  defp get_type(type)
       when type in @types,
       do: Map.get(@type_map, type)

  defp get_type(_), do: raise(ArgumentError)

  defp update_keys(key)
       when is_binary(key),
       do:
         key
         |> to_snake_case()
         |> to_existing_atom()

  defp update_keys(key)
       when is_atom(key),
       do: to_snake_case(key)

  defp update(map),
    do:
      map
      |> Map.update(:additional_items, nil, &bool_or_schema/1)
      |> Map.update(:additional_properties, nil, &bool_or_schema/1)
      |> Map.update(:all_of, nil, &schemas/1)
      |> Map.update(:any_of, nil, &schemas/1)
      |> Map.update(:dependencies, nil, &dependencies/1)
      |> Map.update(:format, nil, &to_format_attribute/1)
      |> Map.update(:items, nil, &items/1)
      |> Map.update(:not, nil, &schema/1)
      |> Map.update(:one_of, nil, &schemas/1)
      |> Map.update(:pattern_properties, nil, &schemas/1)
      |> Map.update(:properties, nil, &schemas/1)
      |> Map.update(:required, nil, &MapSet.new/1)

  defp items(map)
       when is_map(map),
       do: schema(map)

  defp items(list)
       when is_list(list),
       do: schemas(list)

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

  defp schemas(list)
       when is_list(list),
       do: Enum.map(list, &schema/1)

  @spec dependencies(map) :: map
  defp dependencies(map),
    do:
      Enum.into(map, %{}, fn
        {key, dep} when is_list(dep) -> {key, dep}
        {key, dep} when is_binary(dep) -> {key, [dep]}
        {key, dep} when is_atom(dep) -> {key, [dep]}
        {key, dep} -> {key, schema(dep)}
      end)

  @spec to_format_attribute(String.t()) :: format_attribute
  defp to_format_attribute(str),
    do:
      str
      |> String.replace("-", "_")
      |> String.to_existing_atom()

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

  @spec map_values(map | struct, function) :: map
  defp map_values(%{__struct__: module} = value, fun) do
    map =
      value
      |> Map.from_struct()
      |> map_values(fun)

    struct(module, map)
  end

  defp map_values(map, fun)
       when is_map(map),
       do: for({k, v} <- map, into: %{}, do: {k, fun.(v)})
end
