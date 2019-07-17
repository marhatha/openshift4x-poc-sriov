echo "clone this github link https://github.com/openshift/sriov-network-operator" 
sleep 2
echo "After cloning is done  go to sriov-network-operator directory  and run this sriov.sh script"
sleep 5


##############################################################
# UPDATE TO MATCH YOUR ENVIRONMENT
##############################################################

OCP_RELEASE=4.1.4
#RHCOS_BUILD=4.1.0
#POCDIR=ocp4poc

#############################################################
# EXPERIMENTAL
##############################################################

#LAST_3_OCP_RELEASES=$(curl -s https://quay.io/api/v1/repository/${UPSTREAM_REPO}/ocp-release/tag/\?limit=3\&page=1\&onlyActiveTags=true | jq -r '.tags[].name')

AIRGAP_REG='registry.ocp4poc.example.com:5000'
AIRGAP_REPO='ocp4/openshift4'
UPSTREAM_REPO='quay.io'   ## or 'openshift'
AIRGAP_SECRET_JSON='pull-secret-2.json'
#export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=${AIRGAP_REG}/${AIRGAP_REPO}:${OCP_RELEASE}

##############################################################
# DO NOT MODIFY AFTER THIS LINE
############################################################################################################################

usage() {
    echo -e "Usage: $0 [ modify_files ] "
    echo -e "\t\t(extras) [  mirror |  clone ]"
}



get_sriov_images() {
    mkdir images ; cd images 
    curl -J -L -O ${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0 
    curl -J -L -O ${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0 
    curl -J -L -O ${UPSTREAM_REPO}/openshift/origin-sriov-network-operator 
    curl -J -L -O ${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0 
    cd ..
    tree images
}



mirror() {

skopeo copy --authfile=${AUTH_JSON_FILE} ${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0 \
        ${AIRGAP_REG}/${AIRGAP_REPO}:${OCP_RELEASE}

skopeo copy --authfile=${AUTH_JSON_FILE} ${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0 \
        ${AIRGAP_REG}/${AIRGAP_REPO}:${OCP_RELEASE}

skopeo copy --authfile=${AUTH_JSON_FILE} ${UPSTREAM_REPO}/openshift/origin-sriov-network-operator \
        ${AIRGAP_REG}/${AIRGAP_REPO}:${OCP_RELEASE}

skopeo copy --authfile=${AUTH_JSON_FILE} ${UPSTREAM_REPO}/openshift/origin-sriov-network-operator \
        ${AIRGAP_REG}/${AIRGAP_REPO}:${OCP_RELEASE}

skopeo copy --authfile=${AUTH_JSON_FILE} ${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0 \
        ${AIRGAP_REG}/${AIRGAP_REPO}:${OCP_RELEASE}

}

modify_file() {

sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-operator|${AIRGAP_REG}/origin-sriov-network-operator|g' < ./deploy/operator.yaml > test.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > operator.yaml
rm test.yaml test1.yaml test2.yaml
echo "operator.yaml file completed successfully"
sleep 2

sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-cni:4.2.0|g' < ./hack/env.sh  > test.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|${UPSTREAM_REPO}/pliurh/sriov-network-operator|${AIRGAP_REG}/pliurh/sriov-network-operator|g' < test2.yaml  > env.sh
rm test.yaml test1.yaml test2.yaml
echo "env.sh is completed succesfuly"
sleep 2

sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-operator:latest|${AIRGAP_REG}/openshift/origin-sriov-network-operator:latest|g' < ./manifests/latest  > test.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > latest
rm test.yaml test1.yaml test2.yaml
echo "manifest file  is completed succesfuly"
sleep 2

sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-operator:latest|${AIRGAP_REG}/openshift/origin-sriov-network-operator:latest|g' < ./manifests/4.2/sriov-network-operator.v0.0.1.clusterserviceversion.yaml > test.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > sriov-network-operator.v0.0.1.clusterserviceversion.yaml
rm test.yaml test1.yaml test2.yaml
echo "clusterserviceversion file  is completed succesfuly"
sleep 2

sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-operator:latest|${AIRGAP_REG}/openshift/origin-sriov-network-operator:latest|g' < ./manifests/4.2/image-references > test.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-cni:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-network-device-plugin:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|${UPSTREAM_REPO}/openshift/origin-sriov-dp-admission-controller:4.2.0|${AIRGAP_REG}/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > image-references
rm test.yaml test1.yaml test2.yaml
echo "image reference file  is completed succesfuly"
sleep 2

echo "backing up the files stay tuned"
cp ./deploy/operator.yaml ./deploy/operator_bkp.yaml
cp ./hack/env.sh ./hack/env_bkp.sh
cp ./manifests/latest ./manifests/latest_bkp
cp ./manifests/4.2/sriov-network-operator.v0.0.1.clusterserviceversion.yaml ./manifests/4.2/sriov-network-operator.v0.0.1.clusterserviceversion_bkp.yaml
cp  ./manifests/4.2/image-references  ./manifests/4.2/image-references_bkp

echo "backup done \n"
echo "Copying files now \n"
sleep 2

cp operator.yaml ./deploy/operator.yaml
cp env.sh ./hack/env.sh
cp latest ./manifests/latest
cp sriov-network-operator.v0.0.1.clusterserviceversion.yaml ./manifests/4.2/sriov-network-operator.v0.0.1.clusterserviceversion.yaml 
cp image-references ./manifests/4.2/image-references

echo "DONE DONE DONE" 

}


clone () {
git cone https://github.com/openshift/sriov-network-operator
cd sriov-network-operator
}





# Capture First param
key="$1"

case $key in
    modify_files)
        modify_files
        ;;
    get_sriov_images)
        get_sriov_images
        ;;
    mirror)
        mirror
        ;;
    clone)
        clone
        ;;
    *)
        usage
        ;;
esac

##############################################################
# END OF FILE
##############################################################
