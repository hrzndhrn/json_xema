defmodule JsonXema.NewTest do
  use ExUnit.Case, async: true

  alias JsonXema.SchemaError

  describe "new/1" do
    test "raised a SchemaError for an invalid type" do
      assert_raise SchemaError, "Can't build schema!", fn ->
        """
        {"type": "foo"}
        """
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end

    test "raised a SchemaError for an invalid property value" do
      assert_raise SchemaError, fn ->
        """
        {"type": "object", "properties": "foo"}
        """
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end
  end

  describe "new/1 with $schema draft04" do
    test "raised a SchemaError for an invalid type" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "type": "foo"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
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
    end

    test "raised a SchemaError for an invalid property value" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "type": "object",
            "properties": "foo"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
               properties: %{"properties" => %{type: :map, value: "foo"}}
             }
    end

    test "raised an SchemaError for an invalid exclusiveMaximum" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "exclusiveMaximum": 100,
            "maximum": 100
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
               properties: %{
                 "exclusiveMaximum" => %{type: :boolean, value: 100}
               }
             }
    end
  end

  describe "new/1 with $schema draft06" do
    test "raised a SchemaError for an invalid type" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-06/schema#",
            "type": "foo"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
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
    end

    test "raised a SchemaError for an invalid property value" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-06/schema#",
            "type": "object",
            "properties": "foo"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
               properties: %{"properties" => %{type: :map, value: "foo"}}
             }
    end

    test "raised an SchemaError for an invalid exclusiveMaximum" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-06/schema#",
            "exclusiveMaximum": true,
            "maximum": 100
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
               properties: %{
                 "exclusiveMaximum" => %{type: :number, value: true}
               }
             }
    end
  end

  describe "new/1 with $schema draft07" do
    test "raised a SchemaError for an invalid type" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-07/schema#",
            "type": "foo"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
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
    end

    test "raised a SchemaError for an invalid property value" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-07/schema#",
            "type": "object",
            "properties": "foo"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
               properties: %{"properties" => %{type: :map, value: "foo"}}
             }
    end

    test "raised an SchemaError for an invalid exclusiveMaximum" do
      error =
        assert_raise SchemaError, fn ->
          """
          {
            "$schema": "http://json-schema.org/draft-07/schema#",
            "exclusiveMaximum": true,
            "maximum": 100
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
        end

      assert error.message =~ "Can't build schema! Reason:"

      assert error.reason == %{
               properties: %{
                 "exclusiveMaximum" => %{type: :number, value: true}
               }
             }
    end
  end

  describe "new/1 with unknown $schema" do
    message = "Unknown $schema http://json-schema.org/draft-unsupported#."

    assert_raise SchemaError, message, fn ->
      """
      {
        "$schema": "http://json-schema.org/draft-unsupported#"
      }
      """
      |> Jason.decode!()
      |> JsonXema.new()
    end
  end
end
