#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")" || exit 1

if [ -e ffdemo ]; then
	rm -rf ffdemo
fi

mkdir -p ffdemo
cd ffdemo || exit 1
git init

echo step1 > step1.txt
git add step1.txt
git commit -m "add step1.txt"

echo step2 > step2.txt
git add step2.txt
git commit -m "add step2.txt"

git co -b bugfix

echo step3 > step3.txt
git add step3.txt
git commit -m "add bugfix 1.txt"

echo step4 > step4.txt
git add step4.txt
git commit -m "add bugfix 2.txt"
