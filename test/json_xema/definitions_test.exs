defmodule JsonXema.DefinitionsTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "definition schema" do
    setup do
      %{schema: ~s(
        {
          "$ref": "http://json-schema.org/draft-07/schema#"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "with valid definition", %{schema: schema} do
      data = %{"definitions" => %{"foo" => %{"type" => "integer"}}}
      assert valid?(schema, data)
    end

    test "invalid definition", %{schema: schema} do
      data = %{"definitions" => %{"foo" => %{"type" => 1}}}
      refute valid?(schema, data)
    end
  end

  describe "definition schema (non-inline)" do
    setup do
      %{schema: ~s(
        {
          "$ref": "http://json-schema.org/draft-07/schema#"
        }
        ) |> Jason.decode!() |> JsonXema.new(inline: false)}
    end

    test "with valid definition", %{schema: schema} do
      data = %{"definitions" => %{"foo" => %{"type" => "integer"}}}
      assert valid?(schema, data)
    end

    test "invalid definition", %{schema: schema} do
      data = %{"definitions" => %{"foo" => %{"type" => 1}}}
      refute valid?(schema, data)
    end
  end

  describe "nested definition" do
    setup do
      %{schema: ~s(
        {
          "$ref": "http://json-schema.org/draft-07/schema#"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "two level nested definition", %{schema: schema} do
      data = %{"definition" => %{"foo" => %{"bar" => %{"type" => "integer"}}}}
      assert valid?(schema, data)
    end

    test "three level nested definition", %{schema: schema} do
      data = %{"definition" => %{"foo" => %{"bar" => %{"foo" => %{"type" => "integer"}}}}}
      assert valid?(schema, data)
    end
  end
end
