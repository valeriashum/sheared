for i in `seq 1 10`;
do 
  cd snoopy_$i
  mkdir to_delete_new
  mv previous* to_delete_new/.
  sed -i 's/box=1/box=1/g' move_to_prev.sh
  ./move_to_prev.sh


  cd ../ 
done
