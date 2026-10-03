# Run it with:
# Rscript legaspi_midterm_lab.R
# or in the R console: source("legaspi_midterm_lab.R") then run_newton_secant().

library(Deriv)

newton_secant <- function(f, x0, accuracy, max_iter = 50) {
  show <- function(i, method, x_old, x_new) {
    cat(sprintf("%4d  %-7s %15.*f %15.*f %15.*f\n", i, method,
                accuracy + 2, x_old, accuracy + 2, x_new, accuracy + 2, f(x_new)))
  }
  diverges <- function(xs) {
    n <- length(xs)
    if (!is.finite(xs[n])) return(TRUE)
    if (n < 4) return(FALSE)
    r <- round(xs[(n - 3):n], accuracy)
    r[1] == r[3] && r[2] == r[4] && r[1] != r[2]
  }

  cat(sprintf("%4s  %-7s %15s %15s %15s\n", "i", "method", "x_old", "x_new", "f(x_new)"))

  d <- Deriv(f, "x")
  x1 <- x0 - (f(x0) / d(x0))
  show(1, "Newton", x0, x1)
  xs <- c(x0, x1)
  if (diverges(xs)) {
    cat("\nThe root diverges.\n")
    return(invisible(NA))
  }
  if (round(x1, accuracy) == round(x0, accuracy)) {
    cat("\nNewton already converged in the first iteration, so the secant method is not needed.\n")
    cat(sprintf("The root is %.*f\n", accuracy, x1))
    return(invisible(x1))
  }

  x2 <- x1 - (f(x1) * (x1 - x0) / (f(x1) - f(x0)))
  show(2, "Secant", x1, x2)
  xs <- c(xs, x2)
  i <- 2
  repeat {
    if (diverges(xs)) break
    if (round(x2, accuracy) == round(x1, accuracy)) {
      cat(sprintf("\nThe root is %.*f\n", accuracy, x2))
      return(invisible(x2))
    }
    if (i >= max_iter) break
    x0 <- x1
    x1 <- x2
    x2 <- x1 - (f(x1) * (x1 - x0) / (f(x1) - f(x0)))
    i <- i + 1
    show(i, "Secant", x1, x2)
    xs <- c(xs, x2)
  }

  cat("\nThe root diverges.\n")
  invisible(NA)
}

# User input

con <- NULL
ask <- function(prompt) {
  if (interactive()) return(trimws(readline(prompt)))   # R / RStudio console inputs
  if (is.null(con)) con <<- file("stdin", open = "r")   # Rscript inputs
  cat(prompt)
  line <- readLines(con, n = 1)
  if (length(line) == 0) stop("No more input.", call. = FALSE)
  trimws(line)
}

ask_number <- function(prompt) {
  repeat {
    x <- suppressWarnings(as.numeric(ask(prompt)))
    if (!is.na(x)) return(x)
    cat("  Not a number. Try again (e.g. 0, 1, 2.5).\n")
  }
}

run_newton_secant <- function() {
  cat("Enter the function f(x) in R syntax, e.g.  x^3 + x - 1\n")
  f <- eval(parse(text = paste("function(x)", ask("f(x) = "))))
  x0 <- ask_number("Initial value x0 = ")
  accuracy <- ask_number("Number of decimal places = ")
  cat("\n")
  invisible(newton_secant(f, x0, accuracy))
}

if (sys.nframe() == 0) run_newton_secant()
