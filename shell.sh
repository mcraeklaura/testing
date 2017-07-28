#!/bin/bash
BRANCH=t
HAS_NO_PULL=0
if [ `git branch -a | egrep "^[[:space:]]+${BRANCH}$"` ]
then
   echo "Checking into the branch"
   git checkout ${BRANCH}
   if ! [ `git branch -a | egrep "remotes/origin/${BRANCH}$"` ]
   then
      # Branch doesn't exist remotely
      echo "Branch does not exist remotely"
      git push -u origin ${BRANCH}
      HAS_NO_PULL=1
   fi
else
   # If the branch doesn't exist, make it again.
   echo "Making new branch"
   HAS_NO_PULL=1
   git checkout -b ${BRANCH}
fi

# Insert changes here
echo $(date) > test.txt
echo "Changing stuffs"

git add --all
git commit -m "Making changes to CPU/MEM data"
git push -u origin ${BRANCH}

if [ $HAS_NO_PULL -eq 1 ]
then
   echo "Making a new pull request"
   # Make new pull request if there isn't already one
   curl -u mcraeklaura:lionpath11 -X POST -H 'Content-type: application/json' \
   --data '{"title":"BOT Make changes to FILES","body":"Please pull this in!","head":"mcraeklaura:t","base":"master"}' \
   https://api.github.com/repos/mcraeklaura/testing/pulls
fi

git checkout master
