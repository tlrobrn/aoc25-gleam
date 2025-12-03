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

pub fn part2(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.map(string.to_graphemes)
  |> list.map(list.filter_map(_, int.parse))
  |> list.map(highest_twelve(_, #(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
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

fn highest_twelve(
  ls: List(Int),
  digits: #(Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int),
) -> Int {
  let #(
    hundred_billions,
    ten_billions,
    billions,
    hundred_millions,
    ten_millions,
    millions,
    hundred_thousands,
    ten_thousands,
    thousands,
    hundreds,
    tens,
    ones,
  ) = digits
  case ls {
    [] -> twelve_digits_to_number(digits)
    [n] if n > ones ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_] -> twelve_digits_to_number(digits)
    [n, m] if n > tens ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        m,
      ))
    [n, m] if n > ones ->
      highest_twelve([m], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m] -> highest_twelve([m], digits)
    [n, m, o] if n > hundreds ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        m,
        o,
      ))
    [n, m, o] if n > tens ->
      highest_twelve([m, o], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o] if n > ones ->
      highest_twelve([m, o], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o] -> highest_twelve([m, o], digits)
    [n, m, o, p] if n > thousands ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        m,
        o,
        p,
      ))
    [n, m, o, p] if n > hundreds ->
      highest_twelve([m, o, p], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p] if n > tens ->
      highest_twelve([m, o, p], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p] if n > ones ->
      highest_twelve([m, o, p], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p] -> highest_twelve([m, o, p], digits)
    [n, m, o, p, q] if n > ten_thousands ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        m,
        o,
        p,
        q,
      ))
    [n, m, o, p, q] if n > thousands ->
      highest_twelve([m, o, p, q], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q] if n > hundreds ->
      highest_twelve([m, o, p, q], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q] if n > tens ->
      highest_twelve([m, o, p, q], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q] if n > ones ->
      highest_twelve([m, o, p, q], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q] -> highest_twelve([m, o, p, q], digits)
    [n, m, o, p, q, r] if n > hundred_thousands ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        m,
        o,
        p,
        q,
        r,
      ))
    [n, m, o, p, q, r] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r] if n > thousands ->
      highest_twelve([m, o, p, q, r], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r] if n > hundreds ->
      highest_twelve([m, o, p, q, r], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r] if n > tens ->
      highest_twelve([m, o, p, q, r], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r] if n > ones ->
      highest_twelve([m, o, p, q, r], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r] -> highest_twelve([m, o, p, q, r], digits)
    [n, m, o, p, q, r, s] if n > millions ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        m,
        o,
        p,
        q,
        r,
        s,
      ))
    [n, m, o, p, q, r, s] if n > hundred_thousands ->
      highest_twelve([m, o, p, q, r, s], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r, s], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s] if n > thousands ->
      highest_twelve([m, o, p, q, r, s], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s] if n > hundreds ->
      highest_twelve([m, o, p, q, r, s], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r, s] if n > tens ->
      highest_twelve([m, o, p, q, r, s], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r, s] if n > ones ->
      highest_twelve([m, o, p, q, r, s], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r, s] -> highest_twelve([m, o, p, q, r, s], digits)
    [n, m, o, p, q, r, s, t] if n > ten_millions ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        n,
        m,
        o,
        p,
        q,
        r,
        s,
        t,
      ))
    [n, m, o, p, q, r, s, t] if n > millions ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t] if n > hundred_thousands ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t] if n > thousands ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t] if n > hundreds ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t] if n > tens ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r, s, t] if n > ones ->
      highest_twelve([m, o, p, q, r, s, t], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r, s, t] -> highest_twelve([m, o, p, q, r, s, t], digits)
    [n, m, o, p, q, r, s, t, u] if n > hundred_millions ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        billions,
        n,
        m,
        o,
        p,
        q,
        r,
        s,
        t,
        u,
      ))
    [n, m, o, p, q, r, s, t, u] if n > ten_millions ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > millions ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > hundred_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > thousands ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > hundreds ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > tens ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r, s, t, u] if n > ones ->
      highest_twelve([m, o, p, q, r, s, t, u], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r, s, t, u] ->
      highest_twelve([m, o, p, q, r, s, t, u], digits)
    [n, m, o, p, q, r, s, t, u, v] if n > billions ->
      twelve_digits_to_number(#(
        hundred_billions,
        ten_billions,
        n,
        m,
        o,
        p,
        q,
        r,
        s,
        t,
        u,
        v,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > hundred_millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > ten_millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > hundred_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > hundreds ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > tens ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v] if n > ones ->
      highest_twelve([m, o, p, q, r, s, t, u, v], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r, s, t, u, v] ->
      highest_twelve([m, o, p, q, r, s, t, u, v], digits)
    [n, m, o, p, q, r, s, t, u, v, w] if n > ten_billions ->
      twelve_digits_to_number(#(
        hundred_billions,
        n,
        m,
        o,
        p,
        q,
        r,
        s,
        t,
        u,
        v,
        w,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > billions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > hundred_millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > ten_millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > hundred_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > hundreds ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > tens ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w] if n > ones ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r, s, t, u, v, w] ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w], digits)
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > hundred_billions ->
      twelve_digits_to_number(#(n, m, o, p, q, r, s, t, u, v, w, x))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > ten_billions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > billions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > hundred_millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > ten_millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > millions ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > hundred_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > ten_thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > thousands ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > hundreds ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > tens ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, m, o, p, q, r, s, t, u, v, w, x] if n > ones ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, m, o, p, q, r, s, t, u, v, w, x] ->
      highest_twelve([m, o, p, q, r, s, t, u, v, w, x], digits)
    [n, ..rest] if n > hundred_billions ->
      highest_twelve(rest, #(n, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    [n, ..rest] if n > ten_billions ->
      highest_twelve(rest, #(hundred_billions, n, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    [n, ..rest] if n > billions ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > hundred_millions ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > ten_millions ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > millions ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        n,
        0,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > hundred_thousands ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        n,
        0,
        0,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > ten_thousands ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        n,
        0,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > thousands ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        n,
        0,
        0,
        0,
      ))
    [n, ..rest] if n > hundreds ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        n,
        0,
        0,
      ))
    [n, ..rest] if n > tens ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        n,
        0,
      ))
    [n, ..rest] if n > ones ->
      highest_twelve(rest, #(
        hundred_billions,
        ten_billions,
        billions,
        hundred_millions,
        ten_millions,
        millions,
        hundred_thousands,
        ten_thousands,
        thousands,
        hundreds,
        tens,
        n,
      ))
    [_, ..rest] -> highest_twelve(rest, digits)
  }
}

fn twelve_digits_to_number(
  digits: #(Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int),
) -> Int {
  let #(
    hundred_billions,
    ten_billions,
    billions,
    hundred_millions,
    ten_millions,
    millions,
    hundred_thousands,
    ten_thousands,
    thousands,
    hundreds,
    tens,
    ones,
  ) = digits
  100_000_000_000
  * hundred_billions
  + 10_000_000_000
  * ten_billions
  + 1_000_000_000
  * billions
  + 100_000_000
  * hundred_millions
  + 10_000_000
  * ten_millions
  + 1_000_000
  * millions
  + 100_000
  * hundred_thousands
  + 10_000
  * ten_thousands
  + 1000
  * thousands
  + 100
  * hundreds
  + 10
  * tens
  + ones
}
