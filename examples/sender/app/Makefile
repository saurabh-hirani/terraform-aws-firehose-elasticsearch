.PHONY: all get plan apply destroy

all: init get plan apply

init: check-env
	terraform init -backend=true -backend-config="bucket=${TF_STATE_S3}" -backend-config="key=infra.tfstate"

get:
	terraform get

plan:
	terraform plan -var-file=../common.tfvars -out=tfplan

apply:
	terraform apply -auto-approve tfplan

refresh:
	terraform refresh -var-file=../common.tfvars

output:
	terraform output -json

destroy:
	terraform destroy -auto-approve -var-file=../common.tfvars

check-env:
ifndef TF_STATE_S3
	$(error Terraform S3 state bucket - TF_STATE_S3 is not defined)
endif
