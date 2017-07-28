#!/bin/bash
if [ `git branch -a | egrep "^[[:space:]]+t$"` ]
then
   echo "Deleting t"
   git branch -D t
   #git push origin --delete t
fi
git branch t
git checkout t
echo $(date) > test.txt
git add --all
git commit -m "automated push"
git push -u origin t
curl -u mcraeklaura:lionpath11 -X POST -H 'Content-type: application/json' --data '{"title":"Amazing new feature","body":"Please pull this in!","head":"mcraeklaura:t","base":"master"}' https://api.github.com/repos/mcraeklaura/testing/pulls
