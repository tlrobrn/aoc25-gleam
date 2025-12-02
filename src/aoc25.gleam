import day2
import gleam/int
import gleam/io
import gleam/result
import simplifile

pub fn main() -> Nil {
  let _ =
    simplifile.read("input/day2.txt")
    |> result.map(fn(content) { day2.part1(content) })
    |> result.map(fn(result) { int.to_string(result) })
    |> result.map(fn(result) { io.println(result) })

  io.println("Done")
}
