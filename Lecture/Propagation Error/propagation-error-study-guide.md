# Propagation Error — Study Guide

> Note: the `Lecture/Propagation Error/` folder had no photos. This guide is built
> from the standard method, matched to `ps1.png` and your `legaspi_ps1.R` code.

---

## 1. The idea in one line

You measure things. Your measurements are not exact. When you put them in a
formula, the error goes **into** the answer. Propagation error tells you **how
big** the error in the answer is.

Written as: `value ± error`.

---

## 2. Words you need

| Word | Meaning |
|---|---|
| True value | The real number. You never know it. |
| Measured value | What you read on the tool. Call it `x`. |
| Absolute error `Δx` | How far off you can be. Same unit as `x`. |
| Relative error | `Δx / x`. No unit. Often a percent. |
| Maximum absolute error | The **worst case** error. This is what we compute. |

Example: `h = 0.004 ± 0.001` means `Δh = 0.001`, and the true `h` is somewhere
in `[0.003, 0.005]`.

---

## 3. One variable: the derivation

You have `y = f(x)`. You know `x` and `Δx`. You want `Δy`.

**Step 1.** Write what the error means.

```
y_true = f(x + δ)      where  |δ| ≤ Δx
```

**Step 2.** Taylor expand `f` around `x`:

```
f(x + δ) = f(x) + f'(x)·δ + f''(x)·δ²/2 + ...
```

**Step 3.** `δ` is small, so `δ²` is very small. Drop it and everything after.

```
f(x + δ) ≈ f(x) + f'(x)·δ
```

**Step 4.** Move `f(x)` to the left. That difference **is** the error in `y`.

```
Δy = f(x + δ) − f(x) ≈ f'(x)·δ
```

**Step 5.** Take absolute values, and use the worst case `|δ| = Δx`.

```
┌─────────────────────┐
│  Δy = |f'(x)| · Δx  │
└─────────────────────┘
```

Read it like this: **the slope is the amplifier.** Steep slope = small input
error becomes big output error. Flat slope = error gets squashed.

---

## 4. Many variables: the general formula

Now `y = f(x₁, x₂, ..., xₙ)`. Same steps, but the Taylor expansion is the
multivariable one:

```
f(x₁+δ₁, ..., xₙ+δₙ) ≈ f(x₁,...,xₙ) + ∂f/∂x₁·δ₁ + ∂f/∂x₂·δ₂ + ... + ∂f/∂xₙ·δₙ
```

So

```
Δy = ∂f/∂x₁·δ₁ + ... + ∂f/∂xₙ·δₙ
```

Each `δᵢ` can be plus or minus. The worst case is when **every term pushes the
same way**. Use the triangle inequality and set each `|δᵢ| = Δxᵢ`:

```
┌──────────────────────────────────────────────┐
│  Δy = Σ | ∂f/∂xᵢ | · Δxᵢ                     │   ← MAXIMUM ABSOLUTE ERROR
│     = |∂f/∂x₁|Δx₁ + |∂f/∂x₂|Δx₂ + ...        │
└──────────────────────────────────────────────┘
```

**Three things to never forget:**
1. Take the **absolute value** of each partial derivative. Errors never cancel
   in the worst case.
2. **Add**, never subtract.
3. Plug the **measured values** into the partials before multiplying.

---

## 5. The recipe (use this in the exam)

1. Write the formula `y = f(...)`.
2. List each variable with its value and its `Δ`.
3. Compute `y` with the measured values. ← this is `y_actual`
4. Take `∂f/∂x` for **each** variable, one at a time.
5. Plug the measured values into each partial. Take `| |`.
6. Multiply each by that variable's `Δx`.
7. Add them all. ← this is `Δy`
8. Answer: `y ± Δy`, or the range `[y − Δy, y + Δy]`.

---

## 6. Worked example (the `ps1.png` one)

```
ε = F / (h²E)

F = 72         ΔF = 0.9
h = 0.004      Δh = 0.001
E = 7×10¹⁰     ΔE = 1.5×10⁹
```

**Step 3 — the value:**

```
h²E = (0.004)² × 7×10¹⁰ = 1.6×10⁻⁵ × 7×10¹⁰ = 1.12×10⁶
ε   = 72 / 1.12×10⁶ = 6.428571×10⁻⁵
```

**Step 4 — the partials.** Rewrite as `ε = F · h⁻² · E⁻¹` so the power rule is easy.

```
∂ε/∂F =  1/(h²E)      =  1/1.12×10⁶     =  8.9286×10⁻⁷
∂ε/∂h = −2F/(h³E)     = −2(72)/(6.4×10⁻⁸ × 7×10¹⁰) = −0.0321429
∂ε/∂E = −F/(h²E²)     = −ε/E            = −9.1837×10⁻¹⁶
```

**Steps 5–7 — multiply and add:**

```
|∂ε/∂F|·ΔF = 8.9286×10⁻⁷ × 0.9      = 8.0357×10⁻⁷
|∂ε/∂h|·Δh = 0.0321429  × 0.001     = 3.2143×10⁻⁵   ← the big one
|∂ε/∂E|·ΔE = 9.1837×10⁻¹⁶ × 1.5×10⁹ = 1.3776×10⁻⁶
                                      ─────────────
                             Δε     = 3.4324×10⁻⁵
```

**Step 8 — answer:**

```
ε = 6.4286×10⁻⁵ ± 3.4324×10⁻⁵
range = [3.00×10⁻⁵, 9.86×10⁻⁵]
```

**What this tells you:** `h` causes almost all the error. `h` is tiny (0.004)
and its error (0.001) is 25% of it, and it sits **squared in the denominator**,
so it gets doubled on top. Fix your measurement of `h` first.

> Careful: the printed answer on `ps1.png` says `0.0000053955`. My hand
> computation and your `legaspi_ps1.R` both give `3.4324×10⁻⁵`. Ask your teacher
> which numbers the sheet meant. Your code is right for the method.

---

## 7. Shortcut rules (good for a quick check)

These come straight from the general formula. Use them to check your work.

| Formula | Max absolute error | Max relative error |
|---|---|---|
| `y = x₁ + x₂` | `Δx₁ + Δx₂` | — |
| `y = x₁ − x₂` | `Δx₁ + Δx₂` (still **add**) | — |
| `y = x₁·x₂` | — | `Δx₁/x₁ + Δx₂/x₂` |
| `y = x₁/x₂` | — | `Δx₁/x₁ + Δx₂/x₂` |
| `y = xⁿ` | — | `|n|·Δx/x` |

Rule of thumb: **add absolute errors** when you add or subtract. **Add relative
errors** when you multiply or divide. A power `n` multiplies the relative error
by `|n|`.

Check on the example: `ε = F h⁻² E⁻¹` is all multiply/divide, so

```
Δε/ε = ΔF/F + 2·Δh/h + ΔE/E
     = 0.9/72 + 2(0.001/0.004) + 1.5×10⁹/7×10¹⁰
     = 0.0125 + 0.5 + 0.021429 = 0.533929
Δε   = 0.533929 × 6.428571×10⁻⁵ = 3.4324×10⁻⁵   ✓ same answer
```

---

## 8. Common mistakes

1. Forgetting `| |` on the partial. You get a smaller, wrong error.
2. Subtracting terms because a partial was negative.
3. Using the derivative formula but never plugging in the numbers.
4. Mixing absolute and relative error in the same sum.
5. In `x₁ − x₂`: thinking errors cancel. They do not. This is also the
   **subtractive cancellation** trap — when `x₁ ≈ x₂` the answer is tiny but the
   error stays the same size, so the relative error explodes.

---

## 9. Practice

1. `A = πr²`, `r = 5.0 ± 0.1`. Find `A ± ΔA`.
   *(Answer: `A = 78.5398`, `ΔA = |2πr|·0.1 = 3.1416`.)*
2. `V = lwh`, `l = 10 ± 0.1`, `w = 5 ± 0.1`, `h = 2 ± 0.05`.
   *(Answer: `V = 100`, `ΔV = |wh|(0.1) + |lh|(0.1) + |lw|(0.05) = 1 + 2 + 2.5 = 5.5`.)*
3. `T = 2π√(L/g)`, `L = 1.0 ± 0.01`, `g = 9.81 ± 0.02`. Use the relative rule:
   `ΔT/T = ½(ΔL/L) + ½(Δg/g)`.
