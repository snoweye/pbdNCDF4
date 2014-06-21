#include <R.h>
#include <Rinternals.h>

int an_empty_fcn(){
  Rprintf("In order to fool R CMD check.\n");
  return(0);
} /* End of an_empty_fcn(). */
