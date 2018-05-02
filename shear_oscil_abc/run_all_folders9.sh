for i in `seq 2 10`;
do 
  cd snoopy_$i

  sed -i 's/restart =false/restart = true/g' src/problem/kinematic_shear_osc_abc_20/snoopy.cfg
  cp previous_run_1/dump* .
  ./run.sh
  sbatch slurm_submit.darwin
  
  cd ../ 
done
