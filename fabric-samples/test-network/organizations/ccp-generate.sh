#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org1.example.com/connection-org1.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org1.example.com/connection-org1.yaml

ORG=2
P0PORT=9051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org2.example.com/ca/ca.org2.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org2.example.com/connection-org2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org2.example.com/connection-org2.yaml

# --- ORG 3 ---
ORG=3
P0PORT=11051
CAPORT=9054
PEERPEM=organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org3.example.com/ca/ca.org3.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org3.example.com/connection-org3.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org3.example.com/connection-org3.yaml

# --- ORG 4 ---
ORG=4
P0PORT=13051
CAPORT=10054
PEERPEM=organizations/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org4.example.com/connection-org4.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org4.example.com/connection-org4.yaml

# --- ORG 5 ---
ORG=5
P0PORT=15051
CAPORT=11054
PEERPEM=organizations/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org5.example.com/ca/ca.org5.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org5.example.com/connection-org5.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org5.example.com/connection-org5.yaml

# --- ORG 6 ---
ORG=6
P0PORT=17051
CAPORT=12054
PEERPEM=organizations/peerOrganizations/org6.example.com/tlsca/tlsca.org6.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org6.example.com/ca/ca.org6.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org6.example.com/connection-org6.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org6.example.com/connection-org6.yaml

# --- ORG 7 ---
ORG=7
P0PORT=19051
CAPORT=13054
PEERPEM=organizations/peerOrganizations/org7.example.com/tlsca/tlsca.org7.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org7.example.com/ca/ca.org7.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org7.example.com/connection-org7.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org7.example.com/connection-org7.yaml

# --- ORG 8 ---
ORG=8
P0PORT=21051
CAPORT=14054
PEERPEM=organizations/peerOrganizations/org8.example.com/tlsca/tlsca.org8.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org8.example.com/ca/ca.org8.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org8.example.com/connection-org8.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org8.example.com/connection-org8.yaml

# --- ORG 9 ---
ORG=9
P0PORT=23051
CAPORT=15054
PEERPEM=organizations/peerOrganizations/org9.example.com/tlsca/tlsca.org9.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org9.example.com/ca/ca.org9.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org9.example.com/connection-org9.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org9.example.com/connection-org9.yaml

# --- ORG 10 ---
ORG=10
P0PORT=25051
CAPORT=16054
PEERPEM=organizations/peerOrganizations/org10.example.com/tlsca/tlsca.org10.example.com-cert.pem
CAPEM=organizations/peerOrganizations/org10.example.com/ca/ca.org10.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org10.example.com/connection-org10.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org10.example.com/connection-org10.yaml





# # Loop through organizations 1 to 10
# for ORG in {1..10}; do

#   # Calculate port numbers based on the organization number
#   P0PORT=$((7051 + 200 * (ORG - 1)))  # First peer port starts at 7051
#   CAPORT=$((7054 + 100 * (ORG - 1)))  # CA port starts at 7054

#   # Construct paths to PEM files using the organization number
#   PEERPEM=organizations/peerOrganizations/org${ORG}.example.com/tlsca/tlsca.org${ORG}.example.com-cert.pem
#   CAPEM=organizations/peerOrganizations/org${ORG}.example.com/ca/ca.org${ORG}.example.com-cert.pem   


#   # Generate connection profiles (JSON and YAML) and save them to the appropriate location
#   echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org${ORG}.example.com/connection-org${ORG}.json
#   echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/org${ORG}.example.com/connection-org${ORG}.yaml   


# done