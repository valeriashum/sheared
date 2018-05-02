for i in `seq 1 10`;
do 
  cd snoopy_$i
  mkdir to_delete
  mv previous_* to_delete
  sed -i 's/box=8/box=1/g' move_to_prev.sh
  ./move_to_prev.sh 
  
  cd ../ 
done
