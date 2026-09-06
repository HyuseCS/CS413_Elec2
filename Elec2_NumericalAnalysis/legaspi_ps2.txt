# Run it with:
# Rscript legaspi_ps2.R
# or in the R console: source("legaspi_ps2.R") then run_bisection().

bisection <- function(f, a, b, n) {
  for (i in seq_len(n)) {
    c <- (a + b) / 2
    if (f(a) * f(c) <= 0) b <- c else a <- c
  }
  (a + b) / 2
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

run_bisection <- function() {
  cat("Enter the function in R syntax, e.g.  x^3 + x - 1\n")
  expr <- parse(text = ask("f(x) = "))[[1]]
  f <- function(x) eval(expr, list(x = x))

  a <- ask_number("Interval start a = ")
  b <- ask_number("Interval end   b = ")
  if (a > b) { t <- a; a <- b; b <- t }

  # root checker using the theorem
  if (f(a) * f(b) > 0) {
    cat("\na root can not be found in the interval given\n")
    return(invisible(NULL))
  }

  repeat {
    n <- suppressWarnings(as.integer(ask("Iterations: ")))
    if (!is.na(n) && n >= 1) break
    cat("  Give a whole number of 1 or more.\n")
  }

  root <- bisection(f, a, b, n)
  cat(sprintf("\nThe root is approximately %.4f\n", root))
  invisible(root)
}

if (sys.nframe() == 0) run_bisection()
