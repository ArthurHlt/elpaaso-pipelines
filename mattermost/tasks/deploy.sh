#!/usr/bin/env bash
set -x
BASEDIR="$PWD/deployment"
version_github=$(head -n 1 "$PWD/mattermost-integrator-github/tag")
wget https://github.com/cloudfoundry-community/mattermost-cf-integrator/releases/download/$version_github/mattermost-cf.zip
if [ $? -ne 0 ]; then
    echo "can't found the version $version_github, try: https://github.com/cloudfoundry-community/mattermost-cf-integrator/releases/download/$version_github/mattermost-cf.zip "
	exit 1
fi
unzip "mattermost-cf.zip" -d "$BASEDIR"
service_name="mysql-$app_name"
cf s | grep $service_name > /dev/null

if [ $? -ne 0 ]; then
	cf cs p-mysql 1gb $service_name
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi
echo "$mattermost_config" > "$BASEDIR/mattermost/config/config.json"
cd "$BASEDIR/mattermost"
cat <<EOT > "manifest.yml"
---
#Generated manifest
name: $app_name
memory: 512M
instances: 1
buildpack: binary_buildpack
services:
- $service_name
EOT
cd -
