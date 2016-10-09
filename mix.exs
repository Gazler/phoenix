defmodule Phoenix.Mixfile do
  use Mix.Project

  @version "1.3.0-dev"

  def project do
    [app: :phoenix,
     version: @version,
     elixir: "~> 1.3",
     deps: deps(),
     package: package(),

     # Because we define protocols on the fly to test
     # Phoenix.Param, we need to disable consolidation
     # for the test environment for Elixir v1.2 onward.
     consolidate_protocols: Mix.env != :test,
     xref: [exclude: [Ecto.Type]],

     name: "Phoenix",
     docs: [source_ref: "v#{@version}",
            main: "overview",
            logo: "logo.png",
            extra_section: "GUIDES",
            extras: extras()],
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
           gzippable_exts: ~w(.js .css .txt .text .html .json .svg)]]
  end

  defp deps do
    [{:cowboy, "~> 1.0", optional: true},
     {:plug, "~> 1.2.1 or ~> 1.3"},
     {:phoenix_pubsub, "~> 1.0"},
     {:poison, "~> 1.5 or ~> 2.0"},
     {:gettext, "~> 0.8", only: :test},

     # Docs dependencies
     {:ex_doc, "~> 0.12", only: :docs},
     {:inch_ex, "~> 0.2", only: :docs},
     {:phoenix_guides, git: "https://github.com/phoenixframework/phoenix_guides.git", compile: false, app: false, only: :docs},

     # Test dependencies
     {:phoenix_html, "~> 2.6", only: :test},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client.git", only: :test}]
  end

  defp package do
    [maintainers: ["Chris McCord", "José Valim", "Lance Halvorsen",
                   "Jason Stiebs", "Eric Meadows-Jönsson", "Sonny Scroggin"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/phoenixframework/phoenix"},
     files: ~w(lib priv web) ++
            ~w(brunch-config.js CHANGELOG.md LICENSE.md mix.exs package.json README.md)]
  end

  defp extras do
    [
      # Introduction
      "deps/phoenix_guides/introduction/A_overview.md": [title: "Overview", path: "overview"],
      "deps/phoenix_guides/introduction/E_installation.md": [title: "Installation", path: "installation"],
      "deps/phoenix_guides/introduction/I_learning.md": [title: "Learning", path: "learning"],
      "deps/phoenix_guides/introduction/L_community.md": [title: "Community", path: "community"],

      # Guides
      "deps/phoenix_guides/A_up_and_running.md": [title: "Up and Running", path: "up-and-running"],
      "deps/phoenix_guides/B_adding_pages.md": [title: "Adding Pages", path: "adding-pages"],
      "deps/phoenix_guides/C_routing.md": [title: "Routing", path: "routing"],
      "deps/phoenix_guides/DD_Plug.md": [title: "Plug", path: "plug"],
      "deps/phoenix_guides/D_Controllers.md": [title: "Controllers", path: "controllers"],
      "deps/phoenix_guides/E_views.md": [title: "Views", path: "views"],
      "deps/phoenix_guides/F_templates.md": [title: "Templates", path: "templates"],
      "deps/phoenix_guides/G_channels.md": [title: "Channels", path: "channels"],
      "deps/phoenix_guides/H_ecto_models.md": [title: "Ecto Models", path: "ecto-models"],

      # Testing
      "deps/phoenix_guides/testing/A_introduction.md": [title: "Testing", path: "testing"],
      "deps/phoenix_guides/testing/E_models.md": [title: "Testing Models", path: "testing-models"],
      "deps/phoenix_guides/testing/G_controllers.md": [title: "Testing Controllers", path: "testing-controllers"],
      "deps/phoenix_guides/testing/H_views.md": [title: "Testing Views", path: "testing-views"],
      "deps/phoenix_guides/testing/J_channels.md": [title: "Testing Channels", path: "testing-channels"],

      # Deployment
      "deps/phoenix_guides/deployment/A_introduction.md": [title: "Deployment", path: "deployment"],
      "deps/phoenix_guides/deployment/E_heroku.md": [title: "Deployment on Heroku", path: "deployment-heroku"],
      "deps/phoenix_guides/deployment/I_exrm_releases.md": [title: "Deployment with Exrm Releases", path: "deployment-exrm"],

      # Bonus
      "deps/phoenix_guides/bonus_guides/A_upgrading_phoenix.md": [title: "Upgrading Phoenix", path: "upgrading-phoenix"],
      "deps/phoenix_guides/bonus_guides/EE_custom_primary_key.md": [title: "Custom Primary Keys", path: "ecto-custom-primary-keys"],
      "deps/phoenix_guides/bonus_guides/E_using_mysql.md": [title: "Using MySQL", path: "using-mysql"],
      "deps/phoenix_guides/bonus_guides/G_static_assets.md": [title: "Static Assets", path: "static-assets"],
      "deps/phoenix_guides/bonus_guides/H_file_uploads.md": [title: "File Uploads", path: "file-uploads"],
      "deps/phoenix_guides/bonus_guides/I_sending_email_with_mailgun.md": [title: "Sending Email with MailGun", path: "mailgun"],
      "deps/phoenix_guides/bonus_guides/I_sending_email_with_smtp.md": [title: "Sending Email with SMTP", path: "smtp"],
      "deps/phoenix_guides/bonus_guides/J_sessions.md": [title: "Sessions", path: "sessions"],
      "deps/phoenix_guides/bonus_guides/M_custom_errors.md": [title: "Custom Errors", path: "custom-errors"],
      "deps/phoenix_guides/bonus_guides/P_using_ssl.md": [title: "Using SSL", path: "configuration-ssl"],
      "deps/phoenix_guides/bonus_guides/S_phoenix_behind_proxy.md": [title: "Phoenix Behind a Proxy", path: "proxy"],
      "deps/phoenix_guides/bonus_guides/F_config.md": [title: "Configuration", path: "configuration"],
      "deps/phoenix_guides/bonus_guides/V_learning_elixir.md": [title: "Learning Elixir and Erlang", path: "learning-elixir-and-erlang"],
      "deps/phoenix_guides/bonus_guides/X_seeding_data.md": [title: "Seeding Data", path: "seeding-data"],
    ]
  end
end
