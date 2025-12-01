import day1
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

const day1_input = "
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"

pub fn day1_part1_test() {
  assert day1.part1(day1_input) == 3
}
