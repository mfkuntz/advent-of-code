defmodule AdventOfCode.Shared.Utils do
  # thank you generative AI

  def digit_to_name(digit) do
    case digit do
      0 -> "zero"
      1 -> "one"
      2 -> "two"
      3 -> "three"
      4 -> "four"
      5 -> "five"
      6 -> "six"
      7 -> "seven"
      8 -> "eight"
      9 -> "nine"
      10 -> "ten"
      11 -> "eleven"
      12 -> "twelve"
      13 -> "thirteen"
      14 -> "fourteen"
      15 -> "fifteen"
      16 -> "sixteen"
      17 -> "seventeen"
      18 -> "eighteen"
      19 -> "nineteen"
      20 -> "twenty"
      21 -> "twenty-one"
      22 -> "twenty-two"
      23 -> "twenty-three"
      24 -> "twenty-four"
      25 -> "twenty-five"
      26 -> "twenty-six"
      27 -> "twenty-seven"
      28 -> "twenty-eight"
      29 -> "twenty-nine"
      30 -> "thirty"
      31 -> "thirty-one"
      _ -> Integer.to_string(digit)
    end
  end

  def name_to_digit(name) do
    case name do
      "zero" -> 0
      "one" -> 1
      "two" -> 2
      "three" -> 3
      "four" -> 4
      "five" -> 5
      "six" -> 6
      "seven" -> 7
      "eight" -> 8
      "nine" -> 9
      "ten" -> 10
      "eleven" -> 11
      "twelve" -> 12
      "thirteen" -> 13
      "fourteen" -> 14
      "fifteen" -> 15
      "sixteen" -> 16
      "seventeen" -> 17
      "eighteen" -> 18
      "nineteen" -> 19
      "twenty" -> 20
      "twenty-one" -> 21
      "twenty-two" -> 22
      "twenty-three" -> 23
      "twenty-four" -> 24
      "twenty-five" -> 25
      "twenty-six" -> 26
      "twenty-seven" -> 27
      "twenty-eight" -> 28
      "twenty-nine" -> 29
      "thirty" -> 30
      "thirty-one" -> 31
      _ -> name
    end
  end
end
