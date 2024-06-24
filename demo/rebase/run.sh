#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")" || exit 1

if [ -e demo ]; then
	rm -rf demo
fi

rm -rf base.git >/dev/null || :
rm -rf foo >/dev/null || :
rm -rf bar >/dev/null || :

mkdir -p demo
cd demo || exit 1

set -x

git init --bare base.git

git clone base.git foo

# foo 提第一个文件，step 1

(
	cd foo || exit
	echo user-foo > user-foo.txt
	git add user-foo.txt
	git commit -m "step1"
	git push
)

# bar 基于 foo，提交 step 2

git clone base.git bar

(
	cd bar || exit
	git co -b bar

	echo user-bar > user-bar.txt
	git add user-bar.txt
	git commit -m "step2"

)

sleep 2

# foo 在 master 提交 step 3

(
	cd foo || exit

	echo test >> user-foo.txt
	git add user-foo.txt
	git commit -m "step3"

	git push
)

sleep 2

# bar 在 bar 分支提交 step 4

(
	cd bar || exit
	echo user-bar >> user-bar.txt
	git add user-bar.txt
	git commit -m "step4"

	git push
)

# bar 更新 foo 的最新

(
	cd bar || exit

	git co master

	git pull
)

exit

# echo step1 > step1.txt
# git add step1.txt
# git commit -m "add step1.txt"
#
# echo step2 > step2.txt
# git add step2.txt
# git commit -m "add step2.txt"
#
# git co -b bugfix
#
# echo step3 > step3.txt
# git add step3.txt
# git commit -m "add bugfix 1.txt"
#
# echo step4 > step4.txt
# git add step4.txt
# git commit -m "add bugfix 2.txt"
