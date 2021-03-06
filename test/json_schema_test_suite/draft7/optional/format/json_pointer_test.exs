defmodule JsonSchemaTestSuite.Draft7.Optional.Format.JsonPointerTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|validation of JSON-pointers (JSON String Representation)| do
    setup do
      %{schema: JsonXema.new(%{"format" => "json-pointer"})}
    end

    test ~s|a valid JSON-pointer|, %{schema: schema} do
      assert valid?(schema, "/foo/bar~0/baz~1/%a")
    end

    test ~s|not a valid JSON-pointer (~ not escaped)|, %{schema: schema} do
      refute valid?(schema, "/foo/bar~")
    end

    test ~s|valid JSON-pointer with empty segment|, %{schema: schema} do
      assert valid?(schema, "/foo//bar")
    end

    test ~s|valid JSON-pointer with the last empty segment|, %{schema: schema} do
      assert valid?(schema, "/foo/bar/")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #1|, %{schema: schema} do
      assert valid?(schema, "")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #2|, %{schema: schema} do
      assert valid?(schema, "/foo")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #3|, %{schema: schema} do
      assert valid?(schema, "/foo/0")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #4|, %{schema: schema} do
      assert valid?(schema, "/")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #5|, %{schema: schema} do
      assert valid?(schema, "/a~1b")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #6|, %{schema: schema} do
      assert valid?(schema, "/c%d")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #7|, %{schema: schema} do
      assert valid?(schema, "/e^f")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #8|, %{schema: schema} do
      assert valid?(schema, "/g|h")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #9|, %{schema: schema} do
      assert valid?(schema, "/i\\j")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #10|, %{schema: schema} do
      assert valid?(schema, "/k\"l")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #11|, %{schema: schema} do
      assert valid?(schema, "/ ")
    end

    test ~s|valid JSON-pointer as stated in RFC 6901 #12|, %{schema: schema} do
      assert valid?(schema, "/m~0n")
    end

    test ~s|valid JSON-pointer used adding to the last array position|, %{schema: schema} do
      assert valid?(schema, "/foo/-")
    end

    test ~s|valid JSON-pointer (- used as object member name)|, %{schema: schema} do
      assert valid?(schema, "/foo/-/bar")
    end

    test ~s|valid JSON-pointer (multiple escaped characters)|, %{schema: schema} do
      assert valid?(schema, "/~1~0~0~1~1")
    end

    test ~s|valid JSON-pointer (escaped with fraction part) #1|, %{schema: schema} do
      assert valid?(schema, "/~1.1")
    end

    test ~s|valid JSON-pointer (escaped with fraction part) #2|, %{schema: schema} do
      assert valid?(schema, "/~0.1")
    end

    test ~s|not a valid JSON-pointer (URI Fragment Identifier) #1|, %{schema: schema} do
      refute valid?(schema, "#")
    end

    test ~s|not a valid JSON-pointer (URI Fragment Identifier) #2|, %{schema: schema} do
      refute valid?(schema, "#/")
    end

    test ~s|not a valid JSON-pointer (URI Fragment Identifier) #3|, %{schema: schema} do
      refute valid?(schema, "#a")
    end

    test ~s|not a valid JSON-pointer (some escaped, but not all) #1|, %{schema: schema} do
      refute valid?(schema, "/~0~")
    end

    test ~s|not a valid JSON-pointer (some escaped, but not all) #2|, %{schema: schema} do
      refute valid?(schema, "/~0/~")
    end

    test ~s|not a valid JSON-pointer (wrong escape character) #1|, %{schema: schema} do
      refute valid?(schema, "/~2")
    end

    test ~s|not a valid JSON-pointer (wrong escape character) #2|, %{schema: schema} do
      refute valid?(schema, "/~-1")
    end

    test ~s|not a valid JSON-pointer (multiple characters not escaped)|, %{schema: schema} do
      refute valid?(schema, "/~~")
    end

    test ~s|not a valid JSON-pointer (isn't empty nor starts with /) #1|, %{schema: schema} do
      refute valid?(schema, "a")
    end

    test ~s|not a valid JSON-pointer (isn't empty nor starts with /) #2|, %{schema: schema} do
      refute valid?(schema, "0")
    end

    test ~s|not a valid JSON-pointer (isn't empty nor starts with /) #3|, %{schema: schema} do
      refute valid?(schema, "a/a")
    end
  end
end
