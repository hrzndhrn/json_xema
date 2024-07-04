defmodule JsonXema.ValidationErrorTest do
  use ExUnit.Case, async: false

  doctest JsonXema.ValidationError
  doctest JsonXema.ValidationError.Formatter
  doctest JsonXema.ValidationError.DefaultFormatter

  alias JsonXema.ValidationError

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

  describe "format_error" do
    setup do
      %{schema: ~s|{"type": "integer"}| |> Jason.decode!() |> JsonXema.new()}
    end

    test "returns an error message for an error", %{schema: schema} do
      error = JsonXema.validate(schema, %{a: 1})

      assert ValidationError.format_error(error) == """
             Expected \"integer\", got %{a: 1}.\
             """
    end

    test "returns an error message for an error with opts", %{schema: schema} do
      error = JsonXema.validate(schema, %{a: 1})

      inspect_fun = fn value, _opts ->
        Jason.encode!(value, pretty: true)
      end

      assert ValidationError.format_error(error, inspect_fun: inspect_fun) == """
             Expected \"integer\", got {
               "a": 1
             }.\
             """
    end

    test "returns an error message for an error with path_fun" do
      schema =
        """
        {"properties": {
          "int": {"type": "array", "items": {"type": "integer"}}
        }}
        """
        |> Jason.decode!()
        |> JsonXema.new()

      error = JsonXema.validate(schema, %{"int" => [1, "foo"]})

      path_fun = fn path, _opts ->
        "./" <> Enum.join(path, "/")
      end

      assert ValidationError.format_error(error, path_fun: path_fun) == """
             Expected \"integer\", got "foo", at ./int/1.\
             """
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
