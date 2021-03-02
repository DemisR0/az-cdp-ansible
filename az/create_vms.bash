export SUBNET_PREFIX_CM_GRP='10.0.0'
export SUBNET_PREFIX_MASTER_GRP='10.0.1'
export SUBNET_PREFIX_WKS_GRP='10.0.2'
export MY_REMOTE_ACCESS='91.69.161.0/24'
export SSH_KEY_PATH='Azcdpcluster-public.pub/Azcdpcluster-public.pub'
export RESOURCE_GROUP='rsg-uks-cdp'

export SUBSCRIPTION='2510a5ab-472f-4c47-bd75-b1c74e40d957'
export LOCATION='uksouth'

#export OS='RedHat:rhel-byos:rhel-lvm79-gen2:7.9.20210126'
export OS='RedHat:RHEL:7_9:7.9.2020111301'
# creation des master servers

az vm create --name cdpcm                                           \
             --resource-group $RESOURCE_GROUP                       \
             --location $LOCATION                                   \
             --image $OS                                            \
             --location $LOCATION                                   \
             --admin-username cdpadmin                              \
             --nsg nsgcdpmst                                        \
             --vnet-name vnetcdpcm                                  \
             --subnet vnetcm                                        \
             --private-ip-address $SUBNET_PREFIX_CM_GRP".10"$i      \
             --size Standard_D2s_v3                                 \
             --ssh-key-values $SSH_KEY_PATH                         \
             --subscription $SUBSCRIPTION                           
az vm open-port --port 22 --resource-group rsg-uks-cdp --name cdpcm


for i in 1 2 
do
az vm create --name cdpmaster${i}                                   \
             --resource-group $RESOURCE_GROUP                       \
             --location $LOCATION                                   \
             --image $OS                                            \
             --location $LOCATION                                   \
             --admin-username cdpadmin                              \
             --nsg nsgcdpmst                                        \
             --vnet-name vnetcdpmst                                 \
             --subnet vnetmgt                                       \
             --private-ip-address $SUBNET_PREFIX_MASTER_GRP".1"$i    \
             --size Standard_B4ms                                   \
             --ssh-key-values $SSH_KEY_PATH                         \
             --subscription $SUBSCRIPTION
done

for i in 1 2 3 
do
az vm create --name cdpwks${i}                                   \
             --resource-group $RESOURCE_GROUP                       \
             --location $LOCATION                                   \
             --image $OS                                            \
             --location $LOCATION                                   \
             --admin-username cdpadmin                              \
             --nsg nsgcdpwks                                        \
             --vnet-name vnetcdpwks                                 \
             --subnet vnetwks                                       \
             --private-ip-address $SUBNET_PREFIX_WKS_GRP".1"$i    \
             --size Standard_D2s_v3                                   \
             --data-disk-sizes-gb 8                                 \
             --ssh-key-values $SSH_KEY_PATH                         \
             --subscription $SUBSCRIPTION
done
