# Trig Derivatives — Cheat Sheet

> For Newton's method you need $f'(x)$. When $f$ has trig in it, use this page.
> Every rule here was checked with a measured slope.

---

## 1. The cycle (memorize this first)

$$
\sin x \;\to\; \cos x \;\to\; -\sin x \;\to\; -\cos x \;\to\; \sin x
$$

Each arrow is one derivative. Move one step to the right.

$$
\frac{d}{dx}\sin x = \cos x
\qquad
\frac{d}{dx}\cos x = -\sin x
$$

**Why the minus on $\cos$.** At $x = 0$, $\cos x$ is at its top ($= 1$). Just
after $0$ it goes **down**. Going down means a negative slope. Just after $0$,
$\sin x$ is positive, so the slope must be $-\sin x$.

Forgot the sign? Picture the graph and check the slope.

---

## 2. All six

| $f(x)$ | $f'(x)$ |
|---|---|
| $\sin x$ | $\cos x$ |
| $\cos x$ | $-\sin x$ |
| $\tan x$ | $\sec^2 x$ |
| $\cot x$ | $-\csc^2 x$ |
| $\sec x$ | $\sec x \tan x$ |
| $\csc x$ | $-\csc x \cot x$ |

**Rule:** the **co**-functions ($\cos$, $\cot$, $\csc$) get a **minus**.

**Pairs:** $\tan \leftrightarrow \cot$ and $\sec \leftrightarrow \csc$ have the
same shape. Swap each function for its co-partner and add a minus.

---

## 3. The identities you need to rewrite things

$$
\tan x = \frac{\sin x}{\cos x}
\qquad
\cot x = \frac{\cos x}{\sin x}
\qquad
\sec x = \frac{1}{\cos x}
\qquad
\csc x = \frac{1}{\sin x}
$$

$$
\sin^2 x + \cos^2 x = 1
$$

**Where $\sec^2 x$ comes from** (quotient rule on $\sin x / \cos x$):

$$
\begin{aligned}
\frac{d}{dx}\tan x
&= \frac{\cos x \cdot \cos x - \sin x \cdot (-\sin x)}{\cos^2 x} \\
&= \frac{\cos^2 x + \sin^2 x}{\cos^2 x} \\
&= \frac{1}{\cos^2 x} = \sec^2 x
\end{aligned}
$$

You can rebuild any of the six this way if you forget one.

---

## 4. The rules that combine them

| Rule | Form | Example |
|---|---|---|
| Constant | $(c \cdot f)' = c \cdot f'$ | $(2\cos x)' = -2\sin x$ |
| Sum | $(f + g)' = f' + g'$ | $(\sin x + x)' = \cos x + 1$ |
| Product | $(fg)' = f'g + fg'$ | $(x\sin x)' = \sin x + x\cos x$ |
| Quotient | $\left(\frac{f}{g}\right)' = \frac{f'g - fg'}{g^2}$ | $\left(\frac{\sin x}{x}\right)' = \frac{x\cos x - \sin x}{x^2}$ |
| Chain | $f(g(x))' = f'(g(x)) \cdot g'(x)$ | $\sin(2x)' = 2\cos(2x)$ |

**Chain rule, the one people forget.** If something is **inside** the trig
function, take the derivative of the inside and multiply it on:

$$
\begin{aligned}
\frac{d}{dx}\sin(3x) &= \cos(3x) \cdot 3 \\
\frac{d}{dx}\cos(x^2) &= -\sin(x^2) \cdot 2x \\
\frac{d}{dx}\sin^2 x &= 2\sin x \cdot \cos x
\end{aligned}
$$

$\sin^2 x$ means $(\sin x)^2$. The outside is "square", the inside is $\sin x$.

---

## 5. Inverse trig (just in case)

| $f(x)$ | $f'(x)$ |
|---|---|
| $\arcsin x$ | $\dfrac{1}{\sqrt{1 - x^2}}$ |
| $\arccos x$ | $-\dfrac{1}{\sqrt{1 - x^2}}$ |
| $\arctan x$ | $\dfrac{1}{1 + x^2}$ |

Same rule: the **co** one ($\arccos$) gets the minus.

---

## 6. Newton-shaped examples

The quiz gives an equation. Move everything to one side, then take $f'$.

| Equation | $f(x)$ | $f'(x)$ |
|---|---|---|
| $\cos x = x$ | $\cos x - x$ | $-\sin x - 1$ |
| $\sin x = x/2$ | $x - 2\sin x$ | $1 - 2\cos x$ |
| $e^{-x} = \sin x$ | $e^{-x} - \sin x$ | $-e^{-x} - \cos x$ |
| $\cos x = x^2$ | $\cos x - x^2$ | $-\sin x - 2x$ |

Then:

$$
x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)}
$$

---

## 7. Traps

1. **Radians, not degrees.** Every rule on this page is only true in radians.
2. **The sign on $\cos$.** $(\cos x)' = -\sin x$. Check with the graph.
3. **The chain rule.** $(\sin 2x)' = 2\cos 2x$, not $\cos 2x$.
4. **$\sin^2 x$ is not $\sin(x^2)$.** Different inside, different derivative.
5. **Double minus.** $(-\cos x)' = -(-\sin x) = +\sin x$.

---

## 8. Drill answers

1. $(\sin x + x)' = \cos x + 1$
2. $(2\cos x)' = -2\sin x$
3. $(x - \sin x)' = 1 - \cos x$
4. $(\sin 2x)' = 2\cos 2x$
5. $(\cos x - x^2)' = -\sin x - 2x$
