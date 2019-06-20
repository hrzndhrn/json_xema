defmodule JsonXema.ConstTest do
  use ExUnit.Case

  import JsonXema, only: [validate: 2]

  alias JsonXema.ValidationError

  describe "const validation" do
    setup do
      %{schema: ~s(
        {
          "const": 2
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "same value is valid", %{schema: schema} do
      assert validate(schema, 2) == :ok
    end

    test "another value is invalid", %{schema: schema} do
      assert {:error, error} = validate(schema, 5)
      assert error == %ValidationError{reason: %{const: 2, value: 5}}
      assert Exception.message(error) == ~s|Expected 2, got 5.|
    end

    test "another type is invalid", %{schema: schema} do
      assert {:error, error} = validate(schema, "a")
      assert error == %ValidationError{reason: %{const: 2, value: "a"}}
      assert Exception.message(error) == ~s|Expected 2, got "a".|
    end
  end

  describe "const with object" do
    setup do
      %{schema: ~s(
        {
          "const": {
            "baz": "bax",
            "foo": "bar"
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "same object is valid", %{schema: schema} do
      data = %{"baz" => "bax", "foo" => "bar"}
      assert validate(schema, data) == :ok
    end

    test "another object is invalid", %{schema: schema} do
      data = %{"foo" => "bar"}
      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{const: %{"baz" => "bax", "foo" => "bar"}, value: %{"foo" => "bar"}}
             }

      assert Exception.message(error) ==
               ~s|Expected %{"baz" => "bax", "foo" => "bar"}, got %{"foo" => "bar"}.|
    end

    test "another type is invalid", %{schema: schema} do
      data = [1, 2]
      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{const: %{"baz" => "bax", "foo" => "bar"}, value: [1, 2]}
             }

      assert Exception.message(error) ==
               ~s|Expected %{"baz" => "bax", "foo" => "bar"}, got [1, 2].|
    end
  end
end
