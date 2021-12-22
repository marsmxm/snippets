library(hash)
library(stringr)

data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
data_split_by_state <- split(data, data$State)

outToCol <- hash()
outToCol[["heart attack"]] <- 11
outToCol[["heart failure"]] <- 17
outToCol[["pneumonia"]] <- 23

best <- function(state, outcome) {
    if (is.null(outToCol[[outcome]])) {
        stop("invalid outcome")
    }
    
    col <- outToCol[[outcome]]
    state_data <- data_split_by_state[[state]]
    minRowNum <- which.min(state_data[, col])
    state_data$Hospital.Name[[minRowNum]]
}