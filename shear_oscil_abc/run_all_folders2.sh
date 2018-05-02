for i in `seq 5 5`;
do 
  cd snoopy_$i
  scp -r previous_run_* vs391@helene.damtp.cam.ac.uk:/store/ASTRO/vs391/kinematic_dynamo/u_abc/compare_shear_osc/box_20/run_$((i+40))/.
  mkdir to_delete_new_1
  mv previous_run* to_delete_new_1/.
  cd ../ 
done
