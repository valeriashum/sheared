for i in `seq 1 10`;
do 
  cd snoopy_$i

  ./run.sh
  sbatch slurm_submit.darwin
  
  cd ../ 
done
