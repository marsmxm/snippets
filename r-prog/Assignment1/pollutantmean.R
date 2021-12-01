library("stringr")
library("readr")

pollutantmean <- function(directory = "specdata", pollutant, id = 1:332) {
    s = 0
    l = 0
    for (monitor in id) {
        filename = str_interp("${directory}/$[03d]{monitor}.csv")
        table = read_csv(filename, col_types = "Dddi")
        data = table[[pollutant]]
        valid_data = data[!is.na(data)]
        s = s + sum(valid_data)
        l = l + length(valid_data)
    }
    
    s / l
}

