#! /bin/bash

# ---------------------------------------------------------
# Script used to increment git tag version
# Assumes existing git tags follow semantic versioning format (http://semver.org/)
# ---------------------------------------------------------
#
# Parameters
# --doit : Executes the commands - If this is not passed, script runs in dry-run
# mode

DEVELOP_BRANCH="develop"
MASTER_BRANCH="master"
DO_IT=$1

run_command ()
{
        if [ "$DO_IT" = "--doit" ]; then
        ¦   eval $1
        ¦   if [ $? -eq 0 ]; then
        ¦   ¦   echo "$1...success"
        ¦   else
        ¦   ¦   echo "$1...failed"
        ¦   ¦   exit 1
        ¦   fi
        else
        ¦   echo $1
        fi
}

if [ -z $DO_IT ]; then
    echo "Usage:"
    echo
    echo "$0 parameters:"
    echo "--doit : Executes script - If this is not passed, script runs in dry mode"
    echo
    echo "Would execute:"
fi

LATEST_TAG=`git tag | grep test_tag | sort -Vr | head -n 1 | perl -pe 's/(\d+)$/$1+1/e'`
run_command "git tag $LATEST_TAG"
run_command "git push origin $LATEST_TAG"
