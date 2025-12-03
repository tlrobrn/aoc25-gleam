import gleam/int
import gleam/list
import gleam/regexp
import gleam/string

pub fn part1(input: String) -> Int {
  process_input(input: input, pattern: "^([0-9]+)\\1$")
}

pub fn part2(input: String) -> Int {
  process_input(input: input, pattern: "^([0-9]+)\\1+$")
}

fn process_input(input input: String, pattern pattern: String) -> Int {
  let assert Ok(regex) = regexp.from_string(pattern)

  string.split(input, ",")
  |> list.map(string.trim)
  |> list.filter_map(parse_range)
  |> list.flat_map(expand_range)
  |> list.filter(regexp.check(regex, _))
  |> list.filter_map(int.parse)
  |> list.fold(0, fn(acc, id) { acc + id })
}

fn parse_range(range: String) -> Result(#(Int, Int), Nil) {
  let bounds = string.split(range, "-") |> list.map(int.parse)

  case bounds {
    [Ok(start), Ok(end)] -> Ok(#(start, end))
    _ -> Error(Nil)
  }
}

fn expand_range(range: #(Int, Int)) -> List(String) {
  let #(start, end) = range
  list.range(start, end) |> list.map(int.to_string)
}
