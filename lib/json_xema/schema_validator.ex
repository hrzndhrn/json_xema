defmodule JsonXema.SchemaValidator do
  @moduledoc false

  # This module contains validators to check schemas against the official
  # JSON Schemas.

  alias JsonXema.SchemaError

  @draft04 Xema.new(
             {:map,
              [
                default: %{},
                definitions: %{
                  "positiveInteger" => {:integer, [minimum: 0]},
                  "positiveIntegerDefault0" => [
                    all_of: [
                      {:ref, "#/definitions/positiveInteger"},
                      [default: 0]
                    ]
                  ],
                  "schemaArray" => {:list, [items: {:ref, "#"}, min_items: 1]},
                  "simpleTypes" => [
                    enum: [
                      "array",
                      "boolean",
                      "integer",
                      "null",
                      "number",
                      "object",
                      "string"
                    ]
                  ],
                  "stringArray" => {:list, [items: :string, min_items: 1, unique_items: true]}
                },
                dependencies: %{
                  "exclusiveMaximum" => ["maximum"],
                  "exclusiveMinimum" => ["minimum"]
                },
                description: "Core schema meta-schema",
                id: "http://json-schema.org/draft-04/schema#",
                properties: %{
                  "uniqueItems" => {:boolean, [default: false]},
                  "maximum" => :number,
                  "title" => :string,
                  "multipleOf" => {:number, [exclusive_minimum: true, minimum: 0]},
                  "anyOf" => {:ref, "#/definitions/schemaArray"},
                  "format" => :string,
                  "exclusiveMinimum" => {:boolean, [default: false]},
                  "id" => :string,
                  "minimum" => :number,
                  "definitions" => {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "minItems" => {:ref, "#/definitions/positiveIntegerDefault0"},
                  "additionalProperties" => [
                    any_of: [:boolean, {:ref, "#"}],
                    default: %{}
                  ],
                  "patternProperties" =>
                    {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "type" => [
                    any_of: [
                      ref: "#/definitions/simpleTypes",
                      list: [
                        items: {:ref, "#/definitions/simpleTypes"},
                        min_items: 1,
                        unique_items: true
                      ]
                    ]
                  ],
                  "maxItems" => {:ref, "#/definitions/positiveInteger"},
                  "dependencies" =>
                    {:map,
                     [
                       additional_properties: [
                         any_of: [ref: "#", ref: "#/definitions/stringArray"]
                       ]
                     ]},
                  "$schema" => :string,
                  "maxProperties" => {:ref, "#/definitions/positiveInteger"},
                  "properties" => {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "additionalItems" => [
                    any_of: [:boolean, {:ref, "#"}],
                    default: %{}
                  ],
                  "items" => [
                    any_of: [ref: "#", ref: "#/definitions/schemaArray"],
                    default: %{}
                  ],
                  "not" => {:ref, "#"},
                  "oneOf" => {:ref, "#/definitions/schemaArray"},
                  "default" => :any,
                  "required" => {:ref, "#/definitions/stringArray"},
                  "description" => :string,
                  "allOf" => {:ref, "#/definitions/schemaArray"},
                  "minLength" => {:ref, "#/definitions/positiveIntegerDefault0"},
                  "pattern" => {:string, [format: :regex]},
                  "enum" => {:list, [min_items: 1, unique_items: true]},
                  "exclusiveMaximum" => {:boolean, [default: false]},
                  "maxLength" => {:ref, "#/definitions/positiveInteger"},
                  "minProperties" => {:ref, "#/definitions/positiveIntegerDefault0"}
                },
                schema: "http://json-schema.org/draft-04/schema#"
              ]}
           )

  @draft06 Xema.new(
             {[:map, :boolean],
              [
                default: %{},
                definitions: %{
                  "nonNegativeInteger" => {:integer, [minimum: 0]},
                  "nonNegativeIntegerDefault0" => [
                    all_of: [
                      {:ref, "#/definitions/nonNegativeInteger"},
                      [default: 0]
                    ]
                  ],
                  "schemaArray" => {:list, [items: {:ref, "#"}, min_items: 1]},
                  "simpleTypes" => [
                    enum: [
                      "array",
                      "boolean",
                      "integer",
                      "null",
                      "number",
                      "object",
                      "string"
                    ]
                  ],
                  "stringArray" => {:list, [default: [], items: :string, unique_items: true]}
                },
                id: "http://json-schema.org/draft-06/schema#",
                properties: %{
                  "uniqueItems" => {:boolean, [default: false]},
                  "maximum" => :number,
                  "title" => :string,
                  "propertyNames" => {:ref, "#"},
                  "multipleOf" => {:number, [exclusive_minimum: 0]},
                  "anyOf" => {:ref, "#/definitions/schemaArray"},
                  "format" => :string,
                  "exclusiveMinimum" => :number,
                  "examples" => {:list, [items: :any]},
                  "minimum" => :number,
                  "contains" => {:ref, "#"},
                  "definitions" => {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "minItems" => {:ref, "#/definitions/nonNegativeIntegerDefault0"},
                  "additionalProperties" => {:ref, "#"},
                  "patternProperties" =>
                    {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "type" => [
                    any_of: [
                      ref: "#/definitions/simpleTypes",
                      list: [
                        items: {:ref, "#/definitions/simpleTypes"},
                        min_items: 1,
                        unique_items: true
                      ]
                    ]
                  ],
                  "maxItems" => {:ref, "#/definitions/nonNegativeInteger"},
                  "dependencies" =>
                    {:map,
                     [
                       additional_properties: [
                         any_of: [ref: "#", ref: "#/definitions/stringArray"]
                       ]
                     ]},
                  "const" => :any,
                  "$schema" => {:string, [format: :uri]},
                  "maxProperties" => {:ref, "#/definitions/nonNegativeInteger"},
                  "properties" => {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "additionalItems" => {:ref, "#"},
                  "items" => [
                    any_of: [ref: "#", ref: "#/definitions/schemaArray"],
                    default: %{}
                  ],
                  "not" => {:ref, "#"},
                  "oneOf" => {:ref, "#/definitions/schemaArray"},
                  "$id" => {:string, [format: :uri_reference]},
                  "default" => :any,
                  "required" => {:ref, "#/definitions/stringArray"},
                  "description" => :string,
                  "allOf" => {:ref, "#/definitions/schemaArray"},
                  "minLength" => {:ref, "#/definitions/nonNegativeIntegerDefault0"},
                  "pattern" => {:string, [format: :regex]},
                  "$ref" => {:string, [format: :uri_reference]},
                  "enum" => {:list, [min_items: 1, unique_items: true]},
                  "exclusiveMaximum" => :number,
                  "maxLength" => {:ref, "#/definitions/nonNegativeInteger"},
                  "minProperties" => {:ref, "#/definitions/nonNegativeIntegerDefault0"}
                },
                schema: "http://json-schema.org/draft-06/schema#",
                title: "Core schema meta-schema"
              ]}
           )

  @draft07 Xema.new(
             {[:map, :boolean],
              [
                default: true,
                definitions: %{
                  "nonNegativeInteger" => {:integer, [minimum: 0]},
                  "nonNegativeIntegerDefault0" => [
                    all_of: [
                      {:ref, "#/definitions/nonNegativeInteger"},
                      [default: 0]
                    ]
                  ],
                  "schemaArray" => {:list, [items: {:ref, "#"}, min_items: 1]},
                  "simpleTypes" => [
                    enum: [
                      "array",
                      "boolean",
                      "integer",
                      "null",
                      "number",
                      "object",
                      "string"
                    ]
                  ],
                  "stringArray" => {:list, [default: [], items: :string, unique_items: true]}
                },
                id: "http://json-schema.org/draft-07/schema#",
                properties: %{
                  "uniqueItems" => {:boolean, [default: false]},
                  "maximum" => :number,
                  "title" => :string,
                  "propertyNames" => {:ref, "#"},
                  "multipleOf" => {:number, [exclusive_minimum: 0]},
                  "anyOf" => {:ref, "#/definitions/schemaArray"},
                  "format" => :string,
                  "exclusiveMinimum" => :number,
                  "examples" => {:list, [items: true]},
                  "minimum" => :number,
                  "contains" => {:ref, "#"},
                  "definitions" => {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "minItems" => {:ref, "#/definitions/nonNegativeIntegerDefault0"},
                  "additionalProperties" => {:ref, "#"},
                  "patternProperties" =>
                    {:map,
                     [
                       additional_properties: {:ref, "#"},
                       default: %{},
                       property_names: [format: :regex]
                     ]},
                  "contentMediaType" => :string,
                  "type" => [
                    any_of: [
                      ref: "#/definitions/simpleTypes",
                      list: [
                        items: {:ref, "#/definitions/simpleTypes"},
                        min_items: 1,
                        unique_items: true
                      ]
                    ]
                  ],
                  "maxItems" => {:ref, "#/definitions/nonNegativeInteger"},
                  "readOnly" => {:boolean, [default: false]},
                  "else" => {:ref, "#"},
                  "dependencies" =>
                    {:map,
                     [
                       additional_properties: [
                         any_of: [ref: "#", ref: "#/definitions/stringArray"]
                       ]
                     ]},
                  "$comment" => :string,
                  "const" => true,
                  "$schema" => {:string, [format: :uri]},
                  "maxProperties" => {:ref, "#/definitions/nonNegativeInteger"},
                  "properties" => {:map, [additional_properties: {:ref, "#"}, default: %{}]},
                  "additionalItems" => {:ref, "#"},
                  "items" => [
                    any_of: [ref: "#", ref: "#/definitions/schemaArray"],
                    default: true
                  ],
                  "not" => {:ref, "#"},
                  "oneOf" => {:ref, "#/definitions/schemaArray"},
                  "$id" => {:string, [format: :uri_reference]},
                  "if" => {:ref, "#"},
                  "then" => {:ref, "#"},
                  "default" => true,
                  "required" => {:ref, "#/definitions/stringArray"},
                  "description" => :string,
                  "allOf" => {:ref, "#/definitions/schemaArray"},
                  "minLength" => {:ref, "#/definitions/nonNegativeIntegerDefault0"},
                  "pattern" => {:string, [format: :regex]},
                  "$ref" => {:string, [format: :uri_reference]},
                  "enum" => {:list, [items: true, min_items: 1, unique_items: true]},
                  "contentEncoding" => :string,
                  "exclusiveMaximum" => :number,
                  "maxLength" => {:ref, "#/definitions/nonNegativeInteger"},
                  "minProperties" => {:ref, "#/definitions/nonNegativeIntegerDefault0"}
                },
                schema: "http://json-schema.org/draft-07/schema#",
                title: "Core schema meta-schema"
              ]}
           )

  @doc false
  @spec meta_schemas() :: [{Regex.t(), term()}]
  defp meta_schemas do
    [
      {~r|^https?://json-schema\.org/draft-04/schema#?|i, @draft04},
      {~r|^https?://json-schema\.org/draft-06/schema#?|i, @draft06},
      {~r|^https?://json-schema\.org/draft-07/schema#?|i, @draft07}
    ]
  end

  @doc """
  This function validates schemas against:
  + http://json-schema.org/draft-04/schema#
  + http://json-schema.org/draft-06/schema#
  + http://json-schema.org/draft-07/schema#
  """
  @spec validate(String.t(), any) :: Xema.Validator.result()
  def validate(uri, value) do
    case find_matching_schema(uri) do
      nil -> raise(SchemaError, "Unknown $schema #{uri}.")
      schema -> Xema.validate(schema, value)
    end
  end

  @spec find_matching_schema(String.t()) :: term() | nil
  defp find_matching_schema(uri) do
    Enum.find_value(meta_schemas(), fn {regex, schema} ->
      Regex.match?(regex, uri) && schema
    end)
  end
end
