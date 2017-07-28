#!/bin/bash
BRANCH=t
HAS_NO_PULL=false
if [ !`git branch -a | egrep "^[[:space:]]+${BRANCH}$"` ]
then
   # If the branch doesn't exist, make it again.
   echo "Making new branch"
   git checkout -b ${BRANCH}
   HAS_NO_PULL=true
else
   echo "Checking into the branch"
   git checkout ${BRANCH}
fi

# Insert changes here
echo $(date) > test.txt
echo "Changing stuffs"

git add --all
git commit -m "Making changes to CPU/MEM data"
git push -u origin ${BRANCH}

if [ HAS_NO_PULL==true ]
then
   echo "Making a new pull request"
   # Make new pull request if there isn't already one
   curl -u mcraeklaura:lionpath11 -X POST -H 'Content-type: application/json' \
   --data '{"title":"BOT Make changes to FILES","body":"Please pull this in!","head":"mcraeklaura:'+$BRANCH+'","base":"master"}' \
   https://api.github.com/repos/mcraeklaura/testing/pulls
fi

git checkout master
