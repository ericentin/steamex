defmodule Steamex.Mixfile do
  use Mix.Project

  @version "0.0.6"

  def project do
    [app: :steamex,
     version: @version,
     elixir: "~> 1.0",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "Steamex",
     docs: [source_ref: "v#{@version}", main: "Steamex",
            source_url: "https://github.com/antipax/steamex"]
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:sweet_xml, "~> 0.6"},

      {:plug, "~> 1.3", optional: true},

      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end

  defp description do
    "Steam API and Auth (with Phoenix/Plug integration) for Elixir"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Eric Entin"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/antipax/steamex"
      }
    ]
  end
end
