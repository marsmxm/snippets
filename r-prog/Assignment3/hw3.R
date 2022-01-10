library(hash)
library(stringr)
library(reshape2)

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

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    
    ## Check that state and outcome are valid
    if (is.null(outToCol[[outcome]])) {
        stop("invalid outcome")
    }
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    col <- outToCol[[outcome]]
    target_data <- data[, c(2, 7, col)]
    complete_data <- target_data[complete.cases(target_data), ]
    combined <- paste(complete_data[[1]], complete_data[[2]], complete_data[[3]], sep = "---")
    
    ranked <- tapply(combined, complete_data$State, function (x) {
        splitted <- colsplit(x, "---", names=c("hospital", "state", "3"))
        ordered <- splitted[order(splitted[, 3], splitted[, 1]), ]
        
        target_row <- if (num == "best") {
            1
        } else if (num == "worst") {
            length(ordered[, 1])
        } else {
            num
        }
        
        ordered[target_row, 1:2]
    })
    
    as.data.frame(ranked)
}
