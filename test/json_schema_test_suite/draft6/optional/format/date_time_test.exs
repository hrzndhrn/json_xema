defmodule JsonSchemaTestSuite.Draft6.Optional.Format.DateTimeTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|validation of date-time strings| do
    setup do
      %{schema: JsonXema.new(%{"format" => "date-time"})}
    end

    test ~s|a valid date-time string|, %{schema: schema} do
      assert valid?(schema, "1963-06-19T08:30:06.283185Z")
    end

    test ~s|a valid date-time string without second fraction|, %{schema: schema} do
      assert valid?(schema, "1963-06-19T08:30:06Z")
    end

    test ~s|a valid date-time string with plus offset|, %{schema: schema} do
      assert valid?(schema, "1937-01-01T12:00:27.87+00:20")
    end

    test ~s|a valid date-time string with minus offset|, %{schema: schema} do
      assert valid?(schema, "1990-12-31T15:59:50.123-08:00")
    end

    test ~s|a invalid day in date-time string|, %{schema: schema} do
      refute valid?(schema, "1990-02-31T15:59:60.123-08:00")
    end

    test ~s|an invalid offset in date-time string|, %{schema: schema} do
      refute valid?(schema, "1990-12-31T15:59:60-24:00")
    end

    test ~s|an invalid closing Z after time-zone offset|, %{schema: schema} do
      refute valid?(schema, "1963-06-19T08:30:06.28123+01:00Z")
    end

    test ~s|an invalid date-time string|, %{schema: schema} do
      refute valid?(schema, "06/19/1963 08:30:06 PST")
    end

    test ~s|case-insensitive T and Z|, %{schema: schema} do
      assert valid?(schema, "1963-06-19t08:30:06.283185z")
    end

    test ~s|only RFC3339 not all of ISO 8601 are valid|, %{schema: schema} do
      refute valid?(schema, "2013-350T01:01:01")
    end

    test ~s|invalid non-padded month dates|, %{schema: schema} do
      refute valid?(schema, "1963-6-19T08:30:06.283185Z")
    end

    test ~s|invalid non-padded day dates|, %{schema: schema} do
      refute valid?(schema, "1963-06-1T08:30:06.283185Z")
    end
  end
end
