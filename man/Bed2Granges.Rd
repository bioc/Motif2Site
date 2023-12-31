% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Motif2Site.R
\name{Bed2Granges}
\alias{Bed2Granges}
\title{Read a bed file as Genomic Ranges}
\usage{
Bed2Granges(fileName)
}
\arguments{
\item{fileName}{A table delimeted file in bed format}
}
\value{
granges format of given coordinates
}
\description{
Read a bed file as Genomic Ranges.
}
\examples{

yeastExampleFile=system.file("extdata", "YeastSampleMotif.bed",
     package="Motif2Site")
ex <- Bed2Granges(yeastExampleFile)
ex

}
