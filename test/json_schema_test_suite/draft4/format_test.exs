defmodule JsonSchemaTestSuite.Draft4.FormatTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|validation of e-mail addresses| do
    setup do
      %{schema: JsonXema.new(%{"format" => "email"})}
    end

    test ~s|ignores integers|, %{schema: schema} do
      assert valid?(schema, 12)
    end

    test ~s|ignores floats|, %{schema: schema} do
      assert valid?(schema, 13.7)
    end

    test ~s|ignores objects|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores booleans|, %{schema: schema} do
      assert valid?(schema, false)
    end

    test ~s|ignores null|, %{schema: schema} do
      assert valid?(schema, nil)
    end
  end

  describe ~s|validation of IP addresses| do
    setup do
      %{schema: JsonXema.new(%{"format" => "ipv4"})}
    end

    test ~s|ignores integers|, %{schema: schema} do
      assert valid?(schema, 12)
    end

    test ~s|ignores floats|, %{schema: schema} do
      assert valid?(schema, 13.7)
    end

    test ~s|ignores objects|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores booleans|, %{schema: schema} do
      assert valid?(schema, false)
    end

    test ~s|ignores null|, %{schema: schema} do
      assert valid?(schema, nil)
    end
  end

  describe ~s|validation of IPv6 addresses| do
    setup do
      %{schema: JsonXema.new(%{"format" => "ipv6"})}
    end

    test ~s|ignores integers|, %{schema: schema} do
      assert valid?(schema, 12)
    end

    test ~s|ignores floats|, %{schema: schema} do
      assert valid?(schema, 13.7)
    end

    test ~s|ignores objects|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores booleans|, %{schema: schema} do
      assert valid?(schema, false)
    end

    test ~s|ignores null|, %{schema: schema} do
      assert valid?(schema, nil)
    end
  end

  describe ~s|validation of hostnames| do
    setup do
      %{schema: JsonXema.new(%{"format" => "hostname"})}
    end

    test ~s|ignores integers|, %{schema: schema} do
      assert valid?(schema, 12)
    end

    test ~s|ignores floats|, %{schema: schema} do
      assert valid?(schema, 13.7)
    end

    test ~s|ignores objects|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores booleans|, %{schema: schema} do
      assert valid?(schema, false)
    end

    test ~s|ignores null|, %{schema: schema} do
      assert valid?(schema, nil)
    end
  end

  describe ~s|validation of date-time strings| do
    setup do
      %{schema: JsonXema.new(%{"format" => "date-time"})}
    end

    test ~s|ignores integers|, %{schema: schema} do
      assert valid?(schema, 12)
    end

    test ~s|ignores floats|, %{schema: schema} do
      assert valid?(schema, 13.7)
    end

    test ~s|ignores objects|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores booleans|, %{schema: schema} do
      assert valid?(schema, false)
    end

    test ~s|ignores null|, %{schema: schema} do
      assert valid?(schema, nil)
    end
  end

  describe ~s|validation of URIs| do
    setup do
      %{schema: JsonXema.new(%{"format" => "uri"})}
    end

    test ~s|ignores integers|, %{schema: schema} do
      assert valid?(schema, 12)
    end

    test ~s|ignores floats|, %{schema: schema} do
      assert valid?(schema, 13.7)
    end

    test ~s|ignores objects|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores booleans|, %{schema: schema} do
      assert valid?(schema, false)
    end

    test ~s|ignores null|, %{schema: schema} do
      assert valid?(schema, nil)
    end
  end
end
