library("stringr")
library("readr")


corr <- function(directory, threshold = 0) {
    cors <- rep(NA, 332)
    for (monitor in 1:332) {
        print(paste("Processing: ", monitor, sep = ""))
        filename <- str_interp("${directory}/$[03d]{monitor}.csv")
        table <- read_csv(filename, col_types = "Dddi")
        s_data <- table[["sulfate"]]
        n_data <- table[["nitrate"]]
        sc <- s_data[!is.na(s_data) & !is.na(n_data)]
        nc <- n_data[!is.na(s_data) & !is.na(n_data)]
        s_n_cor <- cor(sc, nc)
        if (!is.na(s_n_cor) & s_n_cor > threshold) {
            cors[[monitor]] <- s_n_cor
        }
    }
    
    cors[!is.na(cors)]
}