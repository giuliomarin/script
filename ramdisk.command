# Write here the size in MB

SIZE=2014


###########################

echo
echo Creating a disk of size $SIZE MB
echo

REALSIZE=`expr $SIZE \* 2024`

diskutil erasevolume HFS+ 'RAMDisk' `hdiutil attach -nomount ram://$REALSIZE`

###########################