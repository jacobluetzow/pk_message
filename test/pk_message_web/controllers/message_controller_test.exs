defmodule PkMessageWeb.MessageControllerTest do
  use ExUnit.Case
  use PkMessageWeb.ConnCase

  @create_attrs %{
    message: "some message",
    queue: "q1"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "receive message" do
    test "returns 200 OK status code", %{conn: conn} do
      conn = get(conn, Routes.message_path(conn, :receive_message, @create_attrs.queue, @create_attrs.message))

      assert response(conn, 200)
    end
  end
end
