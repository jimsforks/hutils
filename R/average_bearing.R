#' Average of bearings
#' @param theta1,theta2 Bearings, expressed in degrees.
#' @param thetas A vector of bearings.
#' @param average_of_opposite The average of opposing bearings (e.g. average of north
#' and south) is not well-defined. If \code{NULL}, the result for opposing vectors is 
#' undefined; if \code{"right"}, returns 
#' \code{theta1 + 90}; if \code{"left"} then \code{theta2 + 90}. Can also be 
#' a single numeric to provide a specific value when the vectors point in opposite 
#' directions.
#' 
#' @return For `average_bearing`, the bearing bisecting the two bearings.
#' 
#' For `average_bearing_n`, the average bearing of the bearing.
#' 
#' @examples
#' average_bearing(0, 90)
#' average_bearing(0, 270)
#' average_bearing(90, 180)
#' 
#' average_bearing(0, 180)
#' average_bearing(0, 180, average_of_opposite = 3)
#' average_bearing(0, 180, average_of_opposite = "left")
#' 
#' average_bearing_n(1:179)
#' 
#' @export average_bearing average_bearing_n
#' 

average_bearing <- function(theta1, theta2, average_of_opposite = NULL) {
  Sin <- function(x) sinpi(x / 180)
  Cos <- function(x) cospi(x / 180)
  
  o <- atan2(Sin(theta1) + Sin(theta2),
             Cos(theta1) + Cos(theta2)) * 180 / pi
  o <- o %% 360
  if (!is.null(average_of_opposite)) {
    are_opp <- abs((theta1 - theta2) %% 180) < .Machine$double.eps
    if (is.numeric(average_of_opposite)) {
      o[are_opp] <- average_of_opposite
    } else {
      if (average_of_opposite == "right") {
        o[are_opp] <- {theta1 + 90} %% 360
      }
      if (average_of_opposite == "left") {
        o[are_opp] <- {theta2 + 90} %% 360
      }
    }
  }
  o
}

#' @rdname average_bearing
average_bearing_n <- function(thetas) {
  Sin <- function(x) sinpi(x / 180)
  Cos <- function(x) cospi(x / 180)
  
  {atan2(sum(Sin(thetas)), sum(Cos(thetas))) * 180 / pi} %% 360
}

