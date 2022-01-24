defmodule FunWithFlagsInMemory.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :fun_with_flags_in_memory,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      docs: docs(),
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
      {:ex_doc, "~> 0.19", only: :dev},
      {:ecto, "~> 3.0"},
      {:fun_with_flags, ">= 1.4.0"}
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
        "GitHub" => "https://github.com/naps62/fun_with_flags_in_memory"
      }
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "FunWithFlags.Store.Persistent.InMemory",
      source_url: "https://github.com/naps62/fun_with_flags_in_memory/",
      source_ref: "v#{@version}"
    ]
  end
end
