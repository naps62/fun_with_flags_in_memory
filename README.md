# FunWithFlags - InMemory Adapter

An adapter for [`fun_with_flags`](https://github.com/tompave/fun_with_flags)
that uses a GenServer to keep everything in memory.

Useful for unit testing your code without having to mock `FunWithFlags`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fun_with_flags_in_memory` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fun_with_flags_in_memory, "~> 0.1.0"}
  ]
end
```

### Configuration

Configure `FunWithFlags` to use this adapter while in test mode:

```
# config/test.exs

config :fun_with_flags, :persistence,
  adapter: FunWithFlags.Store.Persistent.InMemory
```

### Usage

The adapter doesn't clean up by itself automatically after each test.

The current aproach is to manually clean up each flag. For example:

```elixir
defmodule Tests do
  describe "a disabled feature" do
    setup do
      Flags.enable(:my_feature_flag)

      on_exit fn ->
        Flags.clear(:my_feature_flag)
      end
    end
  end
end
```
