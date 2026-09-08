# Bisection Method — Quick Reviewer

> No board photos in this folder. Built from the standard method and your `ps2.png`.

## The idea

Guess a number between 1 and 100. Someone says "too high" or "too low". You
always guess the middle. Every guess cuts the range in half.

Bisection is that game. The "too high / too low" answer is the **sign** of `f(x)`.

## The one rule that starts it

Pick `[a, b]` where `f(a)` and `f(b)` have **opposite signs**:

```
f(a) · f(b) < 0
```

One is `+`, one is `−`. A continuous curve going from below zero to above zero
**must** cross zero somewhere between. That crossing is your root.

If both signs are the same → say **"no roots in the given interval"**.

```
 f(a) = −        root is in here        f(b) = +
   ●─────────────────✕──────────────────●
   a                 r                  b
```

## The loop

```
c = (a + b) / 2          ← midpoint, your current answer

if f(a)·f(c) < 0   →  root is on the LEFT half   →  b = c
else               →  root is on the RIGHT half  →  a = c

repeat
```

The interval shrinks by half every pass. That is it.

## Worked example (the `ps2.png` one)

`f(x) = x³ + x − 1`, interval `[0, 1]`, 9 iterations.

Sign check first: `f(0) = −1`, `f(1) = +1`. Opposite. Good.

| iter | a | b | c = mid | f(c) | keep |
|---|---|---|---|---|---|
| 1 | 0.000000 | 1.000000 | 0.500000 | −0.375000 | right |
| 2 | 0.500000 | 1.000000 | 0.750000 | +0.171875 | left |
| 3 | 0.500000 | 0.750000 | 0.625000 | −0.130859 | right |
| 4 | 0.625000 | 0.750000 | 0.687500 | +0.012451 | left |
| 5 | 0.625000 | 0.687500 | 0.656250 | −0.061127 | right |
| 6 | 0.656250 | 0.687500 | 0.671875 | −0.024830 | right |
| 7 | 0.671875 | 0.687500 | 0.679688 | −0.006314 | right |
| 8 | 0.679688 | 0.687500 | 0.683594 | +0.003037 | left |
| 9 | 0.679688 | 0.683594 | 0.681641 | −0.001646 | right |

Answer: `c = (0.681641 + 0.683594)/2 = 0.6826`.

Shrinking interval, drawn:

```
0 ├──────────────────────────────┤ 1
0.5 ├─────────────┤ 1
0.5 ├──────┤ 0.75
0.625 ├───┤ 0.75
0.625 ├─┤ 0.6875
      ...  →  0.6826
```

## Error bound (the one formula to memorize)

After `n` iterations:

```
error ≤ (b − a) / 2ⁿ
```

Starting width `1`, after 9 steps: `1/512 = 0.00195`. So `0.6826 ± 0.002`.

Want a set accuracy? Solve for `n`. To get `0.0001` on `[0, 1]`:
`1/2ⁿ ≤ 0.0001` → `2ⁿ ≥ 10000` → `n = 14`.

**You can say the error before you start.** Fixed-point iteration cannot do that.

## Bisection vs. Fixed-Point

| | Bisection | Fixed-Point |
|---|---|---|
| Always works? | Yes, if signs are opposite | No, depends on `g` |
| Speed | Slow, steady (halves each step) | Can be very fast or diverge |
| Error known ahead? | Yes | No |

Bisection is the safe one. Slow but it never fails.

## Common mistakes

1. Not checking `f(a)·f(b) < 0` first.
2. Using degrees instead of radians for trig functions.
3. Comparing `f(c)` to `f(b)` instead of `f(a)`. Pick one side and stay with it.
4. Forgetting the answer is the **last midpoint**, not `a` or `b`.
