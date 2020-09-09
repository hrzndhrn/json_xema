defmodule JsonSchemaTestSuite.Draft7.Optional.Format.RegexTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|validation of regular expressions| do
    setup do
      %{schema: JsonXema.new(%{"format" => "regex"})}
    end

    test ~s|a valid regular expression|, %{schema: schema} do
      assert valid?(schema, "([abc])+\\s+$")
    end

    test ~s|a regular expression with unclosed parens is invalid|, %{schema: schema} do
      refute valid?(schema, "^(abc]")
    end
  end
end
