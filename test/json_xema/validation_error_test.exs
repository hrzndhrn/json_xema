defmodule JsonXema.ValidationErrorTest do
  use ExUnit.Case, async: true

  doctest JsonXema.ValidationError

  alias JsonXema.ValidationError
  alias Xema.Validator

  describe "Xema.validate!/2" do
    setup do
      %{schema: ~s|{"type": "integer"}| |> Jason.decode!() |> JsonXema.new()}
    end

    test "returns a ValidationError for invalid data", %{schema: schema} do
      JsonXema.validate!(schema, "foo")
    rescue
      error ->
        assert %ValidationError{} = error
        assert error.message == nil
        assert Exception.message(error) == ~s|Expected "integer", got "foo".|
        assert error.reason == %{type: "integer", value: "foo"}
    end
  end

  describe "format_error/1" do
    setup do
      %{schema: ~s|{"type": "integer"}| |> Jason.decode!() |> JsonXema.new()}
    end

    test "returns a formated error for an error tuple", %{schema: schema} do
      assert schema |> Validator.validate("foo") |> ValidationError.format_error() ==
               ~s|Expected :integer, got \"foo\".|
    end
  end

  describe "travers_errors/2" do
    test "return custom error message" do
      fun = fn _error, path, acc ->
        ["Error at " <> inspect(path) | acc]
      end

      schema =
        JsonXema.new(%{
          "properties" => %{
            "int" => %{"type" => "integer"},
            "names" => %{
              "type" => "array",
              "items" => %{"type" => "string"}
            },
            "num" => %{
              "anyOf" => [
                %{"type" => "integer"},
                %{"type" => "number"}
              ]
            }
          }
        })

      data = %{"int" => "x", "names" => [1, "x", 5], "num" => :foo}

      expected = [
        ~s|Error at ["num"]|,
        ~s|Error at ["names", 2]|,
        ~s|Error at ["names", 0]|,
        ~s|Error at ["names"]|,
        ~s|Error at ["int"]|,
        ~s|Error at []|
      ]

      assert {:error, error} = exception = JsonXema.validate(schema, data)
      assert ValidationError.travers_errors(error.reason, [], fun) == expected
      assert ValidationError.travers_errors(exception, [], fun) == expected
    end
  end

  describe "to_jsonable/1" do
    test "returns json for a tiny schema" do
      schema = JsonXema.new(%{"type" => "number"})

      data = "data"

      expected = %{type: "number", value: "data"}

      assert {:error, error} = exception = JsonXema.validate(schema, data)
      assert ValidationError.to_jsonable(error.reason) == expected
      assert ValidationError.to_jsonable(exception) == expected
      assert {:ok, _json} = ValidationError.to_jsonable(exception) |> Jason.encode()
    end

    test "returns json for schema" do
      schema =
        JsonXema.new(%{
          "properties" => %{
            "int" => %{"type" => "integer"},
            "names" => %{
              "type" => "array",
              "items" => %{"type" => "string"}
            },
            "num" => %{
              "anyOf" => [
                %{"type" => "integer"},
                %{"type" => "number"}
              ]
            }
          }
        })

      data = %{"int" => "x", "names" => [1, "x", 5], "num" => :foo}

      expected = %{
        properties: %{
          "int" => %{type: "integer", value: "x"},
          "names" => %{
            items: %{0 => %{type: "string", value: 1}, 2 => %{type: "string", value: 5}}
          },
          "num" => %{
            anyOf: [
              %{type: "integer", value: :foo},
              %{type: "number", value: :foo}
            ],
            value: :foo
          }
        }
      }

      assert {:error, error} = exception = JsonXema.validate(schema, data)
      assert ValidationError.to_jsonable(error.reason) == expected
      assert ValidationError.to_jsonable(exception) == expected
      assert {:ok, _json} = ValidationError.to_jsonable(exception) |> Jason.encode()
    end
  end

  describe "exception/1" do
    test "returns unexpected error for unexpected reason" do
      error = ValidationError.exception(reason: "foo")

      assert error == %ValidationError{
               message: nil,
               reason: "foo"
             }

      assert Exception.message(error) == "Unexpected error."
    end

    test "returns unexpected error for internal exception" do
      error = ValidationError.exception(reason: %{items: {}})
      assert Exception.message(error) =~ "got Protocol.UndefinedError with message"
    end
  end
end
