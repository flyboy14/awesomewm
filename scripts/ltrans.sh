#!/bin/bash

declare -A enru
enru=( 
	["q"]="й" 
	["w"]="ц" 
	["e"]="у" 
	["r"]="к" 
	["t"]="е" 
	["y"]="н" 
	["u"]="г" 
	["i"]="ш" 
	["o"]="щ"
	["p"]="з"
	["["]="х"
	["]"]="ъ"
	["a"]="ф"
	["s"]="ы"
	["d"]="в"
	["f"]="а"
	["g"]="п"
	["h"]="р"
	["j"]="о"
	["k"]="л"
	["l"]="д"
	[";"]="ж"
	["'"]="э"
	["z"]="я"
	["x"]="ч"
	["c"]="с"
	["v"]="м"
	["b"]="и"
	["n"]="т"
	["m"]="ь"
	[","]="б"
	["."]="ю"
	["/"]="."
	["Q"]="Й"
	["W"]="Ц"
	["E"]="У"
	["R"]="К"
	["T"]="Е"
	["Y"]="Н"
	["U"]="Г"
	["I"]="Ш"
	["O"]="Щ"
	["P"]="З"
	["{"]="Х"
	["}"]="Ъ"
	["A"]="Ф"
	["S"]="Ы"
	["D"]="В"
	["F"]="А"
	["G"]="П"
	["H"]="Р"
	["J"]="О"
	["K"]="Л"
	["L"]="Д"
	[":"]="Ж"
	['"']="Э"
	["Z"]="Я"
	["X"]="Ч"
	["C"]="С"
	["V"]="М"
	["B"]="И"
	["N"]="Т"
	["M"]="Ь"
	["<"]="Б"
	[">"]="Ю"
	["?"]=","
	["!"]="!"
	["@"]='\"'
	["#"]="№"
	["$"]=";"
	["%"]="%"
	["^"]=":"
	["&"]="?"
	["\`"]="ё"
	["~"]="Ё"
	["\*"]="*"
	[" "]=" "
)
OUT=""

for word in $(echo "$@" | xargs); do
	for digit in $(echo "$word" | sed "s/./& /g" | sed 's/\*/\\*/g'); do
		OUT="$OUT${enru[$digit]:-$digit}"
	done
	OUT="$OUT "
done

echo "$OUT"
echo "$OUT" | xclip -selection clipboard
echo "show_smth(\"$@\", \"$OUT\", '/home/twiceaday/.config/awesome/icons/comicdee/translate.svg', 0, nil, nil, 'Sans 10')" | awesome-client  
