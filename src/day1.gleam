import gleam/int
import gleam/list
import gleam/result
import gleam/string

type State {
  State(position: Int, zero_count: Int)
}

pub fn part1(input: String) -> Int {
  let lines = string.split(input, "\n")
  let initial_state = State(position: 50, zero_count: 0)

  list.fold(lines, initial_state, fn(state, line) {
    let adjustment = parse_line(line)

    case adjustment {
      Ok(n) -> {
        let new_position = wrap(state.position + n)
        let new_zero_count = case new_position {
          0 -> state.zero_count + 1
          _ -> state.zero_count
        }
        State(position: new_position, zero_count: new_zero_count)
      }
      Error(Nil) -> state
    }
  }).zero_count
}

fn parse_line(line: String) -> Result(Int, Nil) {
  case line {
    "L" <> n -> int.parse(n) |> result.map(fn(n) { -n })
    "R" <> n -> int.parse(n)
    _ -> Error(Nil)
  }
}

fn wrap(n: Int) -> Int {
  case n {
    x if x < 0 -> wrap(100 + x)
    x if x > 99 -> wrap(x - 100)
    x -> x
  }
}
