\name{nc_var_par_access}
\alias{nc_var_par_access}
\title{Switch between collective and individual parallel access}
\description{
  Switches between the default individual access and collective access for a
  variable in a file that was opened with \code{nc_open_par} or
  \code{nc_create_par}.
}
\usage{
  nc_var_par_access(nc, var, collective = TRUE, verbose = FALSE)
}
\arguments{
  \item{nc}{An object of class \code{ncdf4} (as returned by either function
            \code{nc_open_par} or function
            \code{nc_create_par}),
            indicating what file to read from.}
 \item{var}{Variable name or id.}
 \item{collective}{use collective method to read and write.}
 \item{verbose}{If \code{TRUE}, then messages are printed out during execution
                of this function.}
}
\details{
  Default parallel access is individual for variables. Collective access
  allows coordination between simultaneous requests within a communicator.
}
\value{
  Returns, invisibly, 0 or NetCDF error integer.
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
  \code{nc_open_par}, \code{nc_create_par},
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
