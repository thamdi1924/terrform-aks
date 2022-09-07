authenticate service principal to azure


$env:ARM_CLIENT_ID="4de7239e-8e8a-46d7-869f-5ab97e81e3df"
$env:ARM_SUBSCRIPTION_ID="b2cb661a-f958-440c-b39d-6d0a0b28de4c"
$env:ARM_TENANT_ID="350ffe67-1872-4323-ae90-be3e70195eb1"
$env:ARM_CLIENT_SECRET="EXU-Bo8JG95n_qxX9Xu3Ob5ngvmbR_UYgr"


verify environmental variables

gci env:ARM_*print


az ad sp create-for-rbac --name terraform-sp1 --role Contributor --scopes /subscriptions/b2cb661a-f958-440c-b39d-6d0a0b28de4c 

https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli

az login --service-principal --username terraform-sp1 --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

az login --use-device-code