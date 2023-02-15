defmodule PkMessageWeb.WelcomeController do
  use PkMessageWeb, :controller

  def index(conn, _params) do
    text conn, "ProKeep Message is LIVE - #{Mix.env()}"
  end
end
