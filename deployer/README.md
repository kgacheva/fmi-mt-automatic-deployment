# deployer

## Set up secrets for the deployer

All secrets to be used in a deployment need to be included in a dedicated .tfvars file under the common _private_ directory or exported as environment variables before running the deployer.

## Run the deployer

To initialize the working directory from the root of the _deployer_ project:
```
terraform -chdir=modules/<ENVIRONMENT>/<DEPLOYMENT> init
```
e.g.:
```
$ terraform -chdir=modules/azure/builder-worker init
```

To generate and show the plan for the deployment:
```
terraform -chdir=modules/<ENVIRONMENT>/<DEPLOYMENT> plan -var-file=<relative path to tfvars file>
```
e.g.:
```
$ terraform -chdir=modules/azure/builder-worker plan -var-file=../../../configurations/azure/mt_playground.tfvars -var-file=../../../private/az_secrets.tfvars
```

To put the plan as shown by the previous command in action and create/update the infrastructure:
```
terraform -chdir=modules/<ENVIRONMENT>/<DEPLOYMENT> apply -var-file=<relative path to tfvars file>
```

### On the state for the deployer

Terraform would write the state of the infrastructure in a `terraform.tfstate` file within the directory for the specific deployment which gets applied. Those states are stored locally and not tracked as part of the repository. To make sure no inconstistencies appear between the actual and desired state for the infrastructure, do not introduce any manual changes to it after running the deployer.

To inspect the state which Terraform knows for a given deployment:
```
terraform -chdir=modules/<ENVIRONMENT>/<DEPLOYMENT> show
```
or list the resources:
```
terraform -chdir=modules/<ENVIRONMENT>/<DEPLOYMENT> state list
```
e.g.:
```
$ terraform -chdir=modules/azure/builder-worker show
$ terraform -chdir=modules/azure/builder-worker state list
```
