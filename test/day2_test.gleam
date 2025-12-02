import day2
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

const day2_input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

pub fn day2_part1_test() {
  assert day2.part1(day2_input) == 1_227_775_554
}

pub fn day2_part2_test() {
  assert day2.part2(day2_input) == 4_174_379_265
}

pub fn day2_part2_small_test() {
  assert day2.part2("12121212121212-12121212121212") == 12_121_212_121_212
}
