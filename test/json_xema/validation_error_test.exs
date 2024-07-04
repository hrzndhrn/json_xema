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
        assert Map.fetch!(error, :message) == nil
        assert Exception.message(error) == ~s|Expected "integer", got "foo".|
        assert Map.fetch!(error, :reason) == %{type: "integer", value: "foo"}
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
