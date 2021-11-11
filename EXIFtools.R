# parses Olympus EXIF files and reports temperature in Celsius format
# Assumption: SensorTemperature fields need to be added and are in Fahrenheit.

# Requires EXIF tools to be installed
require(exifr)

# gets sensor temp for all files in dir
getSensorTemp <- function(inDir) {
	x <- read_exif(dir(pattern="*ORF"))
	y <- lapply(strsplit(x$SensorTemperature, " "),
		function(z) {w <- as.integer(z); w[1]+w[2]})
	z <- (unlist(y)-32)*(5/9)  # convert F to C
}


# writes in same dir as input
# output file is .txt suffix added to inFile, written to the "EXIF" directory created in the same directory as inFile
writeEXIFToFile <- function(inFile) {
	x <- read_exif(inFile)
	x <- as.data.frame(x)
	outDir <- paste(dirname(x),"EXIF",sep="/")
	outFile <- paste(outDir,sprintf("%s.txt",basename(inFile)),sep="/")
	x <- t(x)
	write.table(x,file=outFile,sep="\t",col=T,row=F,quote=F)
}
