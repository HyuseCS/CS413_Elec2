# Secant Method — Quick Reviewer

> No board photos in this folder yet. Built from the standard method. It uses the
> same equation as the other guides, $x^3 + x - 1 = 0$, so you can compare.
> All numbers were re-computed. Read the Newton reviewer first.

---

## 1. The formula (memorize this)

$$
x_{k+1} = x_k - \frac{f(x_k) \cdot (x_k - x_{k-1})}{f(x_k) - f(x_{k-1})}
$$

You need **two** starting guesses, $x_0$ and $x_1$. You do **not** need $f'$.

---

## 2. Where the formula comes from

Newton needs $f'(x_k)$. Sometimes $f'$ is hard to find, or you only have
numbers, not a formula. So **replace the derivative with a slope through your
last two points**:

$$
f'(x_k) \approx \frac{f(x_k) - f(x_{k-1})}{x_k - x_{k-1}}
$$

Put that into Newton, $x_{k+1} = x_k - f(x_k) / f'(x_k)$. Dividing by a
fraction is multiplying by it flipped:

$$
x_{k+1} = x_k - \frac{f(x_k) \cdot (x_k - x_{k-1})}{f(x_k) - f(x_{k-1})}
$$

Picture: Newton follows the **tangent** (touches at one point). Secant follows
the **secant line** (cuts through two points). Where that line hits zero is
your next guess.

```
        f
        │           ● (x_k, f(x_k))
        │         /
        │       /   ← secant line
  ──────┼─────✕───────────── x
        │   /x_{k+1}
        │ ● (x_{k−1}, f(x_{k−1}))
```

---

## 3. Worked example

$f(x) = x^3 + x - 1$, $x_0 = 0$, $x_1 = 1$.

$$
\begin{aligned}
f(0) &= -1 \\
f(1) &= +1
\end{aligned}
$$

**Step 1, all the arithmetic** (uses $x_0$ and $x_1$):

$$
\begin{aligned}
x_2 &= x_1 - \frac{f(x_1)(x_1 - x_0)}{f(x_1) - f(x_0)} \\
&= 1 - \frac{1 \cdot (1 - 0)}{1 - (-1)} \\
&= 1 - \frac{1}{2} \\
&= 0.5 \\
f(0.5) &= 0.125 + 0.5 - 1 = -0.375
\end{aligned}
$$

**Step 2** (drop $x_0$, now use $x_1$ and $x_2$):

$$
\begin{aligned}
x_3 &= 0.5 - \frac{(-0.375)(0.5 - 1)}{-0.375 - 1} \\
\text{top} &= (-0.375)(-0.5) = 0.1875 \\
\text{bottom} &= -1.375 \\
x_3 &= 0.5 - \frac{0.1875}{-1.375} \\
&= 0.5 + 0.136364 \\
&= 0.636364
\end{aligned}
$$

Full table:

| k | x_k | f(x_k) | error $\lvert x_k - r \rvert$ |
|---|---|---|---|
| 0 | 0.000000000 | −1.000000000 | — |
| 1 | 1.000000000 | 1.000000000 | — |
| 2 | 0.500000000 | −0.375000000 | 1.8e-1 |
| 3 | 0.636363636 | −0.105935387 | 4.6e-2 |
| 4 | 0.690052356 | 0.018636142 | 7.7e-3 |
| 5 | 0.682020420 | −0.000736518 | 3.1e-4 |
| 6 | 0.682325781 | −0.000004847 | 2.0e-6 |
| 7 | 0.682327804 | 0.000000001 | 5.3e-10 |

$r \approx 0.682327804$ at step 7.

**Only one new $f$ value per step.** Each row reuses the $f$ from the row
before. Newton needs $f$ and $f'$ every step.

---

## 4. Speed

The error rule:

$$
e_{k+1} \approx M \cdot e_k \cdot e_{k-1} \qquad M = \left\lvert \frac{f''(r)}{2f'(r)} \right\rvert
$$

(same $M$ as Newton)

The new error is the product of the **last two** errors. That works out to

$$
e_{k+1} \approx C \cdot e_k^\alpha \qquad \alpha = \frac{1 + \sqrt{5}}{2} \approx 1.618
$$

(the golden ratio)

This is called **superlinear** convergence. Faster than linear (bisection,
fixed-point). Slower than quadratic (Newton, $\alpha = 2$).

See it in the table: $3.1\text{e-4} \to 2.0\text{e-6} \to 5.3\text{e-10}$. The exponent grows about
1.6 times each step, not 2 times.

**Per step, Newton wins. Per unit of work, secant often wins,** because it
does not compute $f'$.

---

## 5. Secant vs. bisection (do not mix them up)

Both use two points. They are **different**.

| | Bisection | Secant |
|---|---|---|
| Next point | midpoint | where the secant line hits zero |
| Which points kept | the two that keep opposite signs | always the **last two** |
| Needs $f(a) \cdot f(b) < 0$? | Yes | **No** |
| Always converges? | Yes | No |

Secant throws away the oldest point **no matter what the signs are**. The two
points do not need to bracket the root.

(The method that uses the secant line but keeps the sign bracket is called
**false position / regula falsi**. Different method.)

---

## 6. When secant fails

1. **$f(x_k) = f(x_{k-1})$.** The bottom is zero. The secant line is flat.
2. **Bad starting points.** It can run away, same as Newton.
3. **Multiple root.** It slows to linear, same as Newton.

---

## 7. The recipe (use this in the exam)

1. Write `f(x)` so the equation is $f(x) = 0$.
2. Table columns: `k | x_k | f(x_k)`. Put $x_0$ and $x_1$ in the first two rows.
3. Each new row uses the **two rows above it**:
   $x_{k+1} = x_k - f(x_k)(x_k - x_{k-1}) / (f(x_k) - f(x_{k-1}))$.
4. Stop when the digits you need stop changing, or $\lvert x_{k+1} - x_k \rvert < \text{tol}$.
5. Answer: $r \approx \text{<value>}$.

---

## 8. Common mistakes

1. Mixing up the order. The top is $x_k - x_{k-1}$, the bottom is
   $f(x_k) - f(x_{k-1})$. **Same order on top and bottom.** If you flip only
   one, you get the wrong sign.
2. Keeping points by sign, like bisection. Secant always keeps the last two.
3. Degrees instead of radians. **Use radians.**
4. Rounding too early.

---

## 9. All four methods side by side

$f(x) = x^3 + x - 1$, root `0.682327804`:

| Method | Needs | Speed | Steps here | Always works? |
|---|---|---|---|---|
| Bisection | $[a,b]$ with sign change | linear, halves each step | 9 for ~3 digits | Yes |
| Fixed-point | $g$, one guess | linear, $\lvert g'(r) \rvert$ per step | 25 ($g_2$) or diverges ($g_1$) | No |
| Newton | $f$, $f'$, one guess | quadratic, $\alpha = 2$ | 4 (from $x_0 = 1$) | No |
| Secant | $f$, two guesses | superlinear, $\alpha \approx 1.618$ | 7 (from `0, 1`) | No |

---

## 10. Practice (do it first, then check)

1. $x^3 - 2x - 5 = 0$, $x_0 = 2$, $x_1 = 3$.
2. $\cos x = x$, $x_0 = 0$, $x_1 = 1$.

Answers:

- (1) $f(2) = -1$, $f(3) = 16$.
  $x_2 = 3 - 16(3 - 2)/(16 - (-1)) = 3 - 16/17 = 2.058823529$.
  Then $2.081263660 \to 2.094824146 \to 2.094549431 \to 2.094551481 \to 2.094551482$.
- (2) $f(x) = \cos x - x$.
  $0.685073357 \to 0.736298998 \to 0.739119362 \to 0.739085112 \to 0.739085133$.
  Same root Newton found, in 5 new points instead of 3.
