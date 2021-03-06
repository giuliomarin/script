printf "\n======\nGenerate project for XCode\n======\n\n"

projects=('/GitHub/CommonTools/submodules/Nitrogen' '/GitHub/cvip-cpp' '/GitHub/Fusion')

i=0
for p in ${projects[*]}; do
echo "[$i] $p"
((i++))
done

echo ""
read -p "Type project id: " p
if [ "$p" == "" ]; then p=0; fi

builddir=/GitHub/build/`echo ${projects[$p]} | awk -F/ '{print $NF}'`
echo "Building project: [$p] ${projects[$p]}"
echo "Builddir: $builddir"
echo ""

cmake ${projects[$p]} -B$builddir -G "Xcode"

if [ "$?" != "0" ]; then
    echo "Error in generating the project"
    read -p "Press Return to Close..."
fi
