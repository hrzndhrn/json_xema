defmodule JsonXema.DataTest do
  use ExUnit.Case, async: true

  describe "custom data: " do
    test "additional data goes to the data map" do
      schema =
        ~s({
          "type": "object",
          "foo": 3
        })
        |> Jason.decode!()
        |> JsonXema.new()

      assert schema.schema.data == %{"foo" => 3}
    end

    @tag :only
    test "maps are copied" do
      schema =
        ~s({
          "type": "object",
          "foo": {
            "bar": 5
            },
          "baz": 42
        })
        |> Jason.decode!()
        |> JsonXema.new()

      assert schema.schema.data == %{"foo" => %{"bar" => 5}, "baz" => 42}
    end

    test "can contain schemas" do
      schema =
        ~s({
          "type": "string",
          "foo": {
            "type": "integer"
          }
        })
        |> Jason.decode!()
        |> JsonXema.new()

      foo = ~s({"type": "integer"}) |> Jason.decode!() |> JsonXema.new()

      assert schema.schema.data == %{
               "foo" => foo.schema
             }

      schema =
        ~s({
          "type": "integer",
          "foo": {
            "minItems": 5
          }
        })
        |> Jason.decode!()
        |> JsonXema.new()

      foo = ~s({"minItems": 5}) |> Jason.decode!() |> JsonXema.new()

      assert schema.schema.data == %{
               "foo" => foo.schema
             }
    end

    test "data goes into data" do
      schema =
        ~s({
          "type": "object",
          "data": 3
        })
        |> Jason.decode!()
        |> JsonXema.new()

      assert schema.schema.data == %{"data" => 3}
    end
  end
end
