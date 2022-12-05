defmodule Day2 do
  def score_shape(shape) do
    case shape do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end

  def score_result(their_shape, my_shape) do
    case {their_shape, my_shape} do
      {"A", "X"} -> 3
      {"A", "Y"} -> 6
      {"A", "Z"} -> 0
      {"B", "X"} -> 0
      {"B", "Y"} -> 3
      {"B", "Z"} -> 6
      {"C", "X"} -> 6
      {"C", "Y"} -> 0
      {"C", "Z"} -> 3
    end
  end

  def score_round(round) do
    [their_shape, my_shape | _] = String.split(round)
    score_shape(my_shape) + score_result(their_shape, my_shape)
  end
end

total_score =
  File.stream!("day_2.txt")
  |> Stream.map(&Day2.score_round/1)
  |> Enum.to_list()
  |> Enum.sum()

IO.puts("Part 1: #{total_score}")

defmodule Part2 do
  def score_shape(shape) do
    case shape do
      "A" -> 1
      "B" -> 2
      "C" -> 3
    end
  end

  def score_result(their_shape, my_shape) do
    case {their_shape, my_shape} do
      {"A", "A"} -> 3
      {"A", "B"} -> 6
      {"A", "C"} -> 0
      {"B", "A"} -> 0
      {"B", "B"} -> 3
      {"B", "C"} -> 6
      {"C", "A"} -> 6
      {"C", "B"} -> 0
      {"C", "C"} -> 3
    end
  end

  def determine_move(their_shape, instruction) do
    case {their_shape, instruction} do
      {"A", "X"} -> "C"
      {"A", "Y"} -> "A"
      {"A", "Z"} -> "B"
      {"B", "X"} -> "A"
      {"B", "Y"} -> "B"
      {"B", "Z"} -> "C"
      {"C", "X"} -> "B"
      {"C", "Y"} -> "C"
      {"C", "Z"} -> "A"
    end
  end

  def score_round(round) do
    [their_shape, instruction | _] = String.split(round)
    my_shape = determine_move(their_shape, instruction)
    score_shape(my_shape) + score_result(their_shape, my_shape)
  end
end

total_score_2 =
  File.stream!("day_2.txt")
  |> Stream.map(&Part2.score_round/1)
  |> Enum.to_list()
  |> Enum.sum()

IO.puts("Part 2: #{total_score_2}")
