### Lastest load into a package.

### Export Namespace does not use .First.lib() and .Last.lib(), but use
### .onLoad() and .onUnload().
# .First.lib <- function(lib, pkg){
# } # End of .First.lib().

# .Last.lib <- function(libpath){
# } # End of .Last.lib().

.onLoad <- function(libname, pkgname){
  ### Modify from "../get.conf.r"
  file.name <- paste("./etc/", .Platform$r_arch, "/Makeconf", sep = "")
  file.path <- tools::file_path_as_absolute(
                 system.file(file.name, package = "pbdNCDF4"))
  ret <- scan(file.path, what = character(), sep = "\n", quiet = TRUE)

  ### Get NETCDF4_ROOT
  arg <- "NETCDF4_ROOT"
  id <- grep(paste("^", arg, " = ", sep = ""), ret)
  netcdf4.root <- gsub(paste("^", arg, " = (.*)", sep = ""), "\\1", ret[id[1]])

  ### Get NETCDF4_ARCH.
  arg <- "NETCDF4_ARCH"
  id <- grep(paste("^", arg, " = ", sep = ""), ret)
  netcdf4.arch <- gsub(paste("^", arg, " = (.*)", sep = ""), "\\1", ret[id[1]])

  ### Add PATH and set NETCDF4_BIN to environment.
  netcdf4.bin <- paste(netcdf4.root, "bin/", sep = "")
  netcdf4.deps <- paste(netcdf4.root, "deps/", netcdf4.arch, "/bin/", sep = "")
  path <- paste(netcdf4.bin, netcdf4.deps, Sys.getenv("PATH"), sep = ";")
  Sys.setenv(PATH = path)
  Sys.setenv(NETCDF4_BIN = netcdf4.bin)
  Sys.setenv(NETCDF4_DEPS = netcdf4.deps)

  ### Load related dll files.
  dyn.load(paste(netcdf4.deps, "msvcp100.dll", sep = ""))
  dyn.load(paste(netcdf4.deps, "msvcr100.dll", sep = ""))
  dyn.load(paste(netcdf4.deps, "zlib.dll", sep = ""))
  dyn.load(paste(netcdf4.deps, "hdf5.dll", sep = ""))
  dyn.load(paste(netcdf4.deps, "hdf5_hl.dll", sep = ""))
  dyn.load(paste(netcdf4.bin, "netcdf.dll", sep = ""))

  ### Load "pbdNCDF4.dll".
  library.dynam("pbdNCDF4", pkgname, libname)
  invisible()
} # End of .onLoad().

.onUnload <- function(libpath){
  ### Unload "pbdNCDF4.dll".
  library.dynam.unload("pbdNCDF4", libpath)

  ### Get NETCDF4_BIN from environment.
  netcdf4.bin <- Sys.getenv("NETCDF4_BIN")
  netcdf4.deps <- Sys.getenv("NETCDF4_DEPS")

  ### Unload related dll files.
  dyn.unload(paste(netcdf4.bin, "netcdf.dll", sep = ""))
  dyn.unload(paste(netcdf4.deps, "hdf5_hl.dll", sep = ""))
  dyn.unload(paste(netcdf4.deps, "hdf5.dll", sep = ""))
  dyn.unload(paste(netcdf4.deps, "zlib.dll", sep = ""))
  dyn.unload(paste(netcdf4.deps, "msvcr100.dll", sep = ""))
  dyn.unload(paste(netcdf4.deps, "msvcp100.dll", sep = ""))

  invisible()
} # End of .onUnload().

