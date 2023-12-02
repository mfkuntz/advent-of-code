defmodule AdventOfCode.TwentyTwentyThree.Day1 do
  require Logger
  use AdventOfCode.Shared.Day

  @impl true
  def get_example() do
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
  def example_1(input) do
    parts = do_part_1(input)
    Enum.sum(parts)
  end

  @impl true
  def part_1(input) do
    parts = do_part_1(input)
    Enum.sum(parts)
  end

  defp do_part_1(input) do
    i =
      input
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(fn it ->
        mapped =
          it
          |> Enum.map(&Integer.parse/1)
          |> Enum.filter(fn inner ->
            inner != :error
          end)
          |> Enum.map(fn inner ->
            # Logger.debug(inspect(inner))
            {item, _} = inner
            item
          end)

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
      end)

    i
  end

  defp concat_ints(h, t) do
    st = Integer.to_string(h) <> Integer.to_string(t)
    {int, _} = Integer.parse(st)
    int
  end

  @impl true
  def part_2(_input, _p1) do
    :ok
  end
end
