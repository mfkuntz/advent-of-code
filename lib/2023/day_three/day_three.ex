defmodule AdventOfCode.TwentyTwentyThree.Day3 do
  require Logger
  use AdventOfCode.Shared.Day

  @impl true
  def get_example_1() do
    test_case = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    answer = 4361
    {test_case, answer}
  end

  @impl true
  def get_example_2() do
    {test_case, _} = get_example_1()

    answer = 467_835
    {test_case, answer}
  end

  @impl true
  def part_1(input) do
    d = parse_input(input)

    d2 =
      d
      |> Enum.filter(fn it -> it.int != nil end)
      |> Enum.filter(fn it ->
        n = find_neighbors(d, it)
        length(n) != 0
      end)
      |> Enum.map(fn it -> it.int end)

    Enum.sum(d2)
  end

  @impl true
  def part_2(input, _p1) do
    d = parse_input(input)

    d2 =
      d
      |> Enum.filter(fn it -> it.string == "*" end)
      |> Enum.map(fn it ->
        n = find_neighbors_2(d, it)

        case n do
          [%{int: a}, %{int: b}] -> a * b
          _ -> 0
        end
      end)

    Enum.sum(d2)
  end

  defp parse_input(input) do
    input
    |> Enum.with_index(fn line, line_index ->
      parse_line(line, line_index)
    end)
    |> List.flatten()
  end

  def parse_line(line, line_index) do
    parse_line(line, line_index, ~r/\d+/) ++
      parse_line(line, line_index, ~r/[^\d\.]/)
  end

  def parse_line(line, line_index, regexp) do
    matches_str = Regex.scan(regexp, line)
    positions = Regex.scan(regexp, line, return: :index)

    Enum.zip(matches_str, positions)
    |> Enum.map(fn {string_l, position_l} ->
      text = hd(string_l)
      position = hd(position_l)

      int_value =
        case Integer.parse(text) do
          {i, _} -> i
          _ -> nil
        end

      x = elem(position, 0)
      length = elem(position, 1)
      ends_at = x + length - 1

      %{
        string: text,
        coords: {x, line_index},
        int: int_value,
        length: length,
        positions: Enum.map(x..ends_at, fn pos -> {pos, line_index} end)
      }
    end)
  end

  defp find_neighbors(all_items, item) do
    n_coords =
      item.positions
      |> Enum.flat_map(&generate_neighbor_coords/1)

    find(all_items, item, n_coords)
  end

  defp find_neighbors_2(all_items, item) do
    n_coords = generate_neighbor_coords(item.coords)

    find_2(all_items, n_coords)
  end

  defp generate_neighbor_coords({x, y}) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1}
    ]
  end

  # these are slow, show try parsing into a Map or something :)

  defp find(all_items, check_item, neighbor_coords) do
    Enum.filter(all_items, fn item ->
      Enum.any?(neighbor_coords, fn n_coords ->
        item.coords == n_coords && check_item.int != item.int
      end)
    end)
  end

  defp find_2(all_items, neighbor_coords) do
    Enum.filter(all_items, fn item ->
      Enum.any?(neighbor_coords, fn n_coords ->
        item.positions
        |> Enum.any?(fn item_pos ->
          item_pos == n_coords
        end)
      end)
    end)
  end
end
