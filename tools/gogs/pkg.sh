ts=$(date "+%Y%m%d")
fs=/tmp/data-${ts}.tar.gz 
dir=/data
echo $ts
echo $fs
echo $dir

rm  ${dir}/data*.tar.gz 
tar cvf ${fs} ${dir}
mv ${fs} ${dir}
