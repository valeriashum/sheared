for i in `seq 1 10`;
do 
  cd snoopy_$i
  rm -rf previous_run_1
  sed -i 's/box=1/box=1/g' move_to_prev.sh
  ./move_to_prev.sh
  ./run.sh
  sbatch slurm_submit.darwin
  cd ../ 
done
