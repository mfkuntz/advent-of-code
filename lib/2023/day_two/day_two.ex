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
    {test_case, _} = get_example_1()

    answer = 2286
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
      |> Enum.filter(fn {_, items} ->
        Enum.any?(items, fn item ->
          Map.get(item, "red", 0) > @p1_red_max ||
            Map.get(item, "green", 0) > @p1_green_max ||
            Map.get(item, "blue", 0) > @p1_blue_max
        end) == false
      end)
      |> Enum.map(fn {it, _} -> it end)

    Enum.sum(d2)
  end

  @p2_empty %{"blue" => 0, "green" => 0, "red" => 0}

  @impl true
  def part_2(input, _p1) do
    d = parse_input(input)

    d2 =
      d
      |> Enum.map(fn {_, it} -> it end)
      |> Enum.map(fn inner ->
        Enum.reduce(inner, @p2_empty, fn it, acc ->
          blue = Map.get(acc, "blue")
          green = Map.get(acc, "green")
          red = Map.get(acc, "red")

          blue2 = Map.get(it, "blue", 0)
          green2 = Map.get(it, "green", 0)
          red2 = Map.get(it, "red", 0)

          # i wonder if get_and_update is faster? syntax is more annoying
          acc
          |> Map.put("blue", max(blue, blue2))
          |> Map.put("green", max(green, green2))
          |> Map.put("red", max(red, red2))
        end)
      end)
      |> Enum.map(fn %{"blue" => b, "green" => g, "red" => r} ->
        b * g * r
      end)

    Enum.sum(d2)
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
        |> List.last()
        |> String.split(";")
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
