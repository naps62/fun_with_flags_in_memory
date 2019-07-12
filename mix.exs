defmodule FunWithFlagsInMemory.MixProject do
  use Mix.Project

  def project do
    [
      app: :fun_with_flags_in_memory,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:fun_with_flags, "~> 1.4.0"},
      {:ecto, "~> 3.0"}
    ]
  end

  defp description do
    """
    An InMemory adapter for fun_with_flags, for testing purposes.
    """
  end

  defp package do
    [
      maintainers: [
        "Miguel Palhas"
      ],
      licenses: [
        "MIT"
      ],
      links: %{
        "GitHub" => "https://github.com/naps62/fun_with_flags"
      }
    ]
  end
end
