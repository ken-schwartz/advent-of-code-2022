defmodule Day1 do
  def sum_calorie_strings(list) do
    list
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end

{:ok, all_elfs_snacks} = File.read("day_1_part_1.txt")

sorted_total_calories =
  all_elfs_snacks
  |> String.split("\n\n")
  |> Enum.map(&String.split/1)
  |> Enum.map(&Day1.sum_calorie_strings/1)
  |> Enum.sort(&(&1 >= &2))

# part one
[head | _] = sorted_total_calories
IO.puts("Part 1: #{head}")

# part two
top_three_calories =
  sorted_total_calories
  |> Enum.take(3)
  |> Enum.sum()

IO.puts("Part 2: #{top_three_calories}")
