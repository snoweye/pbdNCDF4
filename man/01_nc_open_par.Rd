\name{nc_open_par}
\alias{nc_open_par}
\title{Open a parallel NetCDF File}
\description{
  Opens an existing NetCDF file for reading (or, optionally, writing) in
  parallel.
}
\usage{
  nc_open_par(filename, write = FALSE, readunlim = TRUE,
              verbose = FALSE, comm = 0L, info = 0L)
}
\arguments{
  \item{filename}{Name of the existing NetCDF file to be opened.}
  \item{write}{If FALSE (default), then the file is opened read-only.
               If TRUE, then writing to the file is allowed.}
  \item{readunlim}{When invoked, this function reads in the values of all
                   dimensions from the associated variables. This can be
                   slow for a large file with a long unlimited dimension.
                   If set to FALSE, the values for the unlimited dimension
                   are not automatically read in (they can be read in later,
                   manually, using \code{\link[pbdNCDF4]{ncvar_get}}).}
  \item{verbose}{If TRUE, then messages are printed out during execution of
                 this function.}
  \item{comm}{a communicator number from \pkg{pbdMPI}.}
  \item{info}{a info number from \pkg{pbdMPI}.}
}
\details{
  See \code{\link[pbdNCDF4]{nc_open}} details. The parallel version
  is able to coordinate with other \code{nc_open_par}
  instances for more efficient operation in parallel. 
}
\value{
  An object of class \code{ncdf4} that has the fields described above.
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
  \code{nc_create_par}, \code{nc_var_par_access},
  \code{\link[pbdNCDF4]{ncdim_def}}, \code{\link[pbdNCDF4]{ncvar_def}}. 
}
\examples{
\dontrun{
### Under command mode, run the demo with 2 processors by
### (Use Rscript.exe for windows system)
mpiexec -np 2 Rscript -e "demo(ncwrite,'pbdNCDF4',ask=F,echo=F)"
mpiexec -np 2 Rscript -e "demo(ncread,'pbdNCDF4',ask=F,echo=F)"
}
}
\keyword{programming}
