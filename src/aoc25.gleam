import day1
import gleam/int
import gleam/io
import gleam/result
import simplifile

pub fn main() -> Nil {
  let _ =
    simplifile.read("input/day1.txt")
    |> result.map(fn(content) { day1.part2(content) })
    |> result.map(fn(result) { int.to_string(result) })
    |> result.map(fn(result) { io.println(result) })

  io.println("Done")
}
