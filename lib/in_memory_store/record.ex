if Mix.env() == :test do
  defmodule BlockchainAddresses.Flags.InMemoryStore.Record do
    @moduledoc """
    Copied verbatim from FunWithFlags.Store.Persistent.Ecto.Record
    because the original one is not available in compile-time (due to some dependencies nonsense probably, since Ecto is not a hard dependency of FunWithFlags)
    Since this is used only for testing purposes, the technical debt should be acceptable to get compilation working again
    """
    use Ecto.Schema
    import Ecto.Changeset
    alias FunWithFlags.Gate

    @primary_key {:id, :id, autogenerate: true}

    schema "fun_with_flags_toggles" do
      field(:flag_name, :string)
      field(:gate_type, :string)
      field(:target, :string)
      field(:enabled, :boolean)
    end

    @fields [:flag_name, :gate_type, :target, :enabled]

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, @fields)
      |> validate_required(@fields)
      |> unique_constraint(
        :gate_type,
        name: "fwf_flag_name_gate_target_idx",
        message: "Can't store a duplicated gate."
      )
    end

    def build(flag_name, gate) do
      {type, target} = get_type_and_target(gate)

      data = %{
        flag_name: to_string(flag_name),
        gate_type: type,
        target: target,
        enabled: gate.enabled
      }

      changeset(%__MODULE__{}, data)
    end

    def update_target(%__MODULE__{gate_type: "percentage"} = record, gate) do
      {"percentage", target} = get_type_and_target(gate)
      change(record, target: target)
    end

    # Do not just store NULL for `target: nil`, because the unique
    # index in the table does not see NULL values as equal.
    #
    def serialize_target(nil), do: "_fwf_none"
    def serialize_target(str) when is_binary(str), do: str
    def serialize_target(atm) when is_atom(atm), do: to_string(atm)

    defp get_type_and_target(%Gate{type: :percentage_of_time, for: target}) do
      {"percentage", "time/#{to_string(target)}"}
    end

    defp get_type_and_target(%Gate{type: :percentage_of_actors, for: target}) do
      {"percentage", "actors/#{to_string(target)}"}
    end

    defp get_type_and_target(%Gate{type: type, for: target}) do
      {to_string(type), serialize_target(target)}
    end
  end
end
