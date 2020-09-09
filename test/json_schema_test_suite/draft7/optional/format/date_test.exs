defmodule JsonSchemaTestSuite.Draft7.Optional.Format.DateTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|validation of date strings| do
    setup do
      %{schema: JsonXema.new(%{"format" => "date"})}
    end

    test ~s|a valid date string|, %{schema: schema} do
      assert valid?(schema, "1963-06-19")
    end

    test ~s|an invalid date-time string|, %{schema: schema} do
      refute valid?(schema, "06/19/1963")
    end

    test ~s|only RFC3339 not all of ISO 8601 are valid|, %{schema: schema} do
      refute valid?(schema, "2013-350")
    end

    test ~s|invalidates non-padded month dates|, %{schema: schema} do
      refute valid?(schema, "1998-1-20")
    end

    test ~s|invalidates non-padded day dates|, %{schema: schema} do
      refute valid?(schema, "1998-01-1")
    end
  end
end
