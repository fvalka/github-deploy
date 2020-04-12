#!/bin/sh
if [[ -z "$ACCESS_TOKEN" ]]; then
    echo "ERROR: ACCESS_TOKEN not set, please set the environment variable" >&2
    exit 1
fi

if [[ -z "$REPO" ]]; then
    echo "ERROR: REPO not set, please set the environment variable" >&2
    exit 2
fi

if [ -z "$(ls -A)" ]; then
   echo "ERROR: Data directory is empty, nothing to deploy"
   exit 3
fi

cp -r . /tmp/deploy
cd /tmp/deploy

REMOTE_URL="https://x-access-token:${ACCESS_TOKEN}@github.com/${REPO}.git"
git init
git remote add origin $REMOTE_URL
git fetch

if [[ -z "$BRANCH" ]]; then
    BRANCH="master"
    echo "Setting BRANCH to master, since no branch was set in the environment variables"
fi

if [[ -z "$GIT_EMAIL" ]]; then
    GIT_EMAIL="automated.merge@invalid.com"
fi
if [[ -z "$GIT_USER" ]]; then
    GIT_USER="Automated Merge"
fi

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USER

git add --all
git commit -m "Automated deployment"
git pull origin $BRANCH -s recursive -Xours --allow-unrelated-histories
git push origin $BRANCH