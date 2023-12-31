% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Motif2Site.R
\name{pairwisDifferential}
\alias{pairwisDifferential}
\title{Detect differential motifs}
\usage{
pairwisDifferential(
  tableOfCountsDir = "",
  exp1,
  exp2,
  FDRcutoff = 0.05,
  logFCcuttoff = 1
)
}
\arguments{
\item{tableOfCountsDir}{Directory which conatins the combined motifs and
ChIP-seq count file}

\item{exp1}{Experiment name which will be compared in pairwise comparison}

\item{exp2}{Experiment name which will be compared in pairwise comparison}

\item{FDRcutoff}{FDR cutoff applies on pvalue distribution}

\item{logFCcuttoff}{log fold change cutoff}
}
\value{
A list of differential motifs, motif1 and motif2 as well as a table
 of total motifs and log fold changes
}
\description{
Take combined matrix of motif counts generated by
 \code{\link{recenterBindingSitesAcrossExperiments}}, and experiment names.
 It detect differential motifs using edgeR TMM nomralizaiton with Generalized
  linear model
}
\examples{

# FUR candidate motifs in NC_000913 E. coli
FurMotifs=system.file("extdata", "FurMotifs.bed", package="Motif2Site")

# ChIP-seq datasets fe in bed single end format
IPFe <- c(system.file("extdata", "FUR_fe1.bed", package="Motif2Site"),
        system.file("extdata", "FUR_fe2.bed", package="Motif2Site"))
Inputs <- c(system.file("extdata", "Input1.bed", package="Motif2Site"),
            system.file("extdata", "Input2.bed", package="Motif2Site"))
FURfeBedInputStats <- 
  DetectBindingSitesBed(BedFile=FurMotifs,
   IPfiles=IPFe, 
   BackgroundFiles=Inputs, 
   genome="Ecoli",
   genomeBuild="20080805",
   DB="NCBI",
   expName="FUR_Fe_BedInput",
   format="BEDSE"
   )

# ChIP-seq datasets dpd in bed single end format
IPDpd <- c(system.file("extdata", "FUR_dpd1.bed", package="Motif2Site"),
        system.file("extdata", "FUR_dpd2.bed", package="Motif2Site"))
FURdpdBedInputStats <- 
  DetectBindingSitesBed(BedFile=FurMotifs,
   IPfiles=IPDpd, 
   BackgroundFiles=Inputs, 
   genome="Ecoli",
   genomeBuild="20080805",
   DB="NCBI",
   expName="FUR_Dpd_BedInput",
   format="BEDSE"
   )
                       

# Combine all FUR binding sites into one table
corMAT <- recenterBindingSitesAcrossExperiments(
  expLocations=c("FUR_Fe_BedInput","FUR_Dpd_BedInput"),
  experimentNames=c("FUR_Fe","FUR_Dpd"),
  expName="combinedFUR",
  )

# Differential binding sites across FUR conditions fe vs dpd
diffFUR <- pairwisDifferential(tableOfCountsDir="combinedFUR",
   exp1="FUR_Fe",
   exp2="FUR_Dpd",
   FDRcutoff=0.05,
   logFCcuttoff=1
   )

FeUp <- diffFUR[[1]]
DpdUp <- diffFUR[[2]]
TotalComparison <- diffFUR[[3]]
head(TotalComparison)

}
\seealso{
\code{\link{recenterBindingSitesAcrossExperiments}}
}
