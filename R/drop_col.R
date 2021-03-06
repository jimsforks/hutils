#' Drop column or columns
#' @name drop_col
#' @param DT A \code{data.table}.
#' @param var Quoted column to drop.
#' @param checkDT Should the function check \code{DT} is a \code{data.table}?
#' @return \code{DT} with specified columns removed.
#' 
#' @examples 
#' if (requireNamespace("data.table", quietly = TRUE)) {
#'   library(data.table)
#'   DT <- data.table(x = 1, y = 2, z = 3)
#'   
#'   drop_col(DT, "x")
#' }
#' 
#' @export drop_col

drop_col <- function(DT, var, checkDT = TRUE) {
  if (checkDT) {
    stopifnot(is.data.table(DT))
  }
  
  if (length(var) != 1L) {
    stop("`var` had length-", length(var), ", but must be length-1. ",
         "Use drop_cols() to drop multiple columns or supply a single string to `var`.")
  }
  
  # Is `var` duplicated? (drop_col is meant to guard against this)
  n_names_var <- sum(names(DT) == var)
  if (n_names_var > 1L) {
    stop("DT had ", n_names_var, " columns named '", var, "', but drop_col() only accepts singular columns. ", 
         "Either use drop_cols() to drop multiple columns or ensure `DT` has distinct column names.")
  }
  
  if (n_names_var) {
    DT[, (var) := NULL]
  }
  
  DT[]
}


#' @param vars Character vector of columns to drop. Only the intersection is dropped; 
#' if any \code{vars} are not in \code{names(DT)}, no warning is emitted.
#' @rdname drop_col
#' @export drop_cols
drop_cols <- function(DT, vars, checkDT = TRUE) {
  if (checkDT) {
    stopifnot(is.data.table(DT))
  }
  
  common_vars <- intersect(vars, names(DT))

  if (length(common_vars) > 0) {
    DT[, (common_vars) := NULL]
  }
  
  DT[]
}

