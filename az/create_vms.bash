export SUBNET_PREFIX_CM_GRP='10.0.0'
export SUBNET_PREFIX_MASTER_GRP='10.0.1'
export SUBNET_PREFIX_WKS_GRP='10.0.2'
export MY_REMOTE_ACCESS='91.69.161.0/24'
export SSH_KEY_PATH="/home/fjean/.ssh/id_rsa.pub"
export RESOURCE_GROUP='rsg-uks-cdp'


export SUBSCRIPTION='2510a5ab-472f-4c47-bd75-b1c74e40d957'
export LOCATION='uksouth'

#export OS='RedHat:rhel-byos:rhel-lvm79-gen2:7.9.20210126'
export OS='RedHat:RHEL:7_9:7.9.2020111301'
# creation des master servers

# az vm create --name cdpcm                                           \
#              --resource-group $RESOURCE_GROUP                       \
#              --location $LOCATION                                   \
#              --image $OS                                            \
#              --admin-username cdpadmin                              \
#              --nsg nsgcdpmst                                        \
#              --vnet-name vnetcdpcm                                  \
#              --subnet vnetcm                                        \
#              --private-ip-address $SUBNET_PREFIX_CM_GRP".10"      \
#              --size Standard_D2s_v3                                 \
#              --ssh-key-values $SSH_KEY_PATH                         \
#              --subscription $SUBSCRIPTION                           
# az vm open-port --port 22 --resource-group $RESOURCE_GROUP --name cdpcm 
# az vm auto-shutdown --location $LOCATION --name cdpcm --resource-group $RESOURCE_GROUP --time 2100  --subscription $SUBSCRIPTION

for i in 1
do
az vm create --name cdpmaster${i}                                   \
             --resource-group $RESOURCE_GROUP                       \
             --location $LOCATION                                   \
             --image $OS                                            \
             --admin-username cdpadmin                              \
             --nsg nsgcdpmst                                        \
             --vnet-name vnetcdpmst                                 \
             --subnet vnetmgt                                       \
             --private-ip-address $SUBNET_PREFIX_MASTER_GRP".1"$i    \
             --public-ip-address-dns-name cdpmaster${i}             \
             --size Standard_E2ds_v4                                  \
             --ssh-key-values $SSH_KEY_PATH                         \
             --subscription $SUBSCRIPTION
az vm open-port --port 22 --resource-group $RESOURCE_GROUP --name cdpmaster${i} --subscription $SUBSCRIPTION
az vm auto-shutdown --location $LOCATION --name cdpmaster${i} --resource-group $RESOURCE_GROUP --time 2100  --subscription $SUBSCRIPTION
done

for i in 1 2 3
do
az vm create --name cdpwks${i}                                   \
             --resource-group $RESOURCE_GROUP                       \
             --location $LOCATION                                   \
             --image $OS                                            \
             --admin-username cdpadmin                              \
             --nsg nsgcdpwks                                        \
             --vnet-name vnetcdpwks                                 \
             --subnet vnetwks                                       \
             --private-ip-address $SUBNET_PREFIX_WKS_GRP".1"$i    \
             --public-ip-address-dns-name cdpwks${i}                \
             --size Standard_D2s_v3                                   \
             --data-disk-sizes-gb 8                                 \
             --ssh-key-values $SSH_KEY_PATH                         \
             --subscription $SUBSCRIPTION
az vm open-port --port 22 --resource-group $RESOURCE_GROUP --name cdpwks${i} --subscription $SUBSCRIPTION 
az vm auto-shutdown --location $LOCATION --name cdpwks${i} --resource-group $RESOURCE_GROUP --time 2100  --subscription $SUBSCRIPTION 
done
