library(Deriv)

newton_secant <- function(f, x0, accuracy) {
  d <- Deriv(f, "x")
  x1 <- x0 - (f(x0) / d(x0))
  cat(sprintf("Newton x1: %.*f\n", accuracy + 2, x1))
  xs <- c(x0, x1)
  i <- 1
  while (is.finite(x1) && round(x1, accuracy) != round(x0, accuracy)) {
    r <- round(tail(xs, 4), accuracy)
    if (i >= 50 || (length(r) == 4 && r[1] == r[3] && r[2] == r[4])) break
    x2 <- x1 - (f(x1) * (x1 - x0) / (f(x1) - f(x0)))
    x0 <- x1
    x1 <- x2
    i <- i + 1
    cat(sprintf("Secant x%d: %.*f\n", i, accuracy + 2, x1))
    xs <- c(xs, x1)
  }
  if (!is.finite(x1) || round(x1, accuracy) != round(x0, accuracy)) return(cat("\nThe root diverges.\n"))
  if (i == 1) cat("\nNewton already converged in the first iteration, so the secant method is not needed.\n")
  cat(sprintf("\nThe root is %.*f\n", accuracy, x1))
}

con <- if (!interactive()) file("stdin", "r")
ask <- function(prompt) {
  if (interactive()) return(readline(prompt))
  cat(prompt)
  readLines(con, n = 1)
}

f <- eval(parse(text = paste("function(x)", ask("f(x) = "))))
x0 <- as.numeric(ask("x0 = "))
accuracy <- as.numeric(ask("Number of decimal places = "))
newton_secant(f, x0, accuracy)
