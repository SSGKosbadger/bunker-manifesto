#!/bin/bash

declare -A translit=(
    ["А"]="A" ["Б"]="B" ["В"]="V" ["Г"]="H" ["Ґ"]="G" ["Д"]="D" ["Е"]="E" ["Є"]="Ye" ["Ж"]="Zh"
    ["З"]="Z" ["И"]="Y" ["І"]="I" ["Ї"]="Yi" ["Й"]="Y" ["К"]="K" ["Л"]="L" ["М"]="M" ["Н"]="N"
    ["О"]="O" ["П"]="P" ["Р"]="R" ["С"]="S" ["Т"]="T" ["У"]="U" ["Ф"]="F" ["Х"]="Kh" ["Ц"]="Ts"
    ["Ч"]="Ch" ["Ш"]="Sh" ["Щ"]="Shch" ["Ю"]="Yu" ["Я"]="Ya" ["Ь"]="" ["Ъ"]="" ["’"]=""
    ["а"]="a" ["б"]="b" ["в"]="v" ["г"]="h" ["ґ"]="g" ["д"]="d" ["е"]="e" ["є"]="ie" ["ж"]="zh"
    ["з"]="z" ["и"]="y" ["і"]="i" ["ї"]="i" ["й"]="i" ["к"]="k" ["л"]="l" ["м"]="m" ["н"]="n"
    ["о"]="o" ["п"]="p" ["р"]="r" ["с"]="s" ["т"]="t" ["у"]="u" ["ф"]="f" ["х"]="kh" ["ц"]="ts"
    ["ч"]="ch" ["ш"]="sh" ["щ"]="shch" ["ю"]="iu" ["я"]="ia" ["ь"]="" ["ъ"]="" ["’"]=""
)

find . -depth | while read fname; do
    dir=$(dirname "$fname")
    base=$(basename "$fname")
    newbase=""

    for (( i=0; i<${#base}; i++ )); do
        char="${base:$i:1}"
        if [[ "$char" == " " ]]; then
            newbase+="-"
        elif [[ "${translit[$char]+_}" ]]; then
            newbase+="${translit[$char]}"
        else
            newbase+="$char"
        fi
    done

    if [[ "$base" != "$newbase" ]]; then
        mv "$fname" "$dir/$newbase"
    fi
done
