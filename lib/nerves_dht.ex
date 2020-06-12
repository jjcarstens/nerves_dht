defmodule NervesDht do

  @moduledoc File.read!("README.md")
             |> String.split("<!-- DOCS -->")
             |> Enum.at(1)

  defmacro __using__(_opts) do
    quote do
      use GenServer

      def start_link({pin, sensor}, options \\ []) do
        GenServer.start_link(__MODULE__, {pin, sensor}, options)
      end

      @impl true
      def init({pin, sensor}) do
        Port.open({:spawn, "#{path()} #{pin} #{sensor}"}, [:binary, packet: 2])
        {:ok, {:ok, pin, sensor, nil, nil}}
      end

      @impl true
      def handle_info({_port, {:data, data}}, prev_state) do
        states = :erlang.binary_to_term(data)
        __MODULE__.listen(states)

        # Only keep last known temp around
        state = if elem(states, 0) == :ok, do: states, else: prev_state

        {:noreply, state}
      end

      @impl true
      def handle_call(:info, _from, state), do: {:reply, state, state}

      defp path, do: "#{:code.priv_dir(:nerves_dht)}/nerves_dht"

      def info(pid) do
        case GenServer.call(pid, :info) do
          {:ok, _pin, _sensor, hum, tem} ->
            {:ok, hum, tem}
          e -> e
        end
      end

      def listen(states), do: states
      defoverridable [listen: 1]

    end
  end

end
