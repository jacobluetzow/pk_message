defmodule PkMessageWeb.MessageController do
  use PkMessageWeb, :controller

  alias PkMessage.{Messages, Messages.Message}
  alias PkMessageWeb.ProcessingServer

  action_fallback PkMessageWeb.FallbackController

  def receive_message(conn, %{"queue" => queue, "message" => message}) do
    with {:ok, %Message{} = message} <- Messages.create_message(%{queue: queue, message: message}) do
      ProcessingServer.message_queue(message)

      conn
      |> send_resp(:ok, "<message received> ")
    end
  end
end
