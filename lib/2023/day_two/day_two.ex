defmodule AdventOfCode.TwentyTwentyThree.Day2 do
  require Logger
  use AdventOfCode.Shared.Day

  @impl true
  def get_example_1() do
    test_case = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    answer = 8
    {test_case, answer}
  end

  @impl true
  def get_example_2() do
    test_case = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    answer = 281
    {test_case, answer}
  end

  @p1_red_max 12
  @p1_green_max 13
  @p1_blue_max 14

  @impl true
  def part_1(input) do
    d = parse_input(input)
    # Logger.debug(inspect(d))

    d2 =
      d
      |> Enum.filter(fn {id, items} ->
        Enum.any?(items, fn item ->
          Map.get(item, "red", 0) > @p1_red_max ||
            Map.get(item, "green", 0) > @p1_green_max ||
            Map.get(item, "blue", 0) > @p1_blue_max
        end) == false
      end)
      |> Enum.map(fn {it, _} -> it end)

    Enum.sum(d2)
  end

  @impl true
  def part_2(_input, _p1) do
    :ok
  end

  @digits_regex ~r/(\d+)\s(\w+)/

  defp parse_input(input) do
    input
    |> Enum.map(fn line ->
      game_prefix =
        String.slice(line, 5..-1//1)
        |> String.split(": ")

      int_parse =
        game_prefix
        |> hd
        |> Integer.parse()

      id =
        case int_parse do
          {i, _} ->
            i

          _ ->
            Logger.debug(inspect(line))
            Logger.debug(inspect(game_prefix))
            0
        end

      parts =
        game_prefix
        |> :lists.reverse()
        |> hd()
        |> String.split(";")
        |> Enum.map(&String.trim/1)
        |> Enum.map(fn group ->
          String.split(group, ", ")
          |> Enum.reduce(%{}, fn item, acc ->
            [_, c, rem] = Regex.run(@digits_regex, item)
            {count, _} = Integer.parse(c)

            acc
            |> Map.put(String.trim(rem), count)
          end)
        end)

      {id, parts}
    end)
  end
end
