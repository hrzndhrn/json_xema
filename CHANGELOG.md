# Changelog

## 0.6.5 2025/05/30

+ Fix OTP 28 compatibility by converting @schemas to runtime function.

## 0.6.4 2024/08/26

+ Make `recode` dependency only available in `dev`.

## 0.6.3 2024/08/25

+ Fix matching of `$schema`.

## 0.6.2 2023/07/28

+ Fix docs.

## 0.6.1 2022/05/11

+ Update deps.

## 0.6.0 2020/09/07

+ Adding option `:fail` to `Xema.validate/3`.

## 0.5.0 2020/08/27

+ Update xema.

### Breaking changes

+ The error data structure for `array` `items` has changed from a `list` of
  `tuple`s to a `map`. This change allows you to convert `reason` directly to
  JSON.

since: 0.5.0
```elixir
iex> schema = ~s({"type" : "array", "items" : {"type" : "string" }})
...>   |> Jason.decode!()
...>   |> JsonXema.new()
iex> validate(schema, [1, 2, "foo"])
%ValidationError{
  reason: %{
    items: %{2 => %{type: "integer", value: "foo"}}
  }
}
```

before: 0.5.0
```elixir
iex> schema = ~s({"type" : "array", "items" : {"type" : "string" }})
...>   |> Jason.decode!()
...>   |> JsonXema.new()
iex> validate(schema, [1, 2, "foo"])
%ValidationError{
  reason: %{
    items: [{2, %{type: "integer", value: "foo"}}]
  }
}
```

## 0.4.3 2020/08/26

+ Update deps.

## 0.4.2 2020/08/18

+ Minor changes.

## 0.4.1 2020/08/17

+ Fix conversion of letter case for enum.

## 0.4.0 2019/10/19

+ Update `xema` to 0.11.

## 0.3.3 2019/08/25

+ Update deps.

## 0.3.2 2019/08/22

+ Update specs.

## 0.3.1 2019/08/21

+ Bugfix for https://github.com/hrzndhrn/json_xema/issues/19

## 0.3.0 2019/06/21

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
