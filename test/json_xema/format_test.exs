defmodule JsonXema.FormatTest do
  use ExUnit.Case

  import JsonXema, only: [validate: 2]

  alias JsonXema.ValidationError

  describe "validation of time strings" do
    setup do
      %{schema: ~s(
        {
          "format": "time"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "a valid time string", %{schema: schema} do
      data = "08:30:06.283185Z"
      assert validate(schema, data) == :ok
    end

    test "an invalid time string", %{schema: schema} do
      data = "08:30:06 PST"
      assert {:error, error} = validate(schema, data)
      assert error == %ValidationError{reason: %{value: "08:30:06 PST", format: "time"}}

      assert Exception.message(error) ==
               ~s|String "08:30:06 PST" does not validate against format "time".|
    end

    test "only RFC3339 not all of ISO 8601 are valid", %{schema: schema} do
      data = "01:01:01,1111"
      assert {:error, error} = validate(schema, data)
      assert error == %ValidationError{reason: %{value: "01:01:01,1111", format: "time"}}

      assert Exception.message(error) ==
               ~s|String "01:01:01,1111" does not validate against format "time".|
    end
  end

  describe "validation of date-time strings" do
    setup do
      %{schema: ~s(
        {
          "format": "date-time"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "a valid date-time string", %{schema: schema} do
      data = "1963-06-19T08:30:06.283185Z"
      assert validate(schema, data) == :ok
    end

    test "a invalid day in date-time string", %{schema: schema} do
      data = "1990-02-31T15:59:60.123-08:00"
      assert {:error, error} = validate(schema, data)

      assert Exception.message(error) =~
               ~s|does not validate against format "date-time".|
    end
  end
end
