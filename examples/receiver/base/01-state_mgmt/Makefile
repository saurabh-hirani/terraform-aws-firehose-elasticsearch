.PHONY: all plan apply destroy

all: help

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'

help:						## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

get:		 		## Get the terraform modules
	terraform get

init:				## Initialize local tfstate
	terraform init 

plan:				## Plan the changes to infra.
	terraform plan -out tfplan -var-file=../../common.tfvars

apply:				## Apply the changes in plan.
	terraform apply tfplan 

refresh:			## Refresh the remote state with existing AWS infra.
	terraform refresh -var-file=../../common.tfvars

output:				## See the output.
	terraform output -json

destroy:			## Destroy the infra. (BE VERY CAREFUL with THIS).
	terraform destroy -var-file=../../common.tfvars
