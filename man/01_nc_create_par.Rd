\name{nc_create_par}
\alias{nc_create_par}
\title{Create a parallel NetCDF File}
\description{
  Creates a new parallel NetCDF file on a parallel file system, given
  the variables the new file is to contain.
}
\usage{
  nc_create_par(filename, vars, force_v4 = TRUE, verbose = FALSE,
                comm = 0L, info = 0L)
}
\arguments{
  \item{filename}{Name of the  NetCDF file to be created.}
  \item{vars}{Either an object of class \code{ncvar4} describing the variable
              to be created, or a vector (or list) of such objects to be
              created.}
  \item{force_v4}{If \code{TRUE}, then the created output file will always be
                  in parallel netcdf-4 format which supports more features, but
                  cannot be read by version 3 of the netcdf library.
                  \code{FALSE} is not allowed.}
  \item{verbose}{If \code{TRUE}, then information is printed while the file is
                 being created.}
  \item{comm}{a communicator number from \pkg{pbdMPI}.}
  \item{info}{a info number from \pkg{pbdMPI}.}
}
\details{
  See \code{\link[pbdNCDF4]{nc_create}} for details.
  The parallel version is able to coordinate with other
  \code{nc_create_par} instances
  for more efficient operation in parallel. 
}
\value{
  An object of class \code{ncdf4}, which has the fields described
  in \code{\link[pbdNCDF4]{nc_open}}.
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
  \code{nc_open_par}, \code{nc_var_par_access},
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
