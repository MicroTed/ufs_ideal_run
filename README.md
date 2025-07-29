This is an example getting-started run directory for using the ideal "Process Model" (double-periodic) simulation capability of FV3, found at

https://github.com/MicroTed/ufs-weather-model/tree/ideal-periodic (current until merged to UFS release)

Familiarity with running the UFS model is assumed here for the time being.

The input.nml (examples in the namelists directory) is set up for an 80x80 grid with dx=2000m, running 4 MPI threads. The INPUTS directory includes a python script for generating idealized surface data and orography, although real data inputs can be used, as well (but will have periodic lateral boundary conditions).

Field tables for variants of the NSSL and Thompson microphysics are in the table_inputs directory. (link or copy to 'field_table')

Input soundings are the same format as WRF ideal cases (examples in the soundings directory) (link or copy to 'input_sounding')

A couple idealized suites are in the suites directory, and it should be possible to use any full physics suite as long as any needed input files are available. Note that the FV3_ideal_mp_thompson suite is included here in the suites directory, but not in FV3/ccpp/suites.

For the Thompson microphysics, input files can be downloaded with the get_thompson_tables.sh script. 

If you get ESMF errors about 'Invalid argument', then the fd_ufs.yaml file may be out of date. One location for this file is ufs_weather_model/tests/parm

For more details see the readme in FV3/fv3/atmos_cubed_sphere/docs/ideal_processmodel_doc (originally created by Larissa Reames) 

