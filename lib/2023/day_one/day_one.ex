defmodule AdventOfCode.TwentyTwentyThree.Day1 do
  require Logger
  use AdventOfCode.Shared.Day

  alias AdventOfCode.Shared.Utils

  @impl true
  def get_example_1() do
    test_case = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    answer = 142
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

  @impl true
  def part_1(input) do
    parts = run_day(input, &String.codepoints/1)
    Enum.sum(parts)
  end

  @impl true
  def part_2(input, _p1) do
    parts = run_day(input, &part2_parser/1)
    Enum.sum(parts)
  end

  @digits_regex ~r/(?=(\d))|(?=(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine))/

  defp convert_digit(digit) when is_binary(digit) do
    Utils.name_to_digit(digit)
    |> to_string()
  end

  def part2_parser(s) do
    s =
      Regex.scan(@digits_regex, s)
      |> Enum.flat_map(fn it ->
        Enum.filter(it, fn inner -> inner != "" end)
      end)
      |> Enum.map(&convert_digit/1)

    [hd(s), List.last(s)]
  end

  defp run_day(input, parser1) do
    i =
      input
      |> Enum.map(fn line -> parser1.(line) end)
      |> Enum.map(&log_item(:parser_1, &1))
      |> Enum.map(fn it ->
        mapped =
          it
          |> Enum.map(&Integer.parse/1)
          |> Enum.filter(fn inner ->
            inner != :error
          end)
          |> Enum.map(fn inner ->
            {item, _} = inner
            item
          end)
          |> Enum.map(&log_item(:int_parsed, &1))

        c =
          case length(mapped) do
            0 ->
              0

            1 ->
              h = hd(mapped)
              concat_ints(h, h)

            _ ->
              h = hd(mapped)
              t = List.last(mapped)
              concat_ints(h, t)
          end

        log_item(:concat_ints, c)
        c
      end)

    i
  end

  defp concat_ints(h, t) do
    st = Integer.to_string(h) <> Integer.to_string(t)
    {int, _} = Integer.parse(st)
    int
  end
end
