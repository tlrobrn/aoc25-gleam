import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn part1(input: String) -> Int {
  string.split(input, ",")
  |> list.map(parse_range)
  |> list.map(fn(r) { result.unwrap(r, #(0, 0)) })
  |> list.flat_map(expand_range)
  |> list.filter(invalid_id)
  |> list.filter_map(fn(id) { int.parse(id) })
  |> list.fold(0, fn(acc, id) { acc + id })
}

fn parse_range(range: String) -> Result(#(Int, Int), Nil) {
  let bounds =
    string.split(range, "-")
    |> list.map(fn(n) { int.parse(n) })

  case bounds {
    [Ok(start), Ok(end)] -> Ok(#(start, end))
    _ -> Error(Nil)
  }
}

fn expand_range(range: #(Int, Int)) -> List(String) {
  let #(start, end) = range
  list.range(start, end)
  |> list.map(int.to_string)
  |> list.filter(fn(s) { { string.length(s) } % 2 == 0 })
}

fn invalid_id(id: String) -> Bool {
  let length = string.length(id)
  let beginning = string.slice(id, 0, length / 2)
  let end = string.slice(id, length / 2, length)
  beginning == end
}
