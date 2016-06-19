# Constants
mydir <- "~/programming/R/Misc/DF Matrix/"

myfunction <- function(df1, df2, ...) {
  adjRet1 <- log(df1[1:(nrow(df1) - 1),8] / df1[2:nrow(df1),8])
  adjRet2 <- log(df2[1:(nrow(df2) - 1),8] / df1[2:nrow(df2),8])
  
  cov(adjRet1, adjRet2)
}

## File paths to read in data
filePaths <- list.files(path = mydir, full.names = TRUE)

## Filter down to just the CSV files
csvFiles <- which(grepl(".csv", filePaths))
csvPaths <- filePaths[csvFiles]

## Data labels
fileNames <- list.files(path = mydir, full.names = FALSE)
csvNames <- unlist(strsplit(fileNames[csvFiles], ".csv"))

## Prepare matrix
matrixData <- sapply(csvPaths, function(col) {
  sapply(csvPaths, function(row) {
    df1 <- read.csv(col)
    df2 <- read.csv(row)
    myfunction(df1, df2)
  })
})

## Label
colnames(matrixData) <- csvNames
rownames(matrixData) <- csvNames
