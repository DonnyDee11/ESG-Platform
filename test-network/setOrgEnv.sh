#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using Org1
ORG=${1:-Org1}

# Exit on first error, print all commands.
set -e
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

ORDERER_CA=${DIR}/test-network/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
PEER0_ORG1_CA=${DIR}/test-network/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
PEER0_ORG2_CA=${DIR}/test-network/organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem
PEER0_ORG3_CA=${DIR}/test-network/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem
PEER0_ORG4_CA=${DIR}/test-network/organizations/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem
PEER0_ORG5_CA=${DIR}/test-network/organizations/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem
PEER0_ORG6_CA=${DIR}/test-network/organizations/peerOrganizations/org6.example.com/tlsca/tlsca.org6.example.com-cert.pem
PEER0_ORG7_CA=${DIR}/test-network/organizations/peerOrganizations/org7.example.com/tlsca/tlsca.org7.example.com-cert.pem
PEER0_ORG8_CA=${DIR}/test-network/organizations/peerOrganizations/org8.example.com/tlsca/tlsca.org8.example.com-cert.pem
PEER0_ORG9_CA=${DIR}/test-network/organizations/peerOrganizations/org9.example.com/tlsca/tlsca.org9.example.com-cert.pem
PEER0_ORG10_CA=${DIR}/test-network/organizations/peerOrganizations/org10.example.com/tlsca/tlsca.org10.example.com-cert.pem


if [[ ${ORG,,} == "org1" || ${ORG,,} == "digibank" ]]; then

   CORE_PEER_LOCALMSPID=Org1MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
   CORE_PEER_ADDRESS=localhost:7051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem

elif [[ ${ORG,,} == "org2" || ${ORG,,} == "magnetocorp" ]]; then

   CORE_PEER_LOCALMSPID=Org2MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
   CORE_PEER_ADDRESS=localhost:9051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem

elif [[ ${ORG,,} == "org3" ]]; then

   CORE_PEER_LOCALMSPID=Org3MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
   CORE_PEER_ADDRESS=localhost:11051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem

elif [[ ${ORG,,} == "org4"]]; then
   CORE_PEER_LOCALMSPID=Org4MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp
   CORE_PEER_ADDRESS=localhost:13051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem

elif [[ ${ORG,,} == "org5"]]; then
   CORE_PEER_LOCALMSPID=Org5MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp
   CORE_PEER_ADDRESS=localhost:15051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem

elif [[ ${ORG,,} == "org6" ]]; then
   CORE_PEER_LOCALMSPID=Org6MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp
   CORE_PEER_ADDRESS=localhost:17051 
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org6.example.com/tlsca/tlsca.org6.example.com-cert.pem

elif [[ ${ORG,,} == "org7" ]]; then
   CORE_PEER_LOCALMSPID=Org7MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org7.example.com/users/Admin@org7.example.com/msp
   CORE_PEER_ADDRESS=localhost:19051 
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org7.example.com/tlsca/tlsca.org7.example.com-cert.pem

elif [[ ${ORG,,} == "org8" ]]; then
   CORE_PEER_LOCALMSPID=Org8MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org8.example.com/users/Admin@org8.example.com/msp
   CORE_PEER_ADDRESS=localhost:21051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org8.example.com/tlsca/tlsca.org8.example.com-cert.pem

elif [[ ${ORG,,} == "org9" ]]; then
   CORE_PEER_LOCALMSPID=Org9MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org9.example.com/users/Admin@org9.example.com/msp
   CORE_PEER_ADDRESS=localhost:23051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org9.example.com/tlsca/tlsca.org9.example.com-cert.pem

elif [[ ${ORG,,} == "org10" ]]; then
   CORE_PEER_LOCALMSPID=Org10MSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/org10.example.com/users/Admin@org10.example.com/msp
   CORE_PEER_ADDRESS=localhost:25051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/org10.example.com/tlsca/tlsca.org10.example.com-cert.pem

else
   echo "Unknown \"$ORG\", please choose Org1/Digibank or Org2/Magnetocorp"
   echo "For example to get the environment variables to set upa Org2 shell environment run:  ./setOrgEnv.sh Org2"
   echo
   echo "This can be automated to set them as well with:"
   echo
   echo 'export $(./setOrgEnv.sh Org2 | xargs)'
   exit 1
fi

# output the variables that need to be set
echo "CORE_PEER_TLS_ENABLED=true"
echo "ORDERER_CA=${ORDERER_CA}"
echo "PEER0_ORG1_CA=${PEER0_ORG1_CA}"
echo "PEER0_ORG2_CA=${PEER0_ORG2_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG3_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG4_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG5_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG6_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG7_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG8_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG9_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG10_CA}"

echo "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
