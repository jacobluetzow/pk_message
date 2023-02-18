defmodule PkMessageWeb.ProcessingServer do
  use GenServer
  alias PkMessage.Messages.Message

  @process_interval :timer.seconds(1)

  def start_link(_arg) do
    IO.puts("Starting processing server...")
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    schedule_process()
    {:ok, %{}}
  end

  def message_queue(%Message{} = message) do
    GenServer.cast(__MODULE__, {:message_queue, message.queue, message.message})
  end

  def handle_cast({:message_queue, queue, message}, state) do
    new_state = add_message_queue(state, queue, message)
    {:noreply, new_state}
  end

  defp add_message_queue(state, queue, message) when is_map_key(state, queue) do
    value = Map.get(state, queue)
    Map.put(state, queue, value ++ [message])
  end

  defp add_message_queue(state, queue, message) do
    Map.put_new(state, queue, [message])
  end

  def handle_info(:process, state) do
    new_state = process_queues(state)
    schedule_process()
    {:noreply, new_state}
  end

  defp schedule_process do
    Process.send_after(self(), :process, @process_interval)
  end

  defp process_queues(state) do
    queue_list = Map.keys(state)

    if length(queue_list) > 0,
      do: IO.puts("*****************1 SEC BATCH*****************")

    process_queue(state, queue_list, 0)
  end

  defp(process_queue(state, queue_list, idx)) do
    if idx < length(queue_list) do
      queue = Enum.at(queue_list, idx)
      messages = Map.get(state, queue)

      IO.puts("Queue: #{queue}, Message: #{List.first(messages)}")

      new_state = remove_sent_messages(state, queue, messages)
      process_queue(new_state, queue_list, idx + 1)
    else
      state
    end
  end

  defp remove_sent_messages(state, queue, messages) when length(messages) > 1 do
    {_removed, updated_messages} = List.pop_at(messages, 0)
    Map.put(state, queue, updated_messages)
  end

  defp remove_sent_messages(state, queue, _messages) do
    Map.delete(state, queue)
  end
end
