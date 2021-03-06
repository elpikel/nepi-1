defmodule SensorsHubWeb.SensorsChannel do
  use SensorsHubWeb, :channel

  def join("sensors:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (sensors:lobby).
  def handle_in("onbuzzer", payload, socket) do
    broadcast socket, "buzzer", payload
    {:noreply, socket}
  end

  def handle_in("hydration", payload, socket) do
    broadcast socket, "hydration", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
