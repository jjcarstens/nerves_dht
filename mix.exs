defmodule NervesDht.Mixfile do
  use Mix.Project

  @source_url "https://github.com/jjcarstens/nerves_dht"
  @version "0.1.3"

  def project do
    [
      app: :nerves_dht,
      version: @version,
      description: description(),
      package: package(),
      compilers: [:elixir_make] ++ Mix.compilers,
      make_targets: ["all"],
      make_clean: ["clean"],
      build_embedded: true,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: docs(),
      preferred_cli_env: %{
        docs: :docs,
        "hex.publish": :docs,
        "hex.build": :docs
      }
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.6"},
      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end

  defp description() do
    "Drive of DHT 11 and DHT 22 (temperature and humidity sensor)"
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package() do
    [
      name: "nerves_dht",
      files: ["src", "lib", "mix.exs", "README.md", "LICENSE", "Makefile"],
      licenses: ["GNU 3.0"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
