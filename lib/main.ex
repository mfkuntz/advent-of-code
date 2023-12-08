defmodule Mix.Tasks.DayRunner do
  require Logger

  use Mix.Task

  alias AdventOfCode.Shared.Utils

  @moduledoc """
  CLI EXS entrypoint
  """

  @impl Mix.Task
  def run(_) do
    [_mod, day] = System.argv()
    Logger.info("Running code for Day " <> day)
    load_module(day)
  end

  defp load_module(day) do
    human_day = Utils.digit_to_name(String.to_integer(day))
    folder = "./lib/2023/day_" <> human_day

    {:ok, _} = AdventOfCode.Shared.Visualizer.start_link(%{})
    # Logger.debug(inspect(r))

    apply(String.to_existing_atom("Elixir.AdventOfCode.TwentyTwentyThree.Day" <> day), :call, [
      folder
    ])
  end
end

# AdventOfCode.CLI.call()
