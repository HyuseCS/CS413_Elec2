# Fixed-Point Iteration — Study Guide

Built from the 8 board photos in this folder. All numbers here were re-computed
and match the board.

---

## 1. The definition (this is the whole topic)

> The real number `r` is a **fixed point** of the function `g` if `g(r) = r`.

A fixed point is an input that comes back out **unchanged**. Put it in, get it
back.

The method:

```
x₀ = your starting guess
x₁ = g(x₀)
x₂ = g(x₁)
x₃ = g(x₂)      ...      x_{k+1} = g(x_k)
```

Keep feeding the output back in. If the numbers settle down on one value, that
value is `r`, and `g(r) = r`.

---

## 2. Why this finds roots

You want to solve `f(x) = 0`. That is not a fixed-point problem yet. So you
**rearrange** it into the shape `x = g(x)`.

Board example: `x³ + x − 1 = 0`

```
x³ + x − 1 = 0
        x  = 1 − x³        →   g(x) = 1 − x³
```

Now any `x` with `g(x) = x` also satisfies `x³ + x − 1 = 0`. Same root, new
shape. Solve the easy shape by repeating.

**Key point: the rearrangement is not unique.** One equation gives many `g`.
Some work, some do not. That is the real lesson of this topic.

---

## 3. Example 1 — three `g` for the same equation

Equation: `x³ + x − 1 = 0`, start at `x₀ = 0.5`. The true root is `0.682327804`.

### g₁(x) = 1 − x³ — **DIVERGES**

```
iter   x
0      0.500000000
1      0.875000000      g(0.5)   = 1 − 0.5³   = 0.875
2      0.330078125      g(0.875) = 1 − 0.875³ = 0.330078125
3      0.964037471
4      0.104054188
5      0.998873377
6      0.003376063
7      0.999999962
8      0.000000115
9      1.000000000
10     0.000000000
```

It bounces harder and harder between `0` and `1`. It never lands on `0.6823`.
This is a **divergent** iteration. Correct algebra, useless `g`.

### g₂(x) = ∛(1 − x) — **CONVERGES, slowly**

Rearrange the other way:

```
x³ + x − 1 = 0
        x³ = 1 − x
        x  = ∛(1 − x)
```

```
iter   x
0      0.500000000
1      0.793700526      ∛(1 − 0.5) = ∛0.5
2      0.590880113
3      0.742363932
...
13     0.684549401
14     0.680737373
...
24     0.682271570
25     0.682376807      →  r ≈ 0.682
```

It works, but it needs **25 iterations**. It zig-zags in from both sides,
closing in a little each time.

### g₃(x) = (1 + 2x³)/(3x² + 1) — **CONVERGES, fast**

The board derives it like this:

```
x³ + x − 1 = 0
x³ + x = 1
add 2x³ to both sides:   2x³ + x³ + x = 1 + 2x³
                         3x³ + x      = 1 + 2x³
factor the left:         x(3x² + 1)   = 1 + 2x³
                         x = (1 + 2x³)/(3x² + 1)
```

**Why add `2x³`? Where did that come from?**

You need `x` alone on the left. Every term on the left has an `x` in it, so you
factor one out. Whatever is left inside the bracket becomes your denominator.

The plain way, with no adding at all:

```
x(x² + 1) = 1     →   g(x) = 1/(x² + 1)
```

That is legal and it works. But it is slow. So the board adds `x³` first to get
a different bracket.

**Adding `x³` is always legal.** Add it to both sides and the equation stays
true. Adding it twice looks like this:

```
x³ + x                    = 1
x³ + x³ + x³ + x          = 1 + x³ + x³
3x³ + x                   = 1 + 2x³
```

Two extra on the left, two extra on the right. Balanced.

**Do it with a letter instead of a number.** Let `a` be the final count of `x³`
on the left. You added `a − 1` copies:

```
a·x³ + x       = 1 + (a−1)x³
x(a·x² + 1)    = 1 + (a−1)x³
x              = (1 + (a−1)x³) / (a·x² + 1)
```

So the general fixed-point form is:

```
g(x) = (1 + (a−1)x³) / (a·x² + 1)
```

Every `a` gives a valid `g` with the same root. Put `a = 3` and you get the
board's `(1 + 2x³)/(3x² + 1)`. So `a` is a free knob, and now you can ask:
**which `a` is fastest?**

**Fastest means `g'` at the root is closest to zero.** `g'` is how much of the
error survives one step. `0.6` means 60% of the error is still there. `0` means
the error dies.

Work out `g'` at the root:

```
top     N = 1 + (a−1)x³      N' = 3(a−1)x²
bottom  D = a·x² + 1         D' = 2a·x

g' = (N'D − N D') / D²

at the root, g(r) = r, which means N = r·D. Swap it in:

g'(r) = (N' − r·D') / D
      = (3(a−1)r² − 2a·r²) / D
      = r²(a − 3) / D
```

```
g'(root) = r²(a − 3) / (a·r² + 1)
```

The `N = r·D` swap is the trick. It kills a whole term and leaves a clean
`a − 3`.

**Now read the formula.** `r²` is not zero. The bottom is always positive. So
the only way to get `g' = 0` is `a − 3 = 0`.

With `r = 0.682328` and `r² = 0.465571`:

| `a` | top: `r²(a−3)` | bottom: `a·r² + 1` | `g'` | speed |
|---|---|---|---|---|
| 1 | `−0.9311` | `1.4656` | **−0.635** | slow |
| 2 | `−0.4656` | `1.9311` | **−0.241** | ok |
| **3** | `0` | `2.3967` | **0** | **very fast** |
| 4 | `+0.4656` | `2.8623` | **+0.163** | slower again |

`a = 3` is the crossing point where the error flips from negative to positive.
At exactly that spot the error dies and your correct digits double each step.

**`a = 3` means you added `2x³`.** That is the whole reason for the `2`.

The `2x³` left over on the right side is just the price of adding it to the
left too. It cannot cancel, and that is fine, because `g` is allowed to
contain `x`.

Why 3 and not some other number: `3x² + 1` is exactly `f'(x)` for
`f(x) = x³ + x − 1`. Matching the denominator to the derivative is what forces
`g'(root) = 0`.

```
iter   x
0      0.500000000
1      0.714285714      = (1 + 2(0.5)³)/(3(0.5)² + 1)
2      0.683179724
3      0.682328423
4      0.682327804
5      0.682327804      →  converged at the 5th iteration
```

**Five iterations instead of twenty-five.** Same equation, same start, same
root. Only `g` changed.

> Side note: this `g₃` is exactly Newton's method for `f(x) = x³ + x − 1`. That
> is why it is so fast.

---

## 4. Example 2 — `cos x = sin x`

Trick: the equation has no `x` alone, so **add `x` to both sides** to make the
`x = g(x)` shape.

```
cos x = sin x
x + cos x = x + sin x
x + cos x − sin x = x

g(x) = x + cos x − sin x
```

Start at `x₀ = 1`:

```
iter   x
0      1
1      0.698831321      = 1 + cos(1) − sin(1)
2      0.821102477
3      0.770619680
...
18     0.785398000
19     0.785398000      →  r ≈ 0.785398
```

After the 19th iteration it agrees to six decimal places. The answer is `π/4 =
0.7853981634`, which is right: `cos` and `sin` cross at 45°.

---

## 5. The part you are missing: WHEN does it converge?

This is the rule that makes the topic click.

```
┌───────────────────────────────────────────────┐
│  Compute g'(x) near the root r.               │
│                                               │
│  |g'(r)| < 1   →  converges                   │
│  |g'(r)| > 1   →  diverges                    │
│  |g'(r)| = 1   →  no answer, test by hand     │
│                                               │
│  Smaller |g'(r)|  =  faster convergence       │
└───────────────────────────────────────────────┘
```

**Why.** Let `e_k = x_k − r` be the error at step `k`. Then

```
e_{k+1} = x_{k+1} − r = g(x_k) − g(r)
```

Taylor expand `g` around `r`:  `g(x_k) ≈ g(r) + g'(r)(x_k − r)`, so

```
e_{k+1} ≈ g'(r) · e_k
```

**Each step multiplies the error by `g'(r)`.** Multiply by something smaller
than 1 over and over → error shrinks to zero. Multiply by something bigger than
1 → error blows up. That is the whole story.

### Check the three `g` at `r = 0.682327804`

| `g` | `g'(x)` | `|g'(r)|` | Result |
|---|---|---|---|
| `1 − x³` | `−3x²` | **1.397** | > 1 → diverges ✗ |
| `∛(1 − x)` | `−1 / (3(1−x)^{2/3})` | **0.716** | < 1 → converges, slow (25 iters) |
| `(1+2x³)/(3x²+1)` | `→ 0` at the root | **≈ 0** | converges very fast (5 iters) |

Now the tables make sense. `0.716` per step means the error only drops ~28% each
time, so you need many steps. `≈ 0` means the error roughly **squares** each
step, so you get many correct digits at once.

Check Example 2 too: `g(x) = x + cos x − sin x`, so `g'(x) = 1 − sin x − cos x`.
At `π/4`: `1 − 0.70711 − 0.70711 = −0.414`. `|−0.414| < 1` → converges. ✓

---

## 6. The recipe (use this in the exam)

1. Rearrange `f(x) = 0` into `x = g(x)`. Isolate an `x`, or add `x` to both
   sides.
2. **Test `g'` before you iterate.** If `|g'| > 1` near the guess, pick a
   different rearrangement now. Do not waste 10 rows.
3. Build a table: columns `iteration | x | g(x)`.
4. `x₀` = the given start. Each row: `x_{k+1} = g(x_k)`.
5. Stop when the digits you need stop changing (the board used **six decimal
   places**), or when `|x_{k+1} − x_k| < tolerance`.
6. Write the answer as `r ≈ <value>`.

---

## 7. Common mistakes

1. Only trying one rearrangement. If it diverges, that does not mean the
   equation has no root. Rearrange again.
2. Not checking `|g'|` first.
3. Using degrees on a calculator for `cos x = sin x`. **Use radians.** The
   answer `0.785398` is radians.
4. Rounding too early. Keep all the digits your calculator shows. Errors
   compound over 25 iterations.
5. Confusing `f` and `g`. `f(r) = 0`. `g(r) = r`. Different jobs.
6. Stopping when two rows look close. Look at the digits you actually need.

---

## 8. Seatwork from the board (prelim practice)

Find the fixed point of:

1. `x = 2.8x − x²`, `x₀ = 0.1`
2. `3/x = x`, `x₀ = 0.5`
3. `y = y² − 2y + 2`, `y₀ = 0`

Hints (do the work first, then check):
- (1) `g(x) = 2.8x − x²`. Fixed points solve `x = 2.8x − x²` → `x(x − 1.8) = 0`
  → `x = 0` or `x = 1.8`. Check `g'(x) = 2.8 − 2x`: at `0` it is `2.8` (> 1,
  repels), at `1.8` it is `−0.8` (< 1, attracts). So from `0.1` you go to `1.8`.
  It is slow and it overshoots: `0.1 → 0.27 → 0.6831 → 1.446 → 1.958 → 1.649 →
  1.898 → ...`, closing in on `1.8` from both sides. `|g'| = 0.8` per step.
- (2) `g(x) = 3/x` gives `g'(x) = −3/x²`; at `x = √3` that is `−1`. Borderline —
  it will just flip between two values forever. Rearrange instead, e.g.
  `g(x) = (x + 3/x)/2`, which converges to `√3 = 1.7320508`.
- (3) `g(y) = y² − 2y + 2`. Fixed points: `y = y² − 2y + 2` → `y² − 3y + 2 = 0`
  → `y = 1` or `y = 2`. `g'(y) = 2y − 2`: at `y = 1` it is `0` (attracts), at
  `y = 2` it is `2` (repels). But watch the arithmetic: `g(0) = 2` exactly, and
  `g(2) = 2`. So from `y₀ = 0` you land on **2 in one step** and stay. A repelling
  fixed point still holds you if you land on it exactly.

**Prelim coverage (from the board):** Propagation Error, Bisection Method,
Fixed-Point Iteration.
