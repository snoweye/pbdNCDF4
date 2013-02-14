
#include <stdio.h>

#if (NETCDF_INCLUDE & 1) == 0
  #include <netcdf.h>
#else
  #include <netcdf_par.h>
#endif

#include <string.h>
#include <stdlib.h>

#include <Rdefines.h>

/* These same values are hard-coded into the R source. Don't change them! */
#define R_NC_MPIIO       0 
#define R_NC_MPIPOSIX    1
#define R_NC_WRITE       1


/* cmode is 0 for read only, 1 for write access. */
void R_nc4_open_par(char **filename, int *cmode, int *comm, int *info,
		int *ncid, int *retval){
	int nc_mode;
	MPI_Comm nc_comm;  /* MPI_Comm is an int */
	MPI_Info nc_info;  /* MPI_Info is a pointer */

	/* set nc_mode */
	if(*cmode == 0){
		nc_mode = NC_NOWRITE;
	} else if(*cmode == 1){
                nc_mode = NC_WRITE;
	} else{
		Rprintf("Error in R_nc4_open: bad mode passed.\n");
		*retval = -1;
		return;
	}

	/* set nc_comm */
	nc_comm = MPI_Comm_f2c(*comm);

	/* set nc_info */ 
	nc_info = MPI_Info_f2c(*info);

	/* call NetCDF4. */
	*retval = nc_open_par(R_ExpandFileName(filename[0]), NC_MPIIO, nc_comm,
			nc_info, ncid);
	if(*retval != NC_NOERR){
		Rprintf("Error in R_nc4_open_par: %s\n", nc_strerror(*retval));
	}
} /* End of R_nc4_open_par(). */

void R_nc4_create_par(char **filename, int *cmode, int *comm, int *info,
		int *ncid, int *retval){
	int nc_cmode, flag_NC_NOCLOBBER, flag_NC_SHARE, flag_NC_64BIT_OFFSET,
		flag_NC_NETCDF4, flag_NC_MPIIO, flag_NC_MPIPOSIX;
	MPI_Comm nc_comm;  /* MPI_Comm is an int */
	MPI_Info nc_info;  /* MPI_Info is a pointer */

	flag_NC_NOCLOBBER       = 1;
	flag_NC_SHARE           = 2;
	flag_NC_64BIT_OFFSET    = 4;
	flag_NC_NETCDF4         = 8;
        flag_NC_MPIIO           = 16;
        flag_NC_MPIPOSIX        = 32;
	
	/* cmode is passed in our own R bit values, not the actual
	   netcdf file values.  Convert to netcdf values. */
	nc_cmode = 0;
	if(*cmode & flag_NC_NOCLOBBER){
		nc_cmode += NC_NOCLOBBER;
	}
	if(*cmode & flag_NC_SHARE){
		nc_cmode += NC_SHARE;
	}
	if(*cmode & flag_NC_64BIT_OFFSET){
		nc_cmode += NC_64BIT_OFFSET;
	}
	if(*cmode & flag_NC_NETCDF4){
		nc_cmode += NC_NETCDF4;
	}
	if(*cmode & flag_NC_MPIIO){
		nc_cmode += NC_MPIIO;
	}
	if(*cmode & flag_NC_MPIPOSIX){
		nc_cmode += NC_MPIPOSIX;
	}

	/* set nc_comm */
	nc_comm = MPI_Comm_f2c(*comm);

	/* set nc_info */ 
	nc_info = MPI_Info_f2c(*info);

	/* call NetCDF4. */
	*retval = nc_create_par(R_ExpandFileName(filename[0]),
				NC_NETCDF4 | NC_MPIIO,
				nc_comm, nc_info, ncid);
	if(*retval != NC_NOERR){
	    Rprintf("Error in R_nc4_create_par: %s (creation mode was %d)\n", 
			nc_strerror(*retval), nc_cmode);
	}
} /* End of R_nc4_create_par(). */

void R_nc4_var_par_access(int *ncid, int *varid, int *access, int *retval){
	int nc_access, err;

	if(*access == 0){
		nc_access = NC_INDEPENDENT;
	} else if(*access == 1){
		nc_access = NC_COLLECTIVE;
	} else{
		Rprintf("Error in R_nc4_var_par_access: bad mode passed.\n");
		*retval = -1;
		return;
	}

	err = nc_var_par_access(*ncid, *varid, nc_access);

	if(err != NC_NOERR){
		Rprintf("Error in nc_var_par_access call: %s\n", nc_strerror(err));
		*retval = -1;
		return;
    	} else{
	      *retval = 0; 
	      return;
    	}
} /* End of R_nc4_var_par_access(). */

