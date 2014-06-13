### Lastest load into a package.

### Export Namespace does not use .First.lib() and .Last.lib(), but use
### .onLoad() and .onUnload().
# .First.lib <- function(lib, pkg){
# } # End of .First.lib().

# .Last.lib <- function(libpath){
# } # End of .Last.lib().

.onLoad <- function(libname, pkgname){
  ### Check environment variables first, check Makeconf second.
  netcdf4.root.32 <- Sys.getenv("NETCDF4_ROOT_32")
  netcdf4.root.64 <- Sys.getenv("NETCDF4_ROOT_64")

  if(netcdf4.root.32 != "" && .Platform$r_arch == "i386"){
    netcdf4.root <- netcdf4.root.32
    netcdf4.arch <- "w32"
  } else if(netcdf4.root.64 != "" && .Platform$r_arch == "x64"){
    netcdf4.root <- netcdf4.root.64
    netcdf4.arch <- "x64"
  } else{
    ### Modify from "../get.conf.r"
    file.name <- paste("./etc/", .Platform$r_arch, "/Makeconf", sep = "")
    file.path <- tools::file_path_as_absolute(
                   system.file(file.name, package = "pbdNCDF4"))
    ret <- scan(file.path, what = character(), sep = "\n", quiet = TRUE)

    ### Get NETCDF4_ROOT
    arg <- "NETCDF4_ROOT"
    id <- grep(paste("^", arg, " = ", sep = ""), ret)
    netcdf4.root <- gsub(paste("^", arg, " = (.*)", sep = ""),
                         "\\1", ret[id[1]])

    ### Get NETCDF4_ARCH.
    arg <- "NETCDF4_ARCH"
    id <- grep(paste("^", arg, " = ", sep = ""), ret)
    netcdf4.arch <- gsub(paste("^", arg, " = (.*)", sep = ""),
                         "\\1", ret[id[1]])
  }

  ### Add PATH and set NETCDF4_BIN to environment.
  netcdf4.root <- gsub("\\\\", "/", netcdf4.root)
  netcdf4.bin <- paste(netcdf4.root, "bin/", sep = "")
  netcdf4.deps <- paste(netcdf4.root, "deps/", netcdf4.arch, "/bin/", sep = "")
  path <- paste(netcdf4.bin, netcdf4.deps, Sys.getenv("PATH"), sep = ";")

  ### Add dll files
  netcdf4.msvcp100 <- paste(netcdf4.deps, "msvcp100.dll", sep = "")
  netcdf4.msvcr100 <- paste(netcdf4.deps, "msvcr100.dll", sep = "")
  netcdf4.zlib <- paste(netcdf4.deps, "zlib.dll", sep = "")
  netcdf4.hdf5 <- paste(netcdf4.deps, "hdf5.dll", sep = "")
  netcdf4.hdf5_hl <- paste(netcdf4.deps, "hdf5_hl.dll", sep = "")
  netcdf4.netcdf <- paste(netcdf4.bin, "netcdf.dll", sep = "")

  ### Check if netcdf4.root and dll files exist.
  flag <- TRUE
  if(!file.exists(netcdf4.root)){
    cat("Not exits: ", netcdf4.root, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.bin)){
    cat("Not exits: ", netcdf4.bin, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.deps)){
    cat("Not exits: ", netcdf4.deps, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.msvcp100)){
    cat("Not exits: ", netcdf4.msvcp100, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.msvcr100)){
    cat("Not exits: ", netcdf4.msvcr100, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.zlib)){
    cat("Not exits: ", netcdf4.zlib, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.hdf5)){
    cat("Not exits: ", netcdf4.hdf5, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.hdf5_hl)){
    cat("Not exits: ", netcdf4.hdf5_hl, "\n", sep = "")
    flag <- FALSE
  }
  if(!file.exists(netcdf4.netcdf)){
    cat("Not exits: ", netcdf4.netcdf, "\n", sep = "")
    flag <- FALSE
  }

  ### Set environment variables and load all dll files and package dll.
  if(flag){
    Sys.setenv(PATH = path)
    Sys.setenv(NETCDF4_BIN = netcdf4.bin)
    Sys.setenv(NETCDF4_DEPS = netcdf4.deps)
    Sys.setenv(NETCDF4_MSVCP100 = netcdf4.msvcp100)
    Sys.setenv(NETCDF4_MSVCR100 = netcdf4.msvcr100)
    Sys.setenv(NETCDF4_ZLIB = netcdf4.zlib)
    Sys.setenv(NETCDF4_HDF5 = netcdf4.hdf5)
    Sys.setenv(NETCDF4_HDF5_HL = netcdf4.hdf5_hl)
    Sys.setenv(NETCDF4_NETCDF = netcdf4.netcdf)
    Sys.setenv(NETCDF4_pbdNCDF4 = "TRUE")

    ### Load related dll files.
    dyn.load(netcdf4.msvcp100)
    dyn.load(netcdf4.msvcr100)
    dyn.load(netcdf4.zlib)
    dyn.load(netcdf4.hdf5)
    dyn.load(netcdf4.hdf5_hl)
    dyn.load(netcdf4.netcdf)

    ### Load "pbdNCDF4.dll".
    library.dynam("pbdNCDF4", pkgname, libname)
  } else{
    cat("\n===== WARNING =====\n")
    cat("- netCDF 4.3.2 may not install correctly.\n")
    cat("- pbdNCDF4 binary does not build with netCDF.\n")
    cat("- Environment variables may not set originally.\n")
    cat("- Please consider to rebuild from source.\n")
    cat("===================\n\n")
  }

  invisible()
} # End of .onLoad().

.onUnload <- function(libpath){
  ### Get NETCDF4 from environment.
  netcdf4.msvcp100 <- Sys.getenv("NETCDF4_MSVCP100")
  netcdf4.msvcr100 <- Sys.getenv("NETCDF4_MSVCR100")
  netcdf4.zlib <- Sys.getenv("NETCDF4_ZLIB")
  netcdf4.hdf5 <- Sys.getenv("NETCDF4_HDF5")
  netcdf4.hdf5_hl <- Sys.getenv("NETCDF4_HDF5_HL")
  netcdf4.netcdf <- Sys.getenv("NETCDF4_NETCDF")
  netcdf4.pbdncdf4 <- Sys.getenv("NETCDF4_pbdNCDF4")

  if(netcdf4.pbdncdf4 == TRUE){
    ### Unload "pbdNCDF4.dll".
    library.dynam.unload("pbdNCDF4", libpath)
    dyn.unload(netcdf4.netcdf)
    dyn.unload(netcdf4.hdf5_hl)
    dyn.unload(netcdf4.hdf5)
    dyn.unload(netcdf4.zlib)
    dyn.unload(netcdf4.msvcr100)
    dyn.unload(netcdf4.msvcp100)
  }

  invisible()
} # End of .onUnload().
