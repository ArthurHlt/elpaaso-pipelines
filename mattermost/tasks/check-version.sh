#!/usr/bin/env bash
CW=$PWD

actual_version=$(curl -s https://www.mattermost.org/download/ | pup '.entry-content h2' | grep Mattermost | awk '{print $5}')
current_version=$(head -n 1 "$CW/mattermost-integrator-github/tag")
if [ "$actual_version" = "$current_version" ]; then
    echoc "[yellow]You should don't care about this error."
    echoc "[green]The version $actual_version already exists."
    exit 1
fi
semver=$(echo "$actual_version" | sed 's/v//g')
echo "$semver" | grep -Eq "^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$"
if [ $? -ne 0 ]; then
    message="[mattermost] Parsed version do not follow semantic versioning, check https://www.mattermost.org/download page and fix the parsing"
    echo "$message"
    notifslack --url $slack_url -c $slack_channel -u $slack_username -i $slack_icon "$message"
    exit 1
fi
echo "$semver" | grep -Eq "^$accepted_version$"
if [ $? -ne 0 ]; then
    message="[mattermost] A new version of mattermost came but this version ($semver) is not accepted, please review this new version on mattermost.org and change the param \`accepted_version\` in pipeline when ready."
    echo "$message"
    notifslack --url $slack_url -c $slack_channel -u $slack_username -i $slack_icon "$message"
    exit 1
fi
echo "$semver" > "$CW/release-info/tag_to_release"
echo "Mattermost $semver on Cloud Foundry" > "$CW/release-info/name_of_release"
echo "Mattermost $semver on Cloud Foundry" > "$CW/release-info/body"
exit 0