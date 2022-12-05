defmodule Day3 do
  def build_priorities do
    map1 =
      ?a..?z
      # |> Enum.map(fn x -> <<x::utf8>> end)
      |> Enum.with_index(1)
      |> Enum.into(%{})

    map2 =
      ?A..?Z
      # |> Enum.map(fn x -> <<x::utf8>> end)
      |> Enum.with_index(27)
      |> Enum.into(%{})

    Map.merge(map1, map2)
  end

  def identify_item(compartments) do
    [first, second | _] = compartments
    first_unique = MapSet.new(first)
    second_unique = MapSet.new(second)
    MapSet.intersection(first_unique, second_unique) |> Enum.at(0)
  end

  def prioritize_rucksack(rucksack, priority_map) do
    chunk_size = trunc(String.length(rucksack) / 2)

    common_item =
      rucksack
      |> String.to_charlist()
      |> Enum.chunk_every(chunk_size)
      |> Day3.identify_item()

    Map.get(priority_map, common_item)
  end
end

priority_map = Day3.build_priorities()

result =
  File.stream!("day_3.txt")
  |> Stream.map(&String.trim/1)
  |> Stream.map(fn x -> Day3.prioritize_rucksack(x, priority_map) end)
  |> Enum.to_list()
  |> Enum.sum()

IO.puts("Part 1: #{result}")

defmodule Part2 do
  def identify_common_item(three_elf_group) do
    [first, second, third | _] = three_elf_group

    first_unique = MapSet.new(first)
    second_unique = MapSet.new(second)
    third_unique = MapSet.new(third)

    MapSet.intersection(first_unique, second_unique)
    |> MapSet.intersection(third_unique)
    |> Enum.at(0)
  end

  def prioritize_elf_group(elf_group, priority_map) do
    common_item = Part2.identify_common_item(elf_group)
    Map.get(priority_map, common_item)
  end
end

# Part 2
part2 =
  File.stream!("day_3.txt")
  |> Stream.map(&String.trim/1)
  |> Enum.to_list()
  |> Enum.map(&String.to_charlist/1)
  |> Enum.chunk_every(3)
  |> Enum.map(fn x -> Part2.prioritize_elf_group(x, priority_map) end)
  |> Enum.sum()

IO.puts("Part2: #{part2}")
