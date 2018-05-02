for i in `seq 1 10`;
do 
  cd snoopy_$i
  mkdir to_delete
  mv previous_* to_delete
  sed -i 's/20_20/20/g' ./run.sh


  cd ../ 
done
