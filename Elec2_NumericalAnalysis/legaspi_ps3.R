# Run it with:
# Rscript legaspi_ps3.R
# or in the R console: source("legaspi_ps3.R") then run_fixed_point().

fixed_point <- function(g, x0, tol = 1e-10, max_iter = 100) {
  x <- x0
  for (i in seq_len(max_iter)) {
    x_new <- g(x)
    if (!is.finite(x_new) || abs(x_new) > 1e10) break
    if (abs(x_new - x) < tol) return(list(root = x_new, converged = TRUE, iter = i))
    x <- x_new
  }
  list(root = NA, converged = FALSE, iter = max_iter)
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

run_fixed_point <- function() {
  cat("Enter the modified function g(x) in R syntax, e.g.  (1 - x)^(1/3)\n")
  expr <- parse(text = ask("g(x) = "))[[1]]
  g <- function(x) eval(expr, list(x = x))

  x0 <- ask_number("Initial value x0 = ")

  res <- fixed_point(g, x0)

  if (!res$converged) {
    cat("\nthe roots diverges\n")
  } else {
    cat("\nThe root converges.\n")
    cat(sprintf("The root is approximately %.4f\n", res$root))
  }
  invisible(res)
}

if (sys.nframe() == 0) run_fixed_point()
