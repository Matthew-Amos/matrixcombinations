# Constants
mydir <- "/Users/mamos/programming/R/Misc/DF Matrix/"

myfunction <- function(df1, df2, ...) {
  adjRet1 <- log(df1[1:(nrow(df1) - 1),8] / df1[2:nrow(df1),8])
  adjRet2 <- log(df2[1:(nrow(df2) - 1),8] / df1[2:nrow(df2),8])
  
  cov(adjRet1, adjRet2)
}


# Algorithm

## File paths to read in data
filePaths <- list.files(path = mydir, full.names = TRUE)

## Filter down to just the CSV files
csvFiles <- which(grepl(".csv", filePaths))
csvPaths <- filePaths[csvFiles]

## Get UNIQUE combinations without repeats
csvCombinations <- combn(csvPaths, 2)

## Get Data
matrixData <- apply(csvCombinations, 2, function(col) {
  df1 <- read.csv(col[1])
  df2 <- read.csv(col[2])
  
  # Return myfunction value
  myfunction(df1, df2)
})

## Data labels
fileNames <- list.files(path = mydir, full.names = FALSE)
csvNames <- unlist(strsplit(fileNames[csvFiles], ".csv"))

## Label and structure matrixData
## Final output is a data.frame() due to varying data types
matrixData <- matrix(matrixData, nrow = length(matrixData))
matrixData <- data.frame(cbind(t(combn(csvNames, 2)), matrixData))
