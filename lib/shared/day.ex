defmodule AdventOfCode.Shared.Day do
  require Logger
  @callback get_example_1() :: {String.t(), any()}
  @callback get_example_2() :: {String.t(), any()}

  @callback part_1(String.t()) :: any()
  @callback part_2(String.t(), any()) :: any()

  defmacro __using__(_args) do
    quote do
      @behaviour AdventOfCode.Shared.Day

      require Logger

      def call(cwd) do
        Logger.info("running example 1: ")
        {test_case, answer} = get_example_1()
        e1 = part_1(load_example_data(test_case))
        Logger.info(inspect(e1))

        if e1 != answer do
          Logger.error("expected: " <> inspect(answer) <> "; got: " <> inspect(e1))
          exit(:shutdown)
        end

        Logger.info("running part 1: ")
        p1 = part_1(load_data(cwd, "part_one.txt"))
        Logger.info(inspect(p1))

        Logger.info("running example 2: ")
        {test_case, answer} = get_example_2()
        e2 = part_2(load_example_data(test_case), e1)
        Logger.info(inspect(e2))

        if e2 != answer do
          Logger.error("expected: " <> inspect(answer) <> "; got: " <> inspect(e2))
          exit(:shutdown)
        end

        Logger.info("running part 2: ")
        p2 = part_2(load_data(cwd, "part_one.txt"), p1)
        Logger.info(inspect(p2))
      end

      defp load_example_data(test_case) do
        test_case
        |> parse_text()
        # drop the newline from the start and end.
        # weird little trick but its fast
        |> :lists.reverse()
        |> tl()
        |> :lists.reverse()
      end

      defp load_data(cwd, name) do
        d =
          case File.read(Path.join(cwd, name)) do
            {:ok, d} ->
              d

            {:error, reason} ->
              Logger.error("error reading input file: " <> to_string(:file.format_error(reason)))
              raise to_string(reason)
          end

        parse_text(d)
      end

      defp parse_text(t) do
        String.split(t, "\n")
      end
    end
  end
end
