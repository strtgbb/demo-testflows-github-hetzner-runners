set -x
set -e

IMAGE=$1

export TESTFLOWS_VERSION="2.4.19"
GRYPE_VERSION="v0.80.1"

docker pull $IMAGE
docker pull anchore/grype:${GRYPE_VERSION}

docker run \
 --rm --volume /var/run/docker.sock:/var/run/docker.sock \
 --name Grype anchore/grype:${GRYPE_VERSION} \
 --scope all-layers \
 -o json \
 $IMAGE > result.json

ls

sudo apt-get install -y python3-pip python3-venv
python3 -m venv venv
source venv/bin/activate
pip3 install --upgrade requests chardet urllib3
pip3 install testflows==$TESTFLOWS_VERSION
python3 -u ./.github/grype/parse_vulnerabilities_grype.py -o classic --no-colors --log raw.log --test-to-end || exit_code=$?

./.github/grype/collect_metadata.sh

exit $exit_code
