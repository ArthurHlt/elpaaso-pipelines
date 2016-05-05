#!/usr/bin/env bash
set -x
BASEDIR="$PWD/deployment"
version_github=$(head -n 1 "$CW/mattermost-integrator-github/tag")
curl -L https://github.com/cloudfoundry-community/mattermost-cf-integrator/releases/download/$version_github/mattermost-cf.zip -o "$BASEDIR/mattermost-cf.zip"
if [ $? -ne 0 ]; then
    echo "can't found the version $version_github on "
	exit 1
fi
unzip "$BASEDIR/mattermost-cf.zip" -d "$BASEDIR"
service_name="mysql-$app_name"
cf s | grep $service_name > /dev/null

if [ $? -ne 0 ]; then
	cf cs p-mysql 1gb $service_name
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi
cat "$PWD/mattermost-elpaaso-git/config.json" | jq '.SqlSettings.DriverName = "mysql"' | jq '.SqlSettings.DataSource = "mmuser:mostest@tcp(dockerhost:3306)/mattermost_test?charset=utf8mb4,utf8"' > "$PWD/mattermost-elpaaso-git/config.json"
cp "$PWD/mattermost-elpaaso-git/config.json" "$BASEDIR/mattermost/config"
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
