for i in `seq 1 10`;
do 
  cd snoopy_$i
  sed -i 's/box=1/box=2/g' move_to_prev.sh
  ./move_to_prev.sh 
  
  cd ../ 
done
