
# Connect
$sub_id = "f58e161d-d1f4-41f8-b080-ee1fde6b4d3d" # az account show
$rs_group = "rg-aks-dev-westeu"
$aks_cluster = "aks-medlix-dev-westeu"
az login # login to azure (opens new browser window)
az account set --subscription $sub_id # Choose the correct subscription
az account show # Shows current connected subscription
az aks get-credentials --resource-group $rs_group --name $aks_cluster # Add info about cluster to config file
# Import-AzAksCredential -ResourceGroupName $rs_group -Name $aks_cluster

cd "$env:USERPROFILE\OneDrive - Erasmus MC\.repo\Infrastructure\Aks Cluster\mllp-http" # Jump to folder

# Parameters 
$Namespace = "ns-mllp-http-dev"
kubectl delete ns $Namespace # Delete the namespace
kubectl create ns $Namespace # Create the namespace

# Create the workload + services
kubectl create -n $Namespace -f .\service-mllp-http-public.yaml
kubectl create -n $Namespace -f .\deploy-mllp-http-app.yaml

# step 1: create method for sending messages to mllp-http -> ricardo?
# step 2: Find method for checking sent messages to proxy

connect-azuread
$object_id = "50ed4ac0-e5ab-4e4d-9b93-0f562da2a85e"
Get-AzureADServicePrincipal -objectid $object_id

