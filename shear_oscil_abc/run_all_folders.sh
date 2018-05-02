for i in `seq 3 10`;
do 
  cd snoopy_$i
  sed -i 's/box=3/box=1/g' move_to_prev.sh
  rm -rf previous_run*
  ./move_to_prev.sh
  sed -i 's/restart = false/restart = true/g' src/problem/kinematic_shear_osc_abc/snoopy.cfg
  ./run.sh
  sbatch slurm_submit.darwin
  scp -r previous_run_* vs391@helene.damtp.cam.ac.uk:/store/ASTRO/vs391/kinematic_dynamo/u_abc/compare_shear_osc/box_16/run_$((i+30))/.

  cd ../ 
done
