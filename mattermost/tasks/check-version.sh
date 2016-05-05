#!/usr/bin/env bash

CW=$PWD

actual_version=$(curl -s http://www.mattermost.org/download/ | ./pup '.entry-content h2' | grep Mattermost | awk '{print $4}')
current_version=$(head -n 1 "$CW/mattermost-integrator-github/tag")
if [ "$actual_version" = "$current_version" ]; then
    echo "The version $actual_version already exists."
    exit 1
fi
semver=$(echo "$actual_version" | sed 's/v//g')
echo "$semver" > "$CW/mattermost-integrator-github/tag_to_release"
echo "Mattermost $semver on Cloud Foundry" > "$CW/mattermost-integrator-github/name_of_release"
exit 0