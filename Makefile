tf_init:
	@terraform -chdir=stack init

tf_apply_dev:
	@terraform -chdir=stack apply -auto-approve -var-file=../variables/dev.tfvars

tf_destroy_dev:
	@terraform -chdir=stack destroy -auto-approve -var-file=../variables/dev.tfvars

generate_qr_dev:
	@mkdir -p .output
	@URL=$$(terraform -chdir=stack output -json | jq -r '.website_url.value') python qr.py