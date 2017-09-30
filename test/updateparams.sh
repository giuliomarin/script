cp $1 $2
for arg in "${@:3}"; do echo "${arg}"; done | paste - - | while read n arg; do sed -i -e "${n}s|.*|${arg}|" $2; done
echo $2
