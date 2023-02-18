defmodule PkMessageWeb.WelcomeController do
  use PkMessageWeb, :controller

  def index(conn, _params) do
    text conn, "Pk Message is LIVE - #{Mix.env()}"
  end
end
