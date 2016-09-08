# pbdNCDF4

* **Version:** 0.1-5
* **License:** [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-orange.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html) 
* **Author:** See section below.

pbdNCDF4 is a parallel version of ncdf4 package.  It offers an interface to parallel Unidata NetCDF4 format data files.



## Usage

TODO



## Installation

pbdNCDF4 requires
* R version 2.14.0 or higher with pbdMPI.
* (Parallel) HDF5 library.
* (Parallel) NetCDF4 library.
* A system installation of MPI:
  - SUN HPC 8.2.1 (OpenMPI) for Solaris.
  - OpenMPI for Linux.
  - OpenMPI for Mac OS X.


The stable CRAN version can be installed via:

```r
install.package("pbdNCDF4")
```

The development version is maintained on GitHub, and can easily be installed by any of the packages that offer installations from GitHub:

```r
### Pick your preference
devtools::install_github("RBigData/pbdNCDF4")
ghit::install_github("RBigData/pbdNCDF4")
remotes::install_github("RBigData/pbdNCDF4")
```

For additional installation information, see the package vignette and/or:

* `INSTALL` for Solaris, Linux and Mac OS
* `INSTALL.win.*` for Windows




## Authors

pbdNCDF4 is authored and maintained by the pbdR core team:
* Pragneshkumar Patel
* George Ostrouchov
* Wei-Chen Chen
* Drew Schmidt

In collaboration  with:
* David Pierce

