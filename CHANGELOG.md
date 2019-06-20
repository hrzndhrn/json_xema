# Changelog

## 0.3.0 2019/06/20

+ update `xema` to 0.9.1
+ Change error tuple returned by `JsonXema.validate/2`. The function returns
  `{:error, JsonXema.ValidationError}` instead of `{:error, map}`.
  `ValidationError.reason` contains nearly the same value as `map` before.
+ Error messages are improved.
  ```elixir
  iex> schema = JsonXema.new(%{"type" => "string"})
  iex> {:error, error} = JsonXema.validate(schema, 6)
  iex> Exception.message(error)
  ~s|Expected "string", got 6.|
  ```


## 0.2.1 2019/03/10

+ Update `xema` to 0.8.0

## 0.2.0 2019/02/11

## 0.1.0 2018/12/30
