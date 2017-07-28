#!/bin/bash
if  [ `git branch -a | egrep "remotes/origin/${BRANCH}$"` ]
   then
      # Branch doesn't exist remotely
      echo "Branch does not exist remotely"
   fi
