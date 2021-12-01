complete <- function(directory, id = 1:332) {
    nobs = vector(mode = "integer", length = length(id))
    
    index = 0
    for (monitor in id) {
        index = index + 1
        filename = str_interp("${directory}/$[03d]{monitor}.csv")
        table = read_csv(filename, col_types = "Dddi")
        s_data = table[["sulfate"]]
        n_data = table[["nitrate"]]
        complete_data = s_data + n_data
        nobs[[index]] = length(complete_data[!is.na(complete_data)])
    }
    
    data.frame(id, nobs)
}