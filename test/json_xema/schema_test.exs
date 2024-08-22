defmodule Xema.SchemaTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias JsonXema.ValidationError

  describe "validat/2 with schema draft04" do
    setup do
      %{
        draft04:
          "test/support/schema/draft04.json"
          |> File.read!()
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "returns :ok for empty object", %{draft04: schema} do
      assert validate(schema, %{}) == :ok

      schema = Map.put(schema, "$schema", "http://json-schema.org/draft-04/schema")
      assert validate(schema, %{}) == :ok
      schema = Map.put(schema, "$schema", "https://json-schema.org/draft-04/schema")
      assert validate(schema, %{}) == :ok
      schema = Map.put(schema, "$schema", "https://json-schema.org/draft-04/schema#")
      assert validate(schema, %{}) == :ok
    end

    test "returns an error for a wrong type", %{draft04: schema} do
      data =
        Jason.decode!("""
          {"type": "foo"}
        """)

      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "type" => %{
                     anyOf: [
                       %{
                         enum: [
                           "array",
                           "boolean",
                           "integer",
                           "null",
                           "number",
                           "object",
                           "string"
                         ],
                         value: "foo"
                       },
                       %{type: "array", value: "foo"}
                     ],
                     value: "foo"
                   }
                 }
               }
             }
    end
  end

  describe "validat/2 with schema draft06" do
    setup do
      %{
        draft06:
          "test/support/schema/draft06.json"
          |> File.read!()
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "returns :ok for empty object", %{draft06: schema} do
      assert validate(schema, Jason.decode!("{}")) == :ok

      schema = Map.put(schema, "$schema", "http://json-schema.org/draft-06/schema")
      assert validate(schema, %{}) == :ok
      schema = Map.put(schema, "$schema", "https://json-schema.org/draft-06/schema")
      assert validate(schema, %{}) == :ok
      schema = Map.put(schema, "$schema", "https://json-schema.org/draft-06/schema#")
      assert validate(schema, %{}) == :ok
    end

    test "returns an error for a wrong type", %{draft06: schema} do
      data =
        Jason.decode!("""
          {"type": "foo"}
        """)

      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "type" => %{
                     anyOf: [
                       %{
                         enum: [
                           "array",
                           "boolean",
                           "integer",
                           "null",
                           "number",
                           "object",
                           "string"
                         ],
                         value: "foo"
                       },
                       %{type: "array", value: "foo"}
                     ],
                     value: "foo"
                   }
                 }
               }
             }
    end
  end

  describe "validat/2 with schema draft07" do
    setup do
      %{
        draft07:
          "test/support/schema/draft07.json"
          |> File.read!()
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "returns :ok for empty object", %{draft07: schema} do
      assert validate(schema, Jason.decode!("{}")) == :ok

      schema = Map.put(schema, "$schema", "http://json-schema.org/draft-07/schema")
      assert validate(schema, %{}) == :ok
      schema = Map.put(schema, "$schema", "https://json-schema.org/draft-07/schema")
      assert validate(schema, %{}) == :ok
      schema = Map.put(schema, "$schema", "https://json-schema.org/draft-07/schema#")
      assert validate(schema, %{}) == :ok
    end

    test "returns an error for a wrong type", %{draft07: schema} do
      data =
        Jason.decode!("""
          {"type": "foo"}
        """)

      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "type" => %{
                     anyOf: [
                       %{
                         enum: [
                           "array",
                           "boolean",
                           "integer",
                           "null",
                           "number",
                           "object",
                           "string"
                         ],
                         value: "foo"
                       },
                       %{type: "array", value: "foo"}
                     ],
                     value: "foo"
                   }
                 }
               }
             }
    end
  end
end
