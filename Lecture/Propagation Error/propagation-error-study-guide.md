# Propagation Error — Study Guide

> Note: the `Lecture/Propagation Error/` folder had no photos. This guide is built
> from the standard method, matched to `ps1.png` and your `legaspi_ps1.R` code.

---

## 1. The idea in one line

You measure things. Your measurements are not exact. When you put them in a
formula, the error goes **into** the answer. Propagation error tells you **how
big** the error in the answer is.

Written as: $\text{value} \pm \text{error}$.

---

## 2. Words you need

| Word | Meaning |
|---|---|
| True value | The real number. You never know it. |
| Measured value | What you read on the tool. Call it $x$. |
| Absolute error $\Delta x$ | How far off you can be. Same unit as $x$. |
| Relative error | $\Delta x / x$. No unit. Often a percent. |
| Maximum absolute error | The **worst case** error. This is what we compute. |

Example: $h = 0.004 \pm 0.001$ means $\Delta h = 0.001$, and the true $h$ is somewhere
in $[0.003, 0.005]$.

---

## 3. One variable: the derivation

You have $y = f(x)$. You know $x$ and $\Delta x$. You want $\Delta y$.

**Step 1.** Write what the error means.

$$
y_{\text{true}} = f(x + \delta) \quad \text{where } \lvert \delta \rvert \le \Delta x
$$

**Step 2.** Taylor expand $f$ around $x$:

$$
f(x + \delta) = f(x) + f'(x)\cdot \delta + f''(x)\cdot \frac{\delta^2}{2} + \ldots
$$

**Step 3.** $\delta$ is small, so $\delta^2$ is very small. Drop it and everything after.

$$
f(x + \delta) \approx f(x) + f'(x)\cdot \delta
$$

**Step 4.** Move $f(x)$ to the left. That difference **is** the error in $y$.

$$
\Delta y = f(x + \delta) - f(x) \approx f'(x)\cdot \delta
$$

**Step 5.** Take absolute values, and use the worst case $\lvert \delta \rvert = \Delta x$.

> $$
> \Delta y = \lvert f'(x) \rvert \cdot \Delta x
> $$

Read it like this: **the slope is the amplifier.** Steep slope = small input
error becomes big output error. Flat slope = error gets squashed.

---

## 4. Many variables: the general formula

Now $y = f(x_1, x_2, \ldots, x_n)$. Same steps, but the Taylor expansion is the
multivariable one:

$$
f(x_1+\delta_1, \ldots, x_n+\delta_n) \approx f(x_1,\ldots,x_n) + \frac{\partial f}{\partial x_1}\cdot \delta_1 + \frac{\partial f}{\partial x_2}\cdot \delta_2 + \ldots + \frac{\partial f}{\partial x_n}\cdot \delta_n
$$

So

$$
\Delta y = \frac{\partial f}{\partial x_1}\cdot \delta_1 + \ldots + \frac{\partial f}{\partial x_n}\cdot \delta_n
$$

Each $\delta_i$ can be plus or minus. The worst case is when **every term pushes the
same way**. Use the triangle inequality and set each $\lvert \delta_i \rvert = \Delta x_i$:

> $$
> \begin{aligned}
> \Delta y &= \sum_i \left\lvert \frac{\partial f}{\partial x_i} \right\rvert \cdot \Delta x_i &\quad \text{MAXIMUM ABSOLUTE ERROR} \\
> &= \left\lvert \frac{\partial f}{\partial x_1} \right\rvert \Delta x_1 + \left\lvert \frac{\partial f}{\partial x_2} \right\rvert \Delta x_2 + \ldots
> \end{aligned}
> $$

**Three things to never forget:**
1. Take the **absolute value** of each partial derivative. Errors never cancel
   in the worst case.
2. **Add**, never subtract.
3. Plug the **measured values** into the partials before multiplying.

---

## 5. The recipe (use this in the exam)

1. Write the formula $y = f(\ldots)$.
2. List each variable with its value and its $\Delta$.
3. Compute $y$ with the measured values. ← this is $y_{\text{actual}}$
4. Take $\partial f/\partial x$ for **each** variable, one at a time.
5. Plug the measured values into each partial. Take $\lvert \cdot \rvert$.
6. Multiply each by that variable's $\Delta x$.
7. Add them all. ← this is $\Delta y$
8. Answer: $y \pm \Delta y$, or the range $[y - \Delta y, y + \Delta y]$.

---

## 6. Worked example (the `ps1.png` one)

$$
\varepsilon = \frac{F}{h^2 E}
$$

```
F = 72         ΔF = 0.9
h = 0.004      Δh = 0.001
E = 7×10¹⁰     ΔE = 1.5×10⁹
```

**Step 3 — the value:**

$$
\begin{aligned}
h^2 E &= (0.004)^2 \times 7\times10^{10} = 1.6\times10^{-5} \times 7\times10^{10} = 1.12\times10^{6} \\
\varepsilon &= \frac{72}{1.12\times10^{6}} = 6.428571\times10^{-5}
\end{aligned}
$$

**Step 4 — the partials.** Rewrite as $\varepsilon = F \cdot h^{-2} \cdot E^{-1}$ so the power rule is easy.

$$
\begin{aligned}
\frac{\partial \varepsilon}{\partial F} &= \frac{1}{h^2 E} = \frac{1}{1.12\times10^{6}} = 8.9286\times10^{-7} \\
\frac{\partial \varepsilon}{\partial h} &= -\frac{2F}{h^3 E} = -\frac{2(72)}{6.4\times10^{-8} \times 7\times10^{10}} = -0.0321429 \\
\frac{\partial \varepsilon}{\partial E} &= -\frac{F}{h^2 E^2} = -\frac{\varepsilon}{E} = -9.1837\times10^{-16}
\end{aligned}
$$

**Steps 5–7 — multiply and add:**

$$
\begin{aligned}
\left\lvert \frac{\partial \varepsilon}{\partial F} \right\rvert \Delta F &= 8.9286\times10^{-7} \times 0.9 = 8.0357\times10^{-7} \\
\left\lvert \frac{\partial \varepsilon}{\partial h} \right\rvert \Delta h &= 0.0321429 \times 0.001 = 3.2143\times10^{-5} &\quad \text{the big one} \\
\left\lvert \frac{\partial \varepsilon}{\partial E} \right\rvert \Delta E &= 9.1837\times10^{-16} \times 1.5\times10^{9} = 1.3776\times10^{-6} \\
\Delta \varepsilon &= 3.4324\times10^{-5}
\end{aligned}
$$

**Step 8 — answer:**

$$
\begin{aligned}
\varepsilon &= 6.4286\times10^{-5} \pm 3.4324\times10^{-5} \\
\text{range} &= [3.00\times10^{-5}, 9.86\times10^{-5}]
\end{aligned}
$$

**What this tells you:** $h$ causes almost all the error. $h$ is tiny (0.004)
and its error (0.001) is 25% of it, and it sits **squared in the denominator**,
so it gets doubled on top. Fix your measurement of $h$ first.

> Careful: the printed answer on `ps1.png` says `0.0000053955`. My hand
> computation and your `legaspi_ps1.R` both give $3.4324\times10^{-5}$. Ask your teacher
> which numbers the sheet meant. Your code is right for the method.

---

## 7. Shortcut rules (good for a quick check)

These come straight from the general formula. Use them to check your work.

| Formula | Max absolute error | Max relative error |
|---|---|---|
| $y = x_1 + x_2$ | $\Delta x_1 + \Delta x_2$ | — |
| $y = x_1 - x_2$ | $\Delta x_1 + \Delta x_2$ (still **add**) | — |
| $y = x_1 \cdot x_2$ | — | $\Delta x_1/x_1 + \Delta x_2/x_2$ |
| $y = x_1/x_2$ | — | $\Delta x_1/x_1 + \Delta x_2/x_2$ |
| $y = x^n$ | — | $\lvert n \rvert \cdot \Delta x/x$ |

Rule of thumb: **add absolute errors** when you add or subtract. **Add relative
errors** when you multiply or divide. A power $n$ multiplies the relative error
by $\lvert n \rvert$.

Check on the example: $\varepsilon = F h^{-2} E^{-1}$ is all multiply/divide, so

$$
\begin{aligned}
\frac{\Delta \varepsilon}{\varepsilon} &= \frac{\Delta F}{F} + 2\cdot\frac{\Delta h}{h} + \frac{\Delta E}{E} \\
&= \frac{0.9}{72} + 2\left(\frac{0.001}{0.004}\right) + \frac{1.5\times10^{9}}{7\times10^{10}} \\
&= 0.0125 + 0.5 + 0.021429 = 0.533929 \\
\Delta \varepsilon &= 0.533929 \times 6.428571\times10^{-5} = 3.4324\times10^{-5}
\end{aligned}
$$

✓ same answer

---

## 8. Common mistakes

1. Forgetting $\lvert \cdot \rvert$ on the partial. You get a smaller, wrong error.
2. Subtracting terms because a partial was negative.
3. Using the derivative formula but never plugging in the numbers.
4. Mixing absolute and relative error in the same sum.
5. In $x_1 - x_2$: thinking errors cancel. They do not. This is also the
   **subtractive cancellation** trap — when $x_1 \approx x_2$ the answer is tiny but the
   error stays the same size, so the relative error explodes.

---

## 9. Practice

1. $A = \pi r^2$, $r = 5.0 \pm 0.1$. Find $A \pm \Delta A$.
   *(Answer: $A = 78.5398$, $\Delta A = \lvert 2\pi r \rvert \cdot 0.1 = 3.1416$.)*
2. $V = lwh$, $l = 10 \pm 0.1$, $w = 5 \pm 0.1$, $h = 2 \pm 0.05$.
   *(Answer: $V = 100$, $\Delta V = \lvert wh \rvert(0.1) + \lvert lh \rvert(0.1) + \lvert lw \rvert(0.05) = 1 + 2 + 2.5 = 5.5$.)*
3. $T = 2\pi\sqrt{L/g}$, $L = 1.0 \pm 0.01$, $g = 9.81 \pm 0.02$. Use the relative rule:
   $\Delta T/T = \frac{1}{2}(\Delta L/L) + \frac{1}{2}(\Delta g/g)$.
