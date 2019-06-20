defmodule JsonXema.NewTest do
  use ExUnit.Case, async: true

  alias JsonXema.SchemaError
  alias Xema.ValidationError

  describe "new/1" do
    test "raised a SchemaError for an invalid type" do
      message = ~s|Can't build schema! Reason: unknown type "foo"|

      assert_raise SchemaError, message, fn ->
        ~s({"type": "foo"})
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end

    test "raised a SchemaError for an invalid property value" do
      assert_raise SchemaError, fn ->
        ~s({"type": "object", "properties": "foo"})
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end
  end

  describe "new/1 with $schema draft04" do
    test "raised a SchemaError for an invalid type" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-04/schema#",
            "type": "foo"
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{
                 properties: %{
                   "type" => %{
                     any_of: [
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
                       %{type: :list, value: "foo"}
                     ],
                     value: "foo"
                   }
                 }
               }
             }
    end

    test "raised a SchemaError for an invalid property value" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-04/schema#",
            "type": "object",
            "properties": "foo"
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{properties: %{"properties" => %{type: :map, value: "foo"}}}
             }
    end

    test "raised an SchemaError for an invalid exclusiveMaximum" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-04/schema#",
            "exclusiveMaximum": 100,
            "maximum": 100
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{
                 properties: %{
                   "exclusiveMaximum" => %{type: :boolean, value: 100}
                 }
               }
             }
    end
  end

  describe "new/1 with $schema draft06" do
    test "raised a SchemaError for an invalid type" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-06/schema#",
            "type": "foo"
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{
                 properties: %{
                   "type" => %{
                     any_of: [
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
                       %{type: :list, value: "foo"}
                     ],
                     value: "foo"
                   }
                 }
               }
             }
    end

    test "raised a SchemaError for an invalid property value" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-06/schema#",
            "type": "object",
            "properties": "foo"
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{properties: %{"properties" => %{type: :map, value: "foo"}}}
             }
    end

    test "raised an SchemaError for an invalid exclusiveMaximum" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-06/schema#",
            "exclusiveMaximum": true,
            "maximum": 100
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{
                 properties: %{
                   "exclusiveMaximum" => %{type: :number, value: true}
                 }
               }
             }
    end
  end

  describe "new/1 with $schema draft07" do
    test "raised a SchemaError for an invalid type" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-07/schema#",
            "type": "foo"
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{
                 properties: %{
                   "type" => %{
                     any_of: [
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
                       %{type: :list, value: "foo"}
                     ],
                     value: "foo"
                   }
                 }
               }
             }
    end

    test "raised a SchemaError for an invalid property value" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-07/schema#",
            "type": "object",
            "properties": "foo"
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{properties: %{"properties" => %{type: :map, value: "foo"}}}
             }
    end

    test "raised an SchemaError for an invalid exclusiveMaximum" do
      error =
        assert_raise SchemaError, fn ->
          ~s({
            "$schema": "http://json-schema.org/draft-07/schema#",
            "exclusiveMaximum": true,
            "maximum": 100
          })
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %ValidationError{
               reason: %{
                 properties: %{
                   "exclusiveMaximum" => %{type: :number, value: true}
                 }
               }
             }
    end
  end

  test "new/1 with unknown $schema" do
    message = "Unknown $schema http://json-schema.org/draft-unsupported#."

    assert_raise SchemaError, message, fn ->
      ~s({
        "$schema": "http://json-schema.org/draft-unsupported#"
      })
      |> Jason.decode!()
      |> JsonXema.new()
    end
  end

  describe "new/1 without schema" do
    @tag :only
    test "invalid data" do
      input = %{
        "properties" => %{
          "int" => %{"type" => "integer"},
          "names" => %{"type" => "array", "items" => %{"type" => "string"}},
          "num" => %{
            "anyOf" => [
              %{"type" => "integer"},
              %{"type" => "float"}
            ]
          }
        }
      }

      message = ~s|Can't build schema! Reason: unknown type "float"|

      assert_raise SchemaError, message, fn ->
        JsonXema.new(input)
      end
    end
  end
end
