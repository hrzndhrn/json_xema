defmodule JsonSchemaTestSuite.Draft6.Optional.BignumTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|integer| do
    setup do
      %{schema: JsonXema.new(%{"type" => "integer"})}
    end

    test ~s|a bignum is an integer|, %{schema: schema} do
      assert valid?(
               schema,
               12_345_678_910_111_213_141_516_171_819_202_122_232_425_262_728_293_031
             )
    end
  end

  describe ~s|number| do
    setup do
      %{schema: JsonXema.new(%{"type" => "number"})}
    end

    test ~s|a bignum is a number|, %{schema: schema} do
      assert valid?(
               schema,
               98_249_283_749_234_923_498_293_171_823_948_729_348_710_298_301_928_331
             )
    end
  end

  describe ~s|integer (1)| do
    setup do
      %{schema: JsonXema.new(%{"type" => "integer"})}
    end

    test ~s|a negative bignum is an integer|, %{schema: schema} do
      assert valid?(
               schema,
               -12_345_678_910_111_213_141_516_171_819_202_122_232_425_262_728_293_031
             )
    end
  end

  describe ~s|number (1)| do
    setup do
      %{schema: JsonXema.new(%{"type" => "number"})}
    end

    test ~s|a negative bignum is a number|, %{schema: schema} do
      assert valid?(
               schema,
               -98_249_283_749_234_923_498_293_171_823_948_729_348_710_298_301_928_331
             )
    end
  end

  describe ~s|string| do
    setup do
      %{schema: JsonXema.new(%{"type" => "string"})}
    end

    test ~s|a bignum is not a string|, %{schema: schema} do
      refute valid?(
               schema,
               98_249_283_749_234_923_498_293_171_823_948_729_348_710_298_301_928_331
             )
    end
  end

  describe ~s|integer comparison| do
    setup do
      %{schema: JsonXema.new(%{"maximum" => 18_446_744_073_709_551_615})}
    end

    test ~s|comparison works for high numbers|, %{schema: schema} do
      assert valid?(schema, 18_446_744_073_709_551_600)
    end
  end

  describe ~s|float comparison with high precision| do
    setup do
      %{schema: JsonXema.new(%{"exclusiveMaximum" => 9.727837981879871e26})}
    end

    test ~s|comparison works for high numbers|, %{schema: schema} do
      refute valid?(schema, 9.727837981879871e26)
    end
  end

  describe ~s|integer comparison (1)| do
    setup do
      %{schema: JsonXema.new(%{"minimum" => -18_446_744_073_709_551_615})}
    end

    test ~s|comparison works for very negative numbers|, %{schema: schema} do
      assert valid?(schema, -18_446_744_073_709_551_600)
    end
  end

  describe ~s|float comparison with high precision on negative numbers| do
    setup do
      %{schema: JsonXema.new(%{"exclusiveMinimum" => -9.727837981879871e26})}
    end

    test ~s|comparison works for very negative numbers|, %{schema: schema} do
      refute valid?(schema, -9.727837981879871e26)
    end
  end
end
