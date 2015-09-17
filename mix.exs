defmodule Phoenix.Mixfile do
  use Mix.Project

  @version "1.0.2"

  def project do
    [app: :phoenix,
     version: @version,
     elixir: "~> 1.0.2 or ~> 1.1-beta",
     deps: deps,
     package: package,
     docs: [source_ref: "v#{@version}", main: "Phoenix", logo: "logo.png", extras: doc_extras],
     name: "Phoenix",
     source_url: "https://github.com/phoenixframework/phoenix",
     homepage_url: "http://www.phoenixframework.org",
     description: """
     Productive. Reliable. Fast. A productive web framework that
     does not compromise speed and maintainability.
     """]
  end

  def application do
    [mod: {Phoenix, []},
     applications: [:plug, :poison, :logger, :eex],
     env: [stacktrace_depth: nil,
           template_engines: [],
           format_encoders: [],
           generators: [],
           filter_parameters: ["password"],
           serve_endpoints: false,
           gzippable_exts: ~w(.js .css .txt .text .html .json)]]
  end

  defp deps do
    [{:cowboy, "~> 1.0", optional: true},
     {:plug, "~> 1.0"},
     {:poison, "~> 1.3"},

     # Docs dependencies
     {:earmark, "~> 0.1", only: :docs},
     {:ex_doc, "~> 0.9", only: :docs},
     {:inch_ex, "~> 0.2", only: :docs},

     # Test dependencies
     {:phoenix_html, "~> 1.2", only: :test},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client.git", only: :test}]
  end

  defp package do
    [contributors: ["Chris McCord", "Darko Fabijan", "José Valim"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/phoenixframework/phoenix"},
     files: ~w(lib priv test/shared web) ++
            ~w(brunch-config.js CHANGELOG.md LICENSE mix.exs package.json README.md)]
  end

  defp doc_extras do
    [
     "guides/introduction/A_overview.md",
     "guides/introduction/E_installation.md",
     "guides/introduction/I_learning.md",
     "guides/introduction/L_community.md",

     "guides/A_up_and_running.md",
     "guides/B_adding_pages.md",
     "guides/C_routing.md",
     "guides/D_controllers.md",
     "guides/DD_Plug.md",
     "guides/E_views.md",
     "guides/F_templates.md",
     "guides/G_channels.md",
     "guides/H_ecto_models.md",

     "guides/testing/A_introduction.md",
     "guides/testing/E_models.md",

     "guides/deployment/A_introduction.md",
     "guides/deployment/E_heroku.md",
     "guides/deployment/I_exrm_releases.md",

     "guides/bonus_guides/A_upgrading_phoenix.md",
     "guides/bonus_guides/D_mix_tasks.md",
     "guides/bonus_guides/E_using_mysql.md",
     "guides/bonus_guides/EE_custom_primary_key.md",
     "guides/bonus_guides/F_config.md",
     "guides/bonus_guides/G_static_assets.md",
     "guides/bonus_guides/H_file_uploads.md",
     "guides/bonus_guides/I_sending_email.md",
     "guides/bonus_guides/J_sessions.md",
     "guides/bonus_guides/M_custom_errors.md",
     "guides/bonus_guides/P_using_ssl.md",
     "guides/bonus_guides/S_phoenix_behind_proxy.md",
     "guides/bonus_guides/V_learning_elixir.md"
    ]
  end
end
