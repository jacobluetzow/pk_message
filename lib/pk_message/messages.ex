defmodule PkMessage.Messages do
  @moduledoc """
  The Messages context.
  """
  alias PkMessage.Messages.Message

  def create_message(attrs) do
    case Message.changeset(%Message{}, attrs) do
      %{valid?: true} = changeset ->
        message =
          changeset
          |> Ecto.Changeset.apply_changes()
          |> Map.put(:id, Ecto.UUID.generate())
        {:ok, message}
      changeset ->
        {:error, changeset}
    end
  end
end
