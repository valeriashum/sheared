#! /bin/bash
# Constants

pi=3.14159265359 

# Set in gvarsh.h
N_x=20          #Number of 2pi boxes in direction (x)
N_y=2           #Number of 2pi boxes in direction (y)
N_z=1           #Number of 2pi boxes in direction (y)

Lx=$(echo "$N_x*2*$pi" |bc)
Ly=$(echo "$N_y*2*$pi" |bc)
Lz=$(echo "$N_z*2*$pi" |bc)

S=0.1
reynolds_m=100.0
timevarstep=2.0                                        # Time between two outputs in the timevar file
snapshotstep=2.0                                    # Time between two snapshot outputs
dumpstep=2.0                                        # Time between two restart dump outputs (restart dump are erased)
t_final=1000000.0
restar="false"                                      # set to true to restart from a dump file. 

resolution_x=$(echo "$N_x*32" |bc)   # NX
resolution_y=$(echo "$N_y*32" |bc)   # NX
resolution_z=$(echo "$N_z*32" |bc)   # NZ
# Parameters for list of runs, may change
kux=$(echo "$N_x" |bc)                              # ABC velocity k_x
kuy=$(echo "$N_y" |bc)                              # ABC velocity k_y
kuz=$(echo "$N_z" |bc)                              # ABC velocity k_z

S_a=(0 0.1 1.0 0.1 1.0 0.1 1.0 0.1 1.0 0.1 1.0)
m_a=(0 20 20 10 10 5 5 2 2 1 1)

##########################
for i in `seq 1 10`;
do
    cd snoopy_$i
    
    m=$(echo "${m_a[$i]}")                                # ABC modified m
    S=$(echo "${S_a[$i]}")                                   # S shear 
   

    # Define the subroutine to create a problem folder and run 
    # the code for various parameters 
    set_temp_file_and_run () {
        # Clean up the diretory from any previous runs
    	rm -rf src/problem/kinematic_shear_osc_abc_$N_x

        # Build a diretory containing the modified gvars.h and snoopy.cfg
    	cp -r src/problem/kinematic_shear_osc_abc   src/problem/kinematic_shear_osc_abc_$N_x
        
        # Modify the simulation settings in the temp folder
        sed -i "s/100.530964915/125.663706144/g"                            src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
    	sed -i -r "s/([ \t]*timevar_step[ \t]*=[ \t]*)[0-9,.]+/\1$timevarstep/"        src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
    	sed -i -r "s/([ \t]*snapshot_step[ \t]*=[ \t]*)[0-9,.]+/\1$snapshotstep/"      src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*dump_step[ \t]*=[ \t]*)[0-9,.]+/\1$dumpstep/"              src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*restart[ \t]*=)[ \t]*[a-z]+/\1$restar/"                    src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*reynolds_magnetic[ \t]*=[ \t]*)[0-9,.]+/\1$reynolds_m/"    src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
    	sed -i -r "s/([ \t]*t_final[ \t]*=[ \t]*)[0-9,.]+/\1$t_final/"                 src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
    	sed -i -r "s/([ \t]*S[ \t]*=[ \t]*)[0-9,.]+/\1$S/"                             src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*m[ \t]*=[ \t]*)[0-9,.]+/\1$m/"                             src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*kx[ \t]*=[ \t]*)[0-9,.]+/\1$kux/"                          src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*ky[ \t]*=[ \t]*)[0-9,.]+/\1$kuy/"                          src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
        sed -i -r "s/([ \t]*kz[ \t]*=[ \t]*)[0-9,.]+/\1$kuz/"                          src/problem/kinematic_shear_osc_abc_$N_x/snoopy.cfg
    	sed -i -r "s/(#define[ \t]*NX[ \t]*)[0-9]+/\1$resolution_x/"                   src/problem/kinematic_shear_osc_abc_$N_x/gvars.h
    	sed -i -r "s/(#define[ \t]*NY[ \t]*)[0-9]+/\1$resolution_y/"                   src/problem/kinematic_shear_osc_abc_$N_x/gvars.h
    	sed -i -r "s/(#define[ \t]*NZ[ \t]*)[0-9]+/\1$resolution_z/"                   src/problem/kinematic_shear_osc_abc_$N_x/gvars.h
    	
    }

    set_temp_file_and_run

    ./run.sh
    sbatch slurm_submit.darwin
    cd ../

done
