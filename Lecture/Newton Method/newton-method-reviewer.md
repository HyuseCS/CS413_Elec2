# Newton's Method — Quick Reviewer

> No board photos in this folder yet. Built from the standard method. It uses the
> same equation as the other guides, `x³ + x − 1 = 0`, so you can compare.
> All numbers were re-computed.

---

## 1. The formula (memorize this)

```
x_{k+1} = x_k − f(x_k) / f'(x_k)
```

You need `f` **and** its derivative `f'`. You need **one** starting guess `x₀`.

---

## 2. Where the formula comes from

Stand at your guess `x_k` on the curve. Draw the **tangent line** there. The
tangent is a straight line, so you can find where it hits zero. That spot is
your next guess.

The tangent line at `x_k`:

```
y = f(x_k) + f'(x_k)(x − x_k)
```

Set `y = 0` and solve for `x`:

```
0 = f(x_k) + f'(x_k)(x − x_k)
−f(x_k) = f'(x_k)(x − x_k)
x − x_k = −f(x_k) / f'(x_k)
x       = x_k − f(x_k) / f'(x_k)
```

That `x` is `x_{k+1}`. That is the whole method: **follow the tangent down to
zero, then repeat.**

```
        f
        │        ●  (x_k, f(x_k))
        │       /
        │      /  ← tangent
  ──────┼─────✕──────●──── x
        │   x_{k+1}  x_k
```

---

## 3. Worked example

`f(x) = x³ + x − 1`, so `f'(x) = 3x² + 1`. Start at `x₀ = 1`.

**Step 1, all the arithmetic:**

```
f(1)  = 1 + 1 − 1 = 1
f'(1) = 3(1) + 1  = 4
x₁    = 1 − 1/4   = 0.75
```

**Step 2:**

```
f(0.75)  = 0.421875 + 0.75 − 1 = 0.171875
f'(0.75) = 3(0.5625) + 1       = 2.6875
x₂       = 0.75 − 0.171875/2.6875
         = 0.75 − 0.063953
         = 0.686047
```

Full table:

| k | x_k | f(x_k) | f'(x_k) | error `|x_k − r|` |
|---|---|---|---|---|
| 0 | 1.000000000 | 1.000000000 | 4.000000 | 3.2e-1 |
| 1 | 0.750000000 | 0.171875000 | 2.687500 | 6.8e-2 |
| 2 | 0.686046512 | 0.008941037 | 2.411979 | 3.7e-3 |
| 3 | 0.682339583 | 0.000028231 | 2.396762 | 1.2e-5 |
| 4 | 0.682327804 | 0.000000000 | 2.396714 | 1.2e-10 |

`r ≈ 0.682327804` in **4 steps**. Bisection needed 9 steps for only 3 digits.

**Look at the error column.** `1e-5` becomes `1e-10`. The exponent doubles.
That means **the number of correct digits roughly doubles every step.** This is
called **quadratic convergence**.

A bad start still works here, just slower. From `x₀ = −0.7`:

```
−0.700000000 → 0.127125506 → 0.957678119 → 0.734827795
→ 0.684591771 → 0.682332174 → 0.682327804
```

It wanders for 2 steps. Once it gets close, the digits double again.

---

## 4. Why it is so fast (link to fixed-point)

Newton **is** fixed-point iteration with this `g`:

```
g(x) = x − f(x)/f'(x)
```

For `x³ + x − 1` that is:

```
g(x) = x − (x³ + x − 1)/(3x² + 1)
     = (x(3x² + 1) − (x³ + x − 1)) / (3x² + 1)
     = (3x³ + x − x³ − x + 1) / (3x² + 1)
     = (2x³ + 1) / (3x² + 1)
```

That is **`g₃` from the fixed-point guide**. Same thing.

From the fixed-point guide: each step multiplies the error by `g'(r)`. For
Newton, `g'(r) = 0`. Check:

```
g'(x) = 1 − (f'·f' − f·f'') / f'²  =  f(x)·f''(x) / f'(x)²

at the root f(r) = 0, so g'(r) = 0
```

With `g'(r) = 0`, the error is not multiplied by a number. It is multiplied by
**itself**:

```
e_{k+1} ≈ M · e_k²        where   M = | f''(r) / (2 f'(r)) |
```

For our example: `f''(x) = 6x`, so

```
M = 6(0.682328) / (2 · 2.396714) = 4.093968 / 4.793427 = 0.854
```

Check it with the table: `e₄ / e₃² = 1.18e-10 / (1.18e-5)² ≈ 0.85`. ✓

---

## 5. When Newton fails

1. **`f'(x_k) = 0`.** You divide by zero. The tangent is flat and never hits
   the x-axis. Pick a new `x₀`.
2. **Bad start, it cycles.** `f(x) = x³ − 2x + 2`, `x₀ = 0`:

   ```
   x₁ = 0 − 2/(−2) = 1
   x₂ = 1 − 1/1    = 0
   x₃ = 1,  x₄ = 0,  ...   forever
   ```

3. **Bad start, it runs away** to a different root, or to infinity.
4. **Multiple (repeated) root → only linear.** `f(x) = x²` has a double root
   at `0`. Newton gives `x_{k+1} = x_k − x_k²/(2x_k) = x_k/2`:

   ```
   1 → 0.5 → 0.25 → 0.125 → 0.0625 → ...
   ```

   The error only halves. Same speed as bisection. Here `f'(r) = 0` too, so
   `M` breaks.

   Rule: at a root of multiplicity `m`, Newton is linear with
   `e_{k+1} ≈ ((m − 1)/m) · e_k`. Fix: **modified Newton**,
   `x_{k+1} = x_k − m·f(x_k)/f'(x_k)`. That gets quadratic back.

---

## 6. The recipe (use this in the exam)

1. Write `f(x)` so the equation is `f(x) = 0`.
2. Find `f'(x)`. **Check it twice.** A wrong derivative ruins every row.
3. Table columns: `k | x_k | f(x_k) | f'(x_k) | x_{k+1}`.
4. Each row: `x_{k+1} = x_k − f(x_k)/f'(x_k)`.
5. Stop when the digits you need stop changing, or `|x_{k+1} − x_k| < tol`.
6. Answer: `r ≈ <value>`.

---

## 7. Common mistakes

1. Wrong derivative.
2. Sign error: it is **minus** `f/f'`.
3. Degrees instead of radians for trig. **Use radians.**
4. Rounding too early. Keep all the digits.
5. Not noticing `f'(x₀) = 0` or a cycle. Change `x₀`.

---

## 8. Practice (do it first, then check)

1. `√5` with Newton. Use `f(x) = x² − 5`, `x₀ = 2`.
2. `cos x = x`, `x₀ = 1`.
3. `x³ − 2x + 2 = 0`, `x₀ = 0`. What happens?

Answers:

- (1) `f' = 2x`, so `x_{k+1} = x_k − (x_k² − 5)/(2x_k)`.
  `2 → 2.25 → 2.236111111 → 2.236067978 → 2.236067977`.
  Step 1: `2 − (4 − 5)/4 = 2 + 0.25 = 2.25`.
- (2) `f(x) = cos x − x`, `f'(x) = −sin x − 1`.
  `1 → 0.750363868 → 0.739112891 → 0.739085133`. Converged in 3 steps.
- (3) It cycles `0, 1, 0, 1, ...`. Newton fails from this start. Pick another
  `x₀` (the real root is near `−1.769`).
