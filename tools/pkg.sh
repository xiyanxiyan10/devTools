ts=$(date "+%Y%m%d")
fs=gogs-${ts}.tar.gz 
echo $ts
echo $fs
tar cvf ${fs} gogs 
mv ${fs} /Users/xiyanxiyan10/Desktop/${fs}
