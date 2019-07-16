echo "clone  https://github.com/openshift/sriov-network-operator github link via git clone https://github.com/openshift/sriov-network-operator"
sleep 2
echo "After cloning is done  go to cluster-node-tuning-operator directory and run this sriov.sh script"
sleep 5
sed -e 's|quay.io/openshift/origin-sriov-network-operator|local-registry:5000/origin-sriov-network-operator|g' < ./deploy/operator.yaml > test.yaml
sed -e 's|quay.io/openshift/origin-sriov-cni:4.2.0|local-registry:5000/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|quay.io/openshift/origin-sriov-network-device-plugin:4.2.0|local-registry:5000/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|quay.io/openshift/origin-sriov-dp-admission-controller:4.2.0|local-registry:5000/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > operator.yaml
rm test.yaml test1.yaml test2.yaml
echo "operator.yaml file completed successfully"
sleep 2

sed -e 's|quay.io/openshift/origin-sriov-cni:4.2.0|local-registry:5000/openshift/origin-sriov-cni:4.2.0|g' < ./hack/env.sh  > test.yaml
sed -e 's|quay.io/openshift/origin-sriov-network-device-plugin:4.2.0|local-registry:5000/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|quay.io/openshift/origin-sriov-dp-admission-controller:4.2.0|local-registry:5000/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|quay.io/pliurh/sriov-network-operator|local-registry:5000/pliurh/sriov-network-operator|g' < test2.yaml  > env.sh
rm test.yaml test1.yaml test2.yaml
echo "env.sh is completed succesfuly"
sleep 2

sed -e 's|quay.io/openshift/origin-sriov-network-operator:latest|local-registry:5000/openshift/origin-sriov-network-operator:latest|g' < ./manifests/latest  > test.yaml
sed -e 's|quay.io/openshift/origin-sriov-cni:4.2.0|local-registry:5000/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|quay.io/openshift/origin-sriov-network-device-plugin:4.2.0|local-registry:5000/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|quay.io/openshift/origin-sriov-dp-admission-controller:4.2.0|local-registry:5000/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > latest
rm test.yaml test1.yaml test2.yaml
echo "manifest file  is completed succesfuly"
sleep 2

sed -e 's|quay.io/openshift/origin-sriov-network-operator:latest|local-registry:5000/openshift/origin-sriov-network-operator:latest|g' < ./manifests/4.2/sriov-network-operator.v0.0.1.clusterserviceversion.yaml > test.yaml
sed -e 's|quay.io/openshift/origin-sriov-cni:4.2.0|local-registry:5000/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|quay.io/openshift/origin-sriov-network-device-plugin:4.2.0|local-registry:5000/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|quay.io/openshift/origin-sriov-dp-admission-controller:4.2.0|local-registry:5000/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > sriov-network-operator.v0.0.1.clusterserviceversion.yaml
rm test.yaml test1.yaml test2.yaml
echo "clusterserviceversion file  is completed succesfuly"
sleep 2

sed -e 's|quay.io/openshift/origin-sriov-network-operator:latest|local-registry:5000/openshift/origin-sriov-network-operator:latest|g' < ./manifests/4.2/image-references > test.yaml
sed -e 's|quay.io/openshift/origin-sriov-cni:4.2.0|local-registry:5000/openshift/origin-sriov-cni:4.2.0|g' < test.yaml  > test1.yaml
sed -e 's|quay.io/openshift/origin-sriov-network-device-plugin:4.2.0|local-registry:5000/openshift/origin-sriov-network-device-plugin:4.2.0|g' < test1.yaml  > test2.yaml
sed -e 's|quay.io/openshift/origin-sriov-dp-admission-controller:4.2.0|local-registry:5000/openshift/origin-sriov-dp-admission-controller:4.2.0|g' < test2.yaml  > image-references
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
