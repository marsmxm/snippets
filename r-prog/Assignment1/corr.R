library("stringr")
library("readr")
source("complete.R")

corr <- function(directory, threshold = 0) {
    c_data <- complete("specdata")
    ids <- c_data$id[c_data$nobs > threshold]
    cors <- rep(NA, length(ids))
    
    index <- 0
    for (monitor in ids) {
        index <- index + 1
        # print(paste("Processing: ", monitor, sep = ""))
        filename <- str_interp("${directory}/$[03d]{monitor}.csv")
        table <- read_csv(filename, col_types = "Dddi")
        s_data <- table[["sulfate"]]
        n_data <- table[["nitrate"]]
        sc <- s_data[!is.na(s_data) & !is.na(n_data)]
        nc <- n_data[!is.na(s_data) & !is.na(n_data)]
        cors[[index]] <- cor(sc, nc)
    }
    
    cors
}