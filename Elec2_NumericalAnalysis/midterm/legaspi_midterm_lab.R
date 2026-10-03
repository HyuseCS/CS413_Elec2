library(Deriv)

newton_secant <- function(f, x0, accuracy) {
  row <- function(i, method, a, b) cat(i, method, sprintf("%.*f", accuracy + 2, c(a, b, f(b))), "\n", sep = "\t")
  d <- Deriv(f, "x")
  x1 <- x0 - (f(x0) / d(x0))
  cat("i", "method", "x_old", "x_new", "f(x_new)", "\n", sep = "\t")
  row(1, "Newton", x0, x1)
  xs <- c(x0, x1)
  i <- 1
  while (is.finite(x1) && round(x1, accuracy) != round(x0, accuracy)) {
    r <- round(tail(xs, 4), accuracy)
    if (i >= 50 || (length(r) == 4 && r[1] == r[3] && r[2] == r[4])) break
    x2 <- x1 - (f(x1) * (x1 - x0) / (f(x1) - f(x0)))
    x0 <- x1
    x1 <- x2
    i <- i + 1
    row(i, "Secant", x0, x1)
    xs <- c(xs, x1)
  }
  if (!is.finite(x1) || round(x1, accuracy) != round(x0, accuracy)) return(cat("\nThe root diverges.\n"))
  if (i == 1) cat("\nNewton already converged in the first iteration, so the secant method is not needed.\n")
  cat(sprintf("\nThe root is %.*f\n", accuracy, x1))
}

con <- if (!interactive()) file("stdin", "r")
ask <- function(prompt) {
  cat(prompt)
  if (interactive()) readline() else readLines(con, n = 1)
}

f <- eval(parse(text = paste("function(x)", ask("f(x) = "))))
x0 <- as.numeric(ask("x0 = "))
accuracy <- as.numeric(ask("Number of decimal places = "))
newton_secant(f, x0, accuracy)
