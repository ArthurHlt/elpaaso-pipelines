#!/usr/bin/env bash

CW=$PWD
version_travis=$(cat "$CW/mattermost-integrator-travis/build-info.json" | jq -r '.commits[0].branch')
version_github=$(head -n 1 "$CW/mattermost-integrator-github/tag")

if [ "$version_travis" -ne "$version_github" ]; then
    echo "it's not waiting the good job, erroring it to wait the good one."
    exit 2
fi
exit 0
