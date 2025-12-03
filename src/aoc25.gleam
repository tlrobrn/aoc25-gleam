import day3
import gleam/int
import gleam/io
import gleam/result
import simplifile

pub fn main() -> Nil {
  let _ =
    simplifile.read("input/day3.txt")
    |> result.map(fn(content) { day3.part1(content) })
    |> result.map(fn(result) { int.to_string(result) })
    |> result.map(fn(result) { io.println(result) })

  io.println("Done")
}
