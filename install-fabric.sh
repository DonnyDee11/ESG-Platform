#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# A modified version of the Fabric bootstrap script
# Use positional arguments to select components to install
#
# Has exactly the same functional power of bootstrap.sh

### START OF CODE GENERATED BY Argbash v2.9.0  ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate

# Default values
_positionals=()
_arg_comp=('' )

# if version not passed in, default to latest released version
# if ca version not passed in, default to latest released version
_arg_fabric_version="2.5.9"
_arg_ca_version="1.5.12"

REGISTRY=${FABRIC_DOCKER_REGISTRY:-docker.io/hyperledger}

OS=$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')
ARCH=$(uname -m | sed 's/x86_64/amd64/g' | sed 's/aarch64/arm64/g')
PLATFORM=${OS}-${ARCH}

# Fabric < 1.2 uses uname -m for architecture.
MARCH=$(uname -m)


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='fc'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}


print_help()
{
	printf 'Usage: %s [-f|--fabric-version <arg>] [-c|--ca-version <arg>] <comp-1> [<comp-2>] ... [<comp-n>] ...\n' "$0"
	printf '\t%s\n' "<comp> Component to install, one or more of  docker | binary | samples | podman  First letter of component also accepted; If none specified docker | binary | samples is assumed"
	printf '\t%s\n' "-f, --fabric-version: FabricVersion (default: '2.5.9')"
	printf '\t%s\n' "-c, --ca-version: Fabric CA Version (default: '1.5.12')"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-f|--fabric-version)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_fabric_version="$2"
				shift
				;;
			--fabric-version=*)
				_arg_fabric_version="${_key##--fabric-version=}"
				;;
			-f*)
				_arg_fabric_version="${_key##-f}"
				;;
			-c|--ca-version)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_ca_version="$2"
				shift
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			--ca-version=*)
				_arg_ca_version="${_key##--ca-version=}"
				;;
			-c*)
				_arg_ca_version="${_key##-c}"
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'comp'"
	# test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_comp "
	_our_args=$((${#_positionals[@]} - 1))
	for ((ii = 0; ii < _our_args; ii++))
	do
		_positional_names="$_positional_names _arg_comp[$((ii + 1))]"
	done

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

# End of ARGBASH code

# dockerPull() pulls docker images from fabric and chaincode repositories
# note, if a docker image doesn't exist for a requested release, it will simply
# be skipped, since this script doesn't terminate upon errors.

singleImagePull() {
    #three_digit_image_tag is passed in, e.g. "1.4.7"
    three_digit_image_tag=$1
    shift
    #two_digit_image_tag is derived, e.g. "1.4", especially useful as a local tag for two digit references to most recent baseos, ccenv, javaenv, nodeenv patch releases
    two_digit_image_tag=$(echo "$three_digit_image_tag" | cut -d'.' -f1,2)
    while [[ $# -gt 0 ]]
    do
        image_name="$1"
        echo "====>  ${REGISTRY}/fabric-$image_name:$three_digit_image_tag"
        ${CONTAINER_CLI} pull "${REGISTRY}/fabric-$image_name:$three_digit_image_tag"
        ${CONTAINER_CLI} tag "${REGISTRY}/fabric-$image_name:$three_digit_image_tag" "${REGISTRY}/fabric-$image_name"
        ${CONTAINER_CLI} tag "${REGISTRY}/fabric-$image_name:$three_digit_image_tag" "${REGISTRY}/fabric-$image_name:$two_digit_image_tag"
        shift
    done
}

# cloneSamplesRepo() {
#     # clone (if needed) hyperledger/fabric-samples and checkout corresponding
#     # version to the binaries and docker images to be downloaded
#     if [ -d test-network ]; then
#         # if we are in the fabric-samples repo, checkout corresponding version
#         echo "==> Already in fabric-samples repo"
#     elif [ -d fabric-samples ]; then
#         # if fabric-samples repo already cloned and in current directory,
#         # cd fabric-samples
#         echo "===> Changing directory to fabric-samples"
#         cd fabric-samples
#     else
#         echo "===> Cloning hyperledger/fabric-samples repo"
#         git clone -b main https://github.com/hyperledger/fabric-samples.git && cd fabric-samples
#     fi

#     if GIT_DIR=.git git rev-parse v${VERSION} >/dev/null 2>&1; then
#         echo "===> Checking out v${VERSION} of hyperledger/fabric-samples"
#         git checkout -q v${VERSION}
#     else
#         echo "fabric-samples v${VERSION} does not exist, defaulting to main. fabric-samples main branch is intended to work with recent versions of fabric."
#         git checkout -q main
#     fi
# }

# This will download the .tar.gz
download() {
    local BINARY_FILE=$1
    local URL=$2
    local DEST_DIR=$(pwd)
    echo "===> Downloading: " "${URL}"
    if [ -d fabric-samples ]; then
       DEST_DIR="fabric-samples"
    fi
    echo "===> Will unpack to: ${DEST_DIR}"
    curl -L --retry 5 --retry-delay 3 "${URL}" | tar xz -C ${DEST_DIR}|| rc=$?
    if [ -n "$rc" ]; then
        echo "==> There was an error downloading the binary file."
        return 22
    else
        echo "==> Done."
    fi
}

pullBinaries() {
    echo "===> Downloading version ${FABRIC_TAG} platform specific fabric binaries"
    download "${BINARY_FILE}" "https://github.com/hyperledger/fabric/releases/download/v${VERSION}/${BINARY_FILE}"
    if [ $? -eq 22 ]; then
        echo
        echo "------> ${FABRIC_TAG} platform specific fabric binary is not available to download <----"
        echo
        exit
    fi

    echo "===> Downloading version ${CA_TAG} platform specific fabric-ca-client binary"
    download "${CA_BINARY_FILE}" "https://github.com/hyperledger/fabric-ca/releases/download/v${CA_VERSION}/${CA_BINARY_FILE}"
    if [ $? -eq 22 ]; then
        echo
        echo "------> ${CA_TAG} fabric-ca-client binary is not available to download  (Available from 1.1.0-rc1) <----"
        echo
        exit
    fi
}

pullImages() {
    command -v  ${CONTAINER_CLI}  >& /dev/null
    NODOCKER=$?
    if [ "${NODOCKER}" == 0 ]; then
        FABRIC_IMAGES=(peer orderer ccenv)
        case "$VERSION" in
        [2-3].*)
            FABRIC_IMAGES+=(baseos)
            shift
            ;;
        esac

        echo "FABRIC_IMAGES:" "${FABRIC_IMAGES[@]}"
        echo "===> Pulling fabric Images"
        singleImagePull "${FABRIC_TAG}" "${FABRIC_IMAGES[@]}"
        echo "===> Pulling fabric ca Image"
        CA_IMAGE=(ca)
        singleImagePull "${CA_TAG}" "${CA_IMAGE[@]}"
        echo "===> List out hyperledger images"
        ${CONTAINER_CLI} images | grep hyperledger
    else
        echo "========================================================="
        echo "${CONTAINER_CLI} not installed, bypassing download of Fabric images"
        echo "========================================================="
    fi
}


# Main code starts here
parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"


VERSION=$_arg_fabric_version
CA_VERSION=$_arg_ca_version

# prior to 1.2.0 architecture was determined by uname -m
if [[ $VERSION =~ ^1\.[0-1]\.* ]]; then
    export FABRIC_TAG=${MARCH}-${VERSION}
    export CA_TAG=${MARCH}-${CA_VERSION}
else
    # starting with 1.2.0, multi-arch images will be default
    : "${CA_TAG:="$CA_VERSION"}"
    : "${FABRIC_TAG:="$VERSION"}"
fi

# Prior to fabric 2.5, use amd64 binaries on darwin-arm64
if [[ $VERSION =~ ^2\.[0-4]\.* ]]; then
  PLATFORM=$(echo $PLATFORM | sed 's/darwin-arm64/darwin-amd64/g')
fi

BINARY_FILE=hyperledger-fabric-${PLATFORM}-${VERSION}.tar.gz
CA_BINARY_FILE=hyperledger-fabric-ca-${PLATFORM}-${CA_VERSION}.tar.gz

# if nothing has been specified, assume everything
if [[ ${_arg_comp[@]} =~ ^$ ]]; then
    echo "No options selected: Getting all samples, binaries, and docker images"
    echo "Abort now if not the intention"
    sleep 3 # just to give a chance to abort if this wasn't intended
    _arg_comp=('samples','binary','docker')
fi

# Process samples first then the binaries. So if the fabric-samples dir is present
# the binaries will go there
if [[ "${_arg_comp[@]}" =~ (^| |,)s(amples)? ]]; then
        echo
        echo "Clone hyperledger/fabric-samples repo"
        echo
        cloneSamplesRepo
fi

if [[ "${_arg_comp[@]}" =~ (^| |,)b(inary)? ]]; then
        echo
        echo "Pull Hyperledger Fabric binaries"
        echo
        pullBinaries
fi

if [[ "${_arg_comp[@]}" =~ (^| |,)p(odman)? ]]; then
        echo
        echo "Pull Hyperledger Fabric podman images"
        echo
        CONTAINER_CLI=podman
        pullImages
fi

if [[ "${_arg_comp[@]}" =~ (^| |,)d(ocker)? ]]; then
        echo
        echo "Pull Hyperledger Fabric docker images"
        echo
        CONTAINER_CLI=docker
        pullImages
fi
