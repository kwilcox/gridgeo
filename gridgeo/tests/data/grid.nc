CDF                  )   file      Output/ocean_NYB05_his_0016.nc     format        netCDF-3 64bit offset file     Conventions       CF-1.6, SGRID-0.1, ACDD-1.3    type      ROMS/TOMS history file     title         7USGS-CMG-COAWST Model: Hurricane Sandy, NYB05 700m Nest    rst_file      Output/ocean_NYB05_rst.nc      his_base      Output/ocean_NYB05_his     grd_file      ../grids/NYB_700m_05.nc    ini_file      Output/ocean_NYB05_his_0009.nc     frc_file_01       S../forcings/roms_namnarr_2030Oct2012.nc, ../forcings/roms_namnarr_30Oct10Nov2012.nc    clm_file_01       0../forcings/merged_coawst_clm_10Sep_29Dec2012.nc   script_file              NLM_LBC      -
EDGE:         WEST   SOUTH  EAST   NORTH  
zeta:         Nes    Nes    Nes    Nes    
ubar:         Nes    Nes    Nes    Nes    
vbar:         Nes    Nes    Nes    Nes    
u:            Nes    Nes    Nes    Nes    
v:            Nes    Nes    Nes    Nes    
temp:         Nes    Nes    Nes    Nes    
salt:         Nes    Nes    Nes    Nes    
sand_01:      Nes    Nes    Nes    Nes    
sand_02:      Nes    Nes    Nes    Nes    
sand_03:      Nes    Nes    Nes    Nes    
sand_04:      Nes    Nes    Nes    Nes    
sand_05:      Nes    Nes    Nes    Nes    
sand_06:      Nes    Nes    Nes    Nes    
tke:          Nes    Nes    Nes    Nes    
ubar_stokes:  Nes    Nes    Nes    Nes    
vbar_stokes:  Nes    Nes    Nes    Nes    
u_stokes:     Nes    Nes    Nes    Nes    
v_stokes:     Nes    Nes    Nes    Nes      svn_url       https:://myroms.org/svn/src    svn_rev       exported   code_dir      #/raid3/jcwarner/Projects/Sandy/sim6    
header_dir        7/raid3/jcwarner/Projects/Sandy/sim6/Projects/FireIsland    header_file       fireisland.h   os        Linux      cpu       x86_64     compiler_system       pgi    compiler_command      /usr/local/mpi/bin/mpif90      compiler_flags        % -fastsse -Mipa=fast -tp k8-64 -Mfree      tiling        008x005    history      Fri Oct 23 08:01:10 2015: ncks -F --dimension ocean_time,1 --variable grid http://geoport.whoi.edu/thredds/dodsC/clay/usgs/users/jcwarner/Projects/Sandy/triple_nest/00_dir_NYB05.ncml grid.nc --overwrite
ROMS/TOMS, Version 3.7, Tuesday - June 2, 2015 - 10:15:23 PM    ana_file      �ROMS/Functionals/ana_btflux.h, ROMS/Functionals/ana_fsobc.h, ROMS/Functionals/ana_m2obc.h, ROMS/Functionals/ana_nudgcoef.h, ROMS/Functionals/ana_srflux.h, ROMS/Functionals/ana_stflux.h   CPP_options      �FIREISLAND, ANA_BPFLUX, ANA_BSFLUX, ANA_BTFLUX, ANA_FSOBC, ANA_M2OBC, ANA_NUDGCOEF, ANA_SPFLUX, ANA_SRFLUX, ASSUMED_SHAPE, ATM_PRESS, BEDLOAD_SOULSBY, BULK_FLUXES, CHARNOK, CRAIG_BANNER, COARE_TAYLOR_YELLAND, CURVGRID, DJ_GRADPS, DOUBLE_PRECISION, EMINUSP, GLS_MIXING, KANTHA_CLAYSON, MASKING, MCT_LIB, MIX_GEO_TS, MIX_S_UV, MPI, WEC_VF, WDISS_WAVEMOD, NESTING, NONLINEAR, NONLIN_EOS, NO_LBC_ATT, N2S2_HORAVG, !ONE_WAY, POWER_LAW, PROFILE, K_GSCHEME, !RST_SINGLE, SALINITY, SEDIMENT, SUSPLOAD, NONCOHESIVE_BED1, SOLAR_SOURCE, SOLVE3D, SPLINES, SSH_TIDES, SSW_BBL, SSW_CALC_ZNOT, SWAN_COUPLING, TS_U3HADVECTION, TS_C4VADVECTION, TS_DIF2, UV_ADV, UV_COR, UV_U3HADVECTION, UV_C4VADVECTION, UV_KIRBY, UV_TIDES, UV_VIS2, VAR_RHO_2D, WAVES_OCEAN, WET_DRY   cdm_data_type         Grid   publisher_email       jcwarner@usgs.gov      publisher_url         0http://woodshole.er.usgs.gov/staffpages/jwarner/   publisher_name        John Warner    license      �The data may be used and redistributed for free but is not intended for legal use, since it may contain inaccuracies. Neither the data Contributor, nor the United States Government, nor any of their employees or contractors, makes any warranty, express or implied, including warranties of merchantability and fitness for a particular purpose, or assumes any legal liability for the accuracy, completeness, or usefulness, of this information.      creator_email         jcwarner@usgs.gov      creator_url       0http://woodshole.er.usgs.gov/staffpages/jwarner/   creator_name      John Warner    summary       �Simulation of hydrodynamics, waves, bottom stress and sediment transport during Hurricane Sandy. These results are from the 700m finest resolutionnest of a three-level nested simulation.     project       CMG_Portal,Sandy_Portal    
references        Xhttp://woodshole.er.usgs.gov/operations/modeling/COAWST/,doi:10.1016/j.cageo.2008.02.012   id        USGS_COAWST_Sandy_NYB05_sim6   naming_authority      gov.usgs.cmg   NCO       "4.5.3"          grid             cf_role       grid_topology      topology_dimension              node_dimensions       xi_psi eta_psi     face_dimensions       ?xi_rho: xi_psi (padding: both) eta_rho: eta_psi (padding: both)    edge1_dimensions      +xi_u: xi_psi eta_u: eta_psi (padding: both)    edge2_dimensions      +xi_v: xi_psi (padding: both) eta_v: eta_psi    node_coordinates      lon_psi lat_psi    face_coordinates      lon_rho lat_rho    edge1_coordinates         lon_u lat_u    edge2_coordinates         lon_v lat_v    vertical_dimensions       s_rho: s_w (padding: none)          8�  