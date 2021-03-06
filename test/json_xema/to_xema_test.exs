defmodule JsonXema.ToXema do
  use ExUnit.Case, async: true

  describe "to_xema/1 converts JsonXema to Xema:" do
    test "any schema" do
      json_xema = ~s({}) |> Jason.decode!() |> JsonXema.new()

      expected = Xema.new(:any)

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end

    test "list schema" do
      json_xema = ~s(
        {
          "type": "array",
          "items": [
            {"type": "string"},
            {"type": "number", "minimum": 4}
          ]
        }
      ) |> Jason.decode!() |> JsonXema.new()
      expected = Xema.new({:list, items: [:string, {:number, minimum: 4}]})

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end

    test "object schema" do
      json_xema = ~s(
        {
          "type": "object",
          "properties": {
            "foo": {"type": "string"},
            "bar": {"type": "number", "maximum": 4}
          }
        }
      ) |> Jason.decode!() |> JsonXema.new()

      expected =
        Xema.new(
          {:map,
           properties: %{
             "bar" => {:number, maximum: 4},
             "foo" => :string
           }}
        )

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end

    test "multi type" do
      json_xema = ~s(
        {"type": ["integer", "null"]}
      ) |> Jason.decode!() |> JsonXema.new()

      expected = Xema.new([:integer, nil])

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end

    test "unique items from string" do
      json_xema = ~s(
        {"uniqueItems": true}
      ) |> Jason.decode!() |> JsonXema.new()

      expected = Xema.new(unique_items: true)

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end

    test "dependencies with boolean subschemas" do
      json_xema = ~s(
        {
          "dependencies": {
            "foo": true,
            "bar": false
          }
        }
      ) |> Jason.decode!() |> JsonXema.new()

      expected = Xema.new(dependencies: %{"bar" => false, "foo" => true})

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end

    test "const" do
      json_xema = ~s({ "const": 44 }) |> Jason.decode!() |> JsonXema.new()

      expected = Xema.new(const: 44)

      assert %Xema{} = xema = JsonXema.to_xema(json_xema)
      assert Xema.source(xema) == Xema.source(expected)
    end
  end
end
