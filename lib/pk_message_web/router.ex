defmodule PkMessageWeb.Router do
  use PkMessageWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PkMessageWeb do
    pipe_through :api
    get "/", WelcomeController, :index
    get "/receive-message/:queue/:message", MessageController, :receive_message
  end
end
