for i in `seq 1 10`;
do 
  cd snoopy_$i
  
  sed -i 's/reynolds_magnetic = 5.0;/reynolds_magnetic = 2.0;/g' src/problem/kinematic_shear_osc_m/snoopy.cfg
  sed -i 's/restart = true;/restart = false;/g' src/problem/kinematic_shear_osc_m/snoopy.cfg

  ./run.sh
  sbatch slurm_submit.darwin
  
  cd ../ 
done
