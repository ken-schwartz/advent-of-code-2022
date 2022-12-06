defmodule Day4 do
  def part1 do
    read_file()
    |> Enum.map(&get_section_ranges/1)
    |> Enum.filter(&contains_range?/1)
    |> Enum.count()
  end

  def part2 do
    read_file()
    |> Enum.map(&get_section_ranges/1)
    |> Enum.filter(&ranges_overlap?/1)
    |> Enum.count()
  end

  defp read_file do
    {:ok, file} = File.read("day_4.txt")

    file
    |> String.split("\n", trim: true)
  end

  defp get_section_ranges(elf_pair) do
    elf_pair
    |> String.split(",")
    |> Enum.flat_map(&String.split(&1, "-"))
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp contains_range?(section_ranges) do
    {elf1_start, elf1_end, elf2_start, elf2_end} = section_ranges

    (elf1_start >= elf2_start && elf1_end <= elf2_end) ||
      (elf2_start >= elf1_start && elf2_end <= elf1_end)
  end

  defp ranges_overlap?(section_ranges) do
    {elf1_start, elf1_end, elf2_start, elf2_end} = section_ranges
    !Range.disjoint?(elf1_start..elf1_end, elf2_start..elf2_end)
  end
end

IO.puts("Part 1: #{Day4.part1()}")
IO.puts("Part 1: #{Day4.part2()}")
