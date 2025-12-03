import day3
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

const day3_input = "987654321111111
811111111111119
234234234234278
818181911112111
"

pub fn day3_part1_test() {
  assert day3.part1(day3_input) == 357
}

pub fn day3_part2_test() {
  assert day3.part2(day3_input) == 3_121_910_778_619
}
