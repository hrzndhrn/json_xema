defmodule JsonXema do
  @moduledoc """
  TODO: Documentation for JsonXema.
  """
  use Xema.Behaviour

  import ConvCase
  import String, only: [to_existing_atom: 1]

  alias Jason
  alias Xema.Schema

  @type format_attribute ::
          :date_time
          | :email
          | :ipv4
          | :ipv6
          | :json_pointer
          | :uri
          | :uri_reference
          | :uri_template
          | :regex

  @format_attributes [
    :date_time,
    :email,
    :ipv4,
    :ipv6,
    :json_pointer,
    :regex,
    :uri,
    :uri_reference,
    :uri_template
  ]

  @type_map %{
    "any" => :any,
    "array" => :list,
    "boolean" => :boolean,
    "integer" => :integer,
    "number" => :number,
    "object" => :map,
    "string" => :string,
    "null" => nil
  }

  @type_map_reverse for {key, value} <- @type_map, into: %{}, do: {value, key}

  @types Map.keys(@type_map)

  @atom_keywords %Schema{}
                 |> Map.delete(:data)
                 |> Map.delete(:__struct__)
                 |> Map.keys()
                 |> MapSet.new()

  @string_keywords @atom_keywords
                   |> Enum.map(&Atom.to_string/1)
                   |> MapSet.new()

  #  @keywords [
  #    :anyOf,
  #    :additionalItems,
  #    :additionalProperties,
  #    :exclusiveMaximum,
  #    :exclusiveMinimum,
  #    :maxItems,
  #    :maxLength,
  #    :maxProperties,
  #    :minItems,
  #    :minLength,
  #    :minProperties,
  #    :multipleOf,
  #    :uniqueItems
  #  ]
  #
  @on_load :load_atoms
  @doc false
  def load_atoms do
    #    Enum.each(@keywords, &Code.ensure_loaded/1)
    Enum.each(@format_attributes, &Code.ensure_loaded/1)
    #    @type_map |> Map.keys() |> Enum.each(&String.to_atom/1)
  end

  @spec new(String.t() | map) :: %JsonXema{}

  def init(string)
      when is_binary(string),
      do:
        string
        |> Jason.decode!(keys: :strings)
        |> init()

  def init(bool)
      when is_boolean(bool),
      do: schema(bool)

  def init(map)
      when is_map(map),
      do:
        map
        |> Map.put_new("type", "any")
        |> schema()

  def on_error(error), do: map_error(error)

  @spec to_xema(JsonXeam.t()) :: Xema.t()
  def to_xema(%JsonXema{} = jsonXema) do
    struct!(
      Xema,
      schema: jsonXema.schema,
      refs: jsonXema.refs
    )
  end

  defp schema(bool)
       when is_boolean(bool),
       do: Schema.new(type: bool)

  # Creates a schema for a reference.
  defp schema(%{"$ref" => pointer} = map) do
    map |> Map.delete("$ref") |> Map.put(:ref, pointer) |> schema()
  end

  defp schema(map)
       when is_map(map),
       do:
         map
         |> map_keys(&update_key/1)
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

  defp update_type(type)
       when is_list(type),
       do: Enum.map(type, &get_type/1)

  defp update_type(type), do: get_type(type)

  defp get_type("null"), do: nil

  defp get_type(type)
       when type in @types,
       do: Map.get(@type_map, type)

  defp get_type(_), do: raise(ArgumentError)

  defp update_key(key) when is_atom(key), do: key

  defp update_key("$" <> key), do: update_key(key)

  defp update_key(key)
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
      |> Map.update(:contains, nil, &schema/1)
      |> Map.update(:all_of, nil, &schemas/1)
      |> Map.update(:any_of, nil, &schemas/1)
      |> Map.update(:definitions, nil, &schemas/1)
      |> Map.update(:dependencies, nil, &dependencies/1)
      |> Map.update(:else, nil, &schema/1)
      |> Map.update(:format, nil, &to_format_attribute/1)
      |> Map.update(:if, nil, &schema/1)
      |> Map.update(:items, nil, &items/1)
      |> Map.update(:not, nil, &schema/1)
      |> Map.update(:one_of, nil, &schemas/1)
      |> Map.update(:pattern_properties, nil, &schemas/1)
      |> Map.update(:properties, nil, &schemas/1)
      |> Map.update(:property_names, nil, &schema/1)
      |> Map.update(:required, nil, &MapSet.new/1)
      |> Map.update(:then, nil, &schema/1)
      |> update_data()

  defp update_data(keywords) do
    {data, keywords} = do_update_data(keywords)

    case data do
      data when map_size(data) == 0 ->
        Map.put(keywords, :data, nil)

      data ->
        Map.put(keywords, :data, data)
    end
  end

  defp do_update_data(keywords),
    do:
      keywords
      |> diff_keywords()
      |> Enum.reduce({%{}, keywords}, fn key, {data, keywords} ->
        {value, keywords} = Map.pop(keywords, key)
        {Map.put(data, key, maybe_schema(value)), keywords}
      end)

  defp maybe_schema(map) when is_map(map) do
    case has_keyword?(map) do
      true -> schema(map)
      false -> map
    end
  end

  defp maybe_schema(value), do: value

  defp diff_keywords(map),
    do:
      map
      |> Map.keys()
      |> MapSet.new()
      |> MapSet.difference(@atom_keywords)
      |> MapSet.to_list()

  defp has_keyword?(map),
    do:
      map
      |> Map.keys()
      |> MapSet.new()
      |> MapSet.disjoint?(@string_keywords)
      |> Kernel.not()

  defp items(value)
       when is_map(value) or is_boolean(value),
       do: schema(value)

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
        {key, dep} -> {key, schema(dep)}
      end)

  @spec to_format_attribute(String.t()) :: format_attribute
  defp to_format_attribute(str),
    do:
      str
      |> String.replace("-", "_")
      |> String.to_existing_atom()

  @spec map_error(any) :: any
  defp map_error(:mixed_map), do: :mixed_map

  defp map_error(%{__struct__: _} = struct), do: struct

  defp map_error(error) when is_map(error),
    do: for({key, value} <- error, into: %{}, do: map_error(key, value))

  defp map_error(error) when is_list(error),
    do: Enum.map(error, &map_error/1)

  defp map_error(error) when is_tuple(error),
    do:
      error
      |> Tuple.to_list()
      |> map_error()
      |> List.to_tuple()

  defp map_error(error), do: ConvCase.to_camel_case(error)

  @spec map_error(any, any) :: any
  defp map_error(:properties, value),
    do: {:properties, map_values(value, &map_error/1)}

  defp map_error(:format, value),
    do: {"format", value |> to_string() |> ConvCase.to_kebab_case()}

  defp map_error(:type, value)
       when is_boolean(value),
       do: {:type, value}

  defp map_error(:type, value)
       when is_list(value),
       do:
         {:type,
          value
          |> Enum.map(fn type ->
            @type_map_reverse
            |> Map.get(type)
            |> to_existing_atom()
          end)}

  defp map_error(:type, value),
    do: {:type, @type_map_reverse |> Map.get(value) |> to_existing_atom()}

  defp map_error(key, value),
    do: {ConvCase.to_camel_case(key), map_error(value)}

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
