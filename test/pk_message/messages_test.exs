defmodule PkMessage.MessagesTest do
  use ExUnit.Case

  alias PkMessage.{Messages, Messages.Message}

  describe "messages" do
    @invalid_attrs %{message: nil, queue: nil}

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{message: "some message", queue: "q1"}

      assert {:ok, %Message{} = message} = Messages.create_message(valid_attrs)
      assert message.message == "some message"
      assert message.queue == "q1"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

  end
end
