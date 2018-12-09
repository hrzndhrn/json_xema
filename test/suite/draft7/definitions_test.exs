defmodule Draft7.DefinitionsTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "valid definition" do
    setup do
      %{schema: ~s(
        {
          "$ref": "http://json-schema.org/draft-07/schema#"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid definition schema", %{schema: schema} do
      data = %{"definitions" => %{"foo" => %{"type" => "integer"}}}
      assert valid?(schema, data)
    end
  end

  describe "invalid definition" do
    setup do
      %{schema: ~s(
        {
          "$ref": "http://json-schema.org/draft-07/schema#"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "invalid definition schema", %{schema: schema} do
      data = %{"definitions" => %{"foo" => %{"type" => 1}}}
      refute valid?(schema, data)
    end
  end
end
