defmodule JsonSchemaTestSuite.Draft7.IfThenElseTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|ignore if without then or else| do
    setup do
      %{schema: JsonXema.new(%{"if" => %{"const" => 0}})}
    end

    test ~s|valid when valid against lone if|, %{schema: schema} do
      assert valid?(schema, 0)
    end

    test ~s|valid when invalid against lone if|, %{schema: schema} do
      assert valid?(schema, "hello")
    end
  end

  describe ~s|ignore then without if| do
    setup do
      %{schema: JsonXema.new(%{"then" => %{"const" => 0}})}
    end

    test ~s|valid when valid against lone then|, %{schema: schema} do
      assert valid?(schema, 0)
    end

    test ~s|valid when invalid against lone then|, %{schema: schema} do
      assert valid?(schema, "hello")
    end
  end

  describe ~s|ignore else without if| do
    setup do
      %{schema: JsonXema.new(%{"else" => %{"const" => 0}})}
    end

    test ~s|valid when valid against lone else|, %{schema: schema} do
      assert valid?(schema, 0)
    end

    test ~s|valid when invalid against lone else|, %{schema: schema} do
      assert valid?(schema, "hello")
    end
  end

  describe ~s|if and then without else| do
    setup do
      %{
        schema: JsonXema.new(%{"if" => %{"exclusiveMaximum" => 0}, "then" => %{"minimum" => -10}})
      }
    end

    test ~s|valid through then|, %{schema: schema} do
      assert valid?(schema, -1)
    end

    test ~s|invalid through then|, %{schema: schema} do
      refute valid?(schema, -100)
    end

    test ~s|valid when if test fails|, %{schema: schema} do
      assert valid?(schema, 3)
    end
  end

  describe ~s|if and else without then| do
    setup do
      %{
        schema:
          JsonXema.new(%{"else" => %{"multipleOf" => 2}, "if" => %{"exclusiveMaximum" => 0}})
      }
    end

    test ~s|valid when if test passes|, %{schema: schema} do
      assert valid?(schema, -1)
    end

    test ~s|valid through else|, %{schema: schema} do
      assert valid?(schema, 4)
    end

    test ~s|invalid through else|, %{schema: schema} do
      refute valid?(schema, 3)
    end
  end

  describe ~s|validate against correct branch, then vs else| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "else" => %{"multipleOf" => 2},
            "if" => %{"exclusiveMaximum" => 0},
            "then" => %{"minimum" => -10}
          })
      }
    end

    test ~s|valid through then|, %{schema: schema} do
      assert valid?(schema, -1)
    end

    test ~s|invalid through then|, %{schema: schema} do
      refute valid?(schema, -100)
    end

    test ~s|valid through else|, %{schema: schema} do
      assert valid?(schema, 4)
    end

    test ~s|invalid through else|, %{schema: schema} do
      refute valid?(schema, 3)
    end
  end

  describe ~s|non-interference across combined schemas| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "allOf" => [
              %{"if" => %{"exclusiveMaximum" => 0}},
              %{"then" => %{"minimum" => -10}},
              %{"else" => %{"multipleOf" => 2}}
            ]
          })
      }
    end

    test ~s|valid, but would have been invalid through then|, %{schema: schema} do
      assert valid?(schema, -100)
    end

    test ~s|valid, but would have been invalid through else|, %{schema: schema} do
      assert valid?(schema, 3)
    end
  end

  describe ~s|if with boolean schema true| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "else" => %{"const" => "else"},
            "if" => true,
            "then" => %{"const" => "then"}
          })
      }
    end

    test ~s|boolean schema true in if always chooses the then path (valid)|, %{schema: schema} do
      assert valid?(schema, "then")
    end

    test ~s|boolean schema true in if always chooses the then path (invalid)|, %{schema: schema} do
      refute valid?(schema, "else")
    end
  end

  describe ~s|if with boolean schema false| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "else" => %{"const" => "else"},
            "if" => false,
            "then" => %{"const" => "then"}
          })
      }
    end

    test ~s|boolean schema false in if always chooses the else path (invalid)|, %{schema: schema} do
      refute valid?(schema, "then")
    end

    test ~s|boolean schema false in if always chooses the else path (valid)|, %{schema: schema} do
      assert valid?(schema, "else")
    end
  end
end
