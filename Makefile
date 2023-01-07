tf_init:
	@terraform -chdir=stack init

tf_apply_dev:
	@terraform -chdir=stack apply -auto-approve -var-file=../variables/dev.tfvars

tf_destroy_dev:
	@terraform -chdir=stack destroy -auto-approve -var-file=../variables/dev.tfvars

generate_qr_dev:
	@FUNCTION_URL=$(terraform -chdir=stack output -json | jq -r '.function_url.value') python qr.py