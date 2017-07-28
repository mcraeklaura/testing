#!/bin/bash
BRANCH=t
HAS_PULL=0
if [ !`git branch -a | egrep "^[[:space:]]+${BRANCH}$"` ]
then
   # If the branch doesn't exist, make it again.
   git checkout -b ${BRANCH}
   HAS_PULL=1
fi

# Insert changes here
echo $(date) > test.txt

git add --all
git commit -m "Making changes to CPU/MEM data"
git push -u origin ${BRANCH}

if [ HAS_PULL ]
then
   # Make new pull request if there isn't already one
   curl -u mcraeklaura:lionpath11 -X POST -H 'Content-type: application/json' \
   --data '{"title":"BOT Make changes to FILES","body":"Please pull this in!","head":"mcraeklaura:'+$BRANCH+'","base":"master"}' \
   https://api.github.com/repos/mcraeklaura/testing/pulls
fi

git checkout master
