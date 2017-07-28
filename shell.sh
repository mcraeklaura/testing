#!/bin/bash
if [ `git branch --list t` ]
then
   git branch -D t
   git push origin --delete t
fi
git branch t
git checkout t
echo "heeeeeeey" > test.txt
git add --all
git commit -m "automated push"
git push -u origin t
