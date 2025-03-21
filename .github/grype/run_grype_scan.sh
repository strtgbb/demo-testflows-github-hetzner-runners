set -x
set -e

IMAGE=$1

GRYPE_VERSION="v0.80.1"

docker pull $IMAGE
docker pull anchore/grype:${GRYPE_VERSION}

docker run \
 --rm --volume /var/run/docker.sock:/var/run/docker.sock \
 --name Grype anchore/grype:${GRYPE_VERSION} \
 --scope all-layers \
 -o json \
 $IMAGE > result.json

ls -sh

python3 -u ./.github/grype/parse_vulnerabilities_grype.py -o nice --no-colors --log raw.log --test-to-end || exit_code=$?

./.github/grype/collect_metadata.sh

exit $exit_code
