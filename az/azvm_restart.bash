export SUBNET_PREFIX_CM_GRP='10.0.0'
export SUBNET_PREFIX_MASTER_GRP='10.0.1'
export SUBNET_PREFIX_WKS_GRP='10.0.2'
export MY_REMOTE_ACCESS='91.69.161.0/24'
export SSH_KEY_PATH="/home/fjean/.ssh/id_rsa.pub"
export RESOURCE_GROUP='rsg-uks-cdp'


export SUBSCRIPTION='2510a5ab-472f-4c47-bd75-b1c74e40d957'
export LOCATION='uksouth'

az vm restart --resource-group $RESOURCE_GROUP --name cdpmaster1 --subscription $SUBSCRIPTION

for i in 1 2 3
do
    az vm restart --resource-group $RESOURCE_GROUP --name cdpwks${i} --subscription $SUBSCRIPTION
done