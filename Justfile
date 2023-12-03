setup-tools:
    mix deps.get
    mix dialyzer --plt

format:
    mix format

type-check:
    mix dialyzer

run-old DAY: format
    elixir ./lib/main.exs {{DAY}}

run DAY: format
    mix DayRunner {{DAY}}

run-debug DAY: format type-check (run DAY)
