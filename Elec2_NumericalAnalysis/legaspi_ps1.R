# Run it with:
# Rscript error_bounds.R
# or in the R console: source("legaspi_ps1.R") then run_error_bounds().

error_bounds <- function(formula, values, errors) {
  values <- as.list(values)
  errors <- as.list(errors)

  actual <- do.call(formula, values)

  partial <- function(name) {
    x <- values[[name]]
    step <- max(abs(x), 1) * .Machine$double.eps^(1 / 3)
    hi <- values; hi[[name]] <- x + step
    lo <- values; lo[[name]] <- x - step
    (do.call(formula, hi) - do.call(formula, lo)) / (2 * step)
  }

  error <- sum(sapply(names(values), function(n) abs(partial(n)) * errors[[n]]))

  list(actual = actual, error = error)
}

# --- User Input for formula and values of variables -----------

con <- NULL
ask <- function(prompt) {
  if (interactive()) return(trimws(readline(prompt)))   # R / RStudio console inputs
  if (is.null(con)) con <<- file("stdin", open = "r")   # Rscript inputs
  cat(prompt)
  line <- readLines(con, n = 1)
  if (length(line) == 0) stop("No more input.", call. = FALSE)
  trimws(line)
}

# Normalization and Input validation
as_number <- function(text) {
  text <- gsub("[ ,]", "", text)
  text <- gsub("[xX\u00d7\u2715]10\\^", "e", text)   # 6.43 x 10^-5 -> 6.43e-5
  text <- gsub("\\*10\\^", "e", text)               # 6.43 * 10^-5 -> 6.43e-5
  suppressWarnings(as.numeric(text))
}

ask_number <- function(prompt) {
  repeat {
    x <- as_number(ask(prompt))
    if (!is.na(x)) return(x)
    cat("  Not a number. Try again (e.g. 0.004, 1.5e9, 7 x 10^10).\n")
  }
}

# User choice: Significant digits for the printout. Blank keeps the default of 7.
ask_digits <- function(default = 7) {
  repeat {
    text <- ask(sprintf("\nSignificant digits [%d]: ", default))
    if (text == "") return(default)
    d <- suppressWarnings(as.integer(text))
    if (!is.na(d) && d >= 1 && d <= 15) return(d)
    cat("  Give a whole number from 1 to 15.\n")
  }
}

# User Choice: Exponent form of the printout. Blank keeps scientific.
ask_form <- function() {
  repeat {
    text <- ask("Exponent form - 1 = scientific (6.4 x 10^-5), 2 = engineering (64 x 10^-6) [1]: ")
    if (text %in% c("", "1")) return("scientific")
    if (text == "2") return("engineering")
    cat("  Type 1 or 2.\n")
  }
}

run_error_bounds <- function() {
  cat("Enter the formula in R syntax, e.g.  F/(h^2*E)\n")
  expr <- parse(text = ask("Formula: "))[[1]]

  vars <- all.vars(expr)
  # drop names that are already known constants, e.g. pi
  vars <- vars[!sapply(vars, function(v) exists(v, mode = "numeric"))]
  formula <- as.function(c(setNames(rep(list(quote(expr = )), length(vars)), vars),
                           list(expr)))

  cat("\nVariables found:", paste(vars, collapse = ", "), "\n\n")

  values <- list()
  errors <- list()
  for (v in vars) {
    values[[v]] <- ask_number(sprintf("%s_actual = ", v))
    errors[[v]] <- ask_number(sprintf("%s_error  = ", v))
  }

  digits <- ask_digits()
  form <- ask_form()

  res <- error_bounds(formula, values, errors)

  fmt <- paste0("%.", digits - 1, "e")
  plain <- function(x) sprintf(fmt, x)

  # Logic for user choice, sci or exp: scientific: one digit before the point || engineering: exponent is a multiple of 3
  sci <- function(x) {
    if (x == 0) return("0")
    e <- floor(log10(abs(x)))
    if (form == "engineering") e <- 3 * floor(e / 3)
    m <- x / 10^e
    left <- max(1, floor(log10(abs(m))) + 1)
    sprintf("%.*f x 10^%d", max(0, digits - left), m, e)
  }

  cat("\nOutput:\n")
  cat(sprintf("  actual      = %s   =  %s\n", plain(res$actual), sci(res$actual)))
  cat(sprintf("  error       = %s   =  %s\n", plain(res$error),  sci(res$error)))
  cat(sprintf("  error range = [%s, %s]\n",
              sci(res$actual - res$error), sci(res$actual + res$error)))

  invisible(res)
}

if (sys.nframe() == 0) run_error_bounds()
