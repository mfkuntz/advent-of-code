defmodule Mix.Tasks.DayRunner do
  require Logger

  use Mix.Task

  @moduledoc """
  CLI EXS entrypoint
  """

  def run(_) do
    [_mod, day] = System.argv()
    Logger.info("Running code for Day " <> day)
    load_module(day)
  end

  defp load_module(day) do
    human_day = say_io(String.to_integer(day))
    folder = "./lib/2023/day_" <> human_day

    apply(String.to_existing_atom("Elixir.AdventOfCode.TwentyTwentyThree.Day" <> day), :call, [
      folder
    ])
  end

  @spec say_io(integer) :: iodata
  def say_io(1), do: "one"
  def say_io(2), do: "two"
  def say_io(3), do: "three"
  def say_io(4), do: "four"
  def say_io(5), do: "five"
  def say_io(6), do: "six"
  def say_io(7), do: "seven"
  def say_io(8), do: "eight"
  def say_io(9), do: "nine"
  def say_io(10), do: "ten"
  def say_io(11), do: "eleven"
  def say_io(12), do: "twelve"
  def say_io(13), do: "thirteen"
  def say_io(14), do: "fourteen"
  def say_io(15), do: "fifteen"
  def say_io(16), do: "sixteen"
  def say_io(17), do: "seventeen"
  def say_io(18), do: "eighteen"
  def say_io(19), do: "nineteen"
  def say_io(20), do: "twenty"
  def say_io(n), do: Integer.to_string(n)
end

# AdventOfCode.CLI.call()
