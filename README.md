# openshift4x-poc-sriov

This is a reference script to modify the sriov-network-operator to adapt as per the dosconnected Openshift envoirnment .
In this script user will first clone the following github repo https://github.com/openshift/sriov-network-operator and adapt the variables listed in the script as per thier envoirnment.

In order to clone the github you can run the script as follows:


./sriov_2.sh clone

Once github is cloned , make sure you change to sriov-network-operator directory and run this script from there .
Before running the script you must ensure that the pull secret file of your local registry is also present inside the sriov-network-operator directory.


./sriov_2.sh mirror

./sriov_2.sh modify_files






