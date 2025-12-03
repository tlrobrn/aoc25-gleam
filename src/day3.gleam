import gleam/int
import gleam/list
import gleam/string

pub fn part1(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.map(string.to_graphemes)
  |> list.map(list.filter_map(_, int.parse))
  |> list.map(highest_two(_, #(0, 0)))
  |> list.fold(0, fn(acc, n) { acc + n })
}

fn highest_two(ls: List(Int), digits: #(Int, Int)) -> Int {
  let #(tens, ones) = digits
  case ls {
    [] -> tens * 10 + ones
    [n] if n > ones -> tens * 10 + n
    [_] -> tens * 10 + ones
    [n, ..rest] if n > tens -> highest_two(rest, #(n, 0))
    [n, ..rest] if n > ones -> highest_two(rest, #(tens, n))
    [_, ..rest] -> highest_two(rest, digits)
  }
}
