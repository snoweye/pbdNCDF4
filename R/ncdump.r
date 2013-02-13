ncdump <- function(filename, args = "-h"){
  if(comm.rank() == 0){
    cmd <- paste("ncdump", args, filename, sep = " ")
    system(cmd)
  }
}
