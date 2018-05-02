for i in `seq 1 10`;
do 
  cd snoopy_$i
  scp -r previous_run_* vs391@helene.damtp.cam.ac.uk:/store/ASTRO/vs391/kinematic_dynamo/u_iii/compare_shear_osc/box_16/run_$((i+40))/.
  mkdir to_delete_new_4
  mv previous_run* to_delete_new_4/.
  cd ../ 
done
