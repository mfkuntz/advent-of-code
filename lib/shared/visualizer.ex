defmodule AdventOfCode.Shared.Visualizer do
  require Logger
  use GenServer

  # Client
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  def close() do
    GenServer.cast(__MODULE__, {:close})
  end

  def visualize() do
    GenServer.call(__MODULE__, {:visualize}, :infinity)
  end

  # Server
  @impl true
  def init(_s) do
    {:ok,
     %{
       entries: [],
       open: true
     }}
  end

  @impl true
  def handle_cast({:push, item}, state) do
    r =
      if state.open do
        push_item(state, item)
      else
        state
      end

    {:noreply, r}
  end

  @impl true
  def handle_cast({:close}, state) do
    r = %{state | open: false}
    {:noreply, r}
  end

  @impl true
  def handle_call({:visualize}, _from, state) do
    Logger.debug("Visualized!")

    state.entries
    # adding to the front is fastest, so just reverse at the end!
    |> :lists.reverse()
    |> Enum.group_by(fn it -> it.op end, fn it -> it.item end)
    |> Enum.each(fn it ->
      Logger.debug(inspect(it))
    end)

    # Ratatouille.run(AdventOfCode.Shared.Visualizer.View)
    {:reply, :ok, state}
  end

  defp push_item(state, item) do
    {_, res} =
      Map.get_and_update(state, :entries, fn val ->
        {val, [item | val]}
      end)

    res
  end
end

defmodule AdventOfCode.Shared.Visualizer.View do
  @behaviour Ratatouille.App
  import Ratatouille.View

  def init(_context), do: 0

  def update(model, msg) do
    case msg do
      {:event, %{ch: ?+}} -> model + 1
      {:event, %{ch: ?-}} -> model - 1
      _ -> model
    end
  end

  def render(model) do
    view do
      label(content: "Counter is #{model} (+/-)")
    end
  end
end
