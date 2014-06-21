\name{ncdump}
\alias{ncdump}
\title{Shell Command of ncdump}
\description{
  Call \code{ncdump} and print the results.
}
\usage{
  ncdump(filename, args = "-h")
}
\arguments{
  \item{filename}{Name of the  NetCDF file to be created.}
  \item{args}{as the options in the shell command of \code{ncdump}.}
}
\value{
  Messages of details of the NetCDF file will be printed.
}
\references{
  Programming with Big Data in R Website:
  \url{http://r-pbd.org/}
}
\author{
  George Ostrouchov, Pragneshkumar Patel \email{pragnesh@utk.edu},
  Wei-Chen Chen, and Drew Schmidt.
}
\seealso{ 
  \code{nc_create_par},
  \code{nc_open_par},
  \code{nc_var_par_access}.
}
\examples{
\dontrun{
### Under command mode, run the demo with 2 processors by
### (Use Rscript.exe for windows system)
mpiexec -np 2 Rscript -e "demo(ncwrite,'pbdNCDF4',ask=F,echo=F)"
mpiexec -np 2 Rscript -e "ncdump('test_par.nc')"
}
}
\keyword{programming}
