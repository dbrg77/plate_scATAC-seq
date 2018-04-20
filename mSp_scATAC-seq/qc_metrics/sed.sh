for i in {1..9}; do
    for j in *.txt; do
        sed -i s/_rep0${i}_/_rep${i}_/g ${j}
    done
done
