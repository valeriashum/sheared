for i in `seq 1 10`;
do 
  cd snoopy_$i
  sed -i 's/box=6/box=7/g' move_to_prev.sh
  ./move_to_prev.sh 
  
  sed -i 's/restart =false/restart = true/g' src/problem/kinematic_shear_osc_abc_20/snoopy.cfg

  ./run.sh
  sbatch slurm_submit.darwin
  
  cd ../ 
done
