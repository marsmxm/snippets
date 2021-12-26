library(hash)
library(stringr)

data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
data[, 11] <- as.numeric(data[, 11])
data[, 17] <- as.numeric(data[, 17])
data[, 23] <- as.numeric(data[, 23])
all_stats = unique(data$State)
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

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    if (is.null(outToCol[[outcome]])) {
        stop("invalid outcome")
    }
    if (!(state %in% all_stats)) {
        stop("invalid state")
    }
    
    col <- outToCol[[outcome]]
    state_data <- data_split_by_state[[state]][, c(2, col)]
    
    row_num <- length(state_data[, 1])
    if (is.numeric(num) && num > row_num) {
        return(NA)
    }
    
    state_data <- state_data[complete.cases(state_data), ]
    ordered_state_data <- state_data[order(state_data[, 2], state_data[, 1]), ]

    target_row <- if (num == "best") {
        1
    } else if (num == "worst") {
        length(ordered_state_data[, 1])
    } else {
        num
    }
    
    ordered_state_data[target_row, 1]
}
