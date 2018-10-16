defmodule Phoenix.NotAcceptableError do
  @moduledoc """
  Raised when one of the `accept*` headers is not accepted by the server.

  This exception is commonly raised by `Phoenix.Controller.accepts/2`
  which negotiates the media types the server is able to serve with
  the contents the client is able to render.

  If you are seeing this error, you should check if you are listing
  the desired formats in your `:accepts` plug or if you are setting
  the proper accept header in the client. The exception contains the
  acceptable mime types in the `accepts` field.
  """

  defexception message: nil, accepts: [], plug_status: 406
end

defmodule Phoenix.MissingParamError do
  @moduledoc """
  Raised when a key is expected to be present in the request parameters,
  but is not.

  This exception is raised by `Phoenix.Controller.scrub_params/2` which:

    * Checks to see if the required_key is present (can be empty)
    * Changes all empty parameters to nils ("" -> nil)

  If you are seeing this error, you should handle the error and surface it
  to the end user. It means that there is a parameter missing from the request.
  """

  defexception [:message, plug_status: 400]

  def exception([key: value]) do
    msg = "expected key #{inspect value} to be present in params, " <>
          "please send the expected key or adapt your scrub_params/2 call"
    %Phoenix.MissingParamError{message: msg}
  end
end

defmodule Phoenix.ActionClauseError do
  defexception [:controller, :action, :arity, :args, :params, :message, :kind, :clauses, plug_status: 400]

  def message(exception) do
    %{controller: module, action: action, arity: arity} = exception
    formatted = Exception.format_mfa(module, action, arity)
    blamed = blame(exception, &inspect/1, &blame_match/2)
    "no controller action clause matching in #{formatted}" <> blamed
  end

  def blame(%{controller: controller, action: action, arity: arity} = exception, stacktrace) do
    case stacktrace do
      [{^controller, ^action, args, meta} | rest] when length(args) == arity ->
        exception =
          case Exception.blame_mfa(controller, action, args) do
            {:ok, kind, clauses} -> %{exception | args: args, kind: kind, clauses: clauses}
            :error -> %{exception | args: args}
          end

        {exception, [{controller, action, arity, meta} | rest]}

      stacktrace ->
        {exception, stacktrace}
    end
  end

  defp blame_match(%{match?: true, node: node}, _), do: Macro.to_string(node)
  defp blame_match(%{match?: false, node: node}, _), do: "-" <> Macro.to_string(node) <> "-"
  defp blame_match(_, string), do: string

  @doc false
  def blame(%{args: nil}, _, _) do
    ""
  end

  def blame(exception, inspect_fun, ast_fun) do
    %{controller: controller, action: action, arity: arity, kind: kind, args: args, clauses: clauses} = exception

    mfa = Exception.format_mfa(controller, action, arity)

    formatted_args =
      args
      |> Enum.with_index(1)
      |> Enum.map(fn {arg, i} ->
        ["\n    # ", Integer.to_string(i), "\n    ", pad(inspect_fun.(arg)), "\n"]
      end)

    formatted_clauses =
      if clauses do
        format_clause_fun = fn {args, guards} ->
          code = Enum.reduce(guards, {action, [], args}, &{:when, [], [&2, &1]})
          "    #{kind} " <> Macro.to_string(code, ast_fun) <> "\n"
        end

        top_10 =
          clauses
          |> Enum.take(10)
          |> Enum.map(format_clause_fun)

        [
          "\nAttempted action clauses (showing #{length(top_10)} out of #{length(clauses)}):",
          "\n\n",
          top_10
        ]
      else
        ""
      end

    "\n\nThe following arguments were given to #{mfa}:\n#{formatted_args}#{formatted_clauses}"
  end

  defp pad(string) do
    String.replace(string, "\n", "\n    ")
  end
end
