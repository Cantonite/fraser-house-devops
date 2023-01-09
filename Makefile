init:
	@terraform -chdir=stack init

apply: init
	@terraform -chdir=stack apply -auto-approve -var-file=../variables/dev.tfvars

destroy:
	@terraform -chdir=stack destroy -auto-approve -var-file=../variables/dev.tfvars

qr:
	@mkdir -p .output
	@URL=$$(terraform -chdir=stack output -json | jq -r '.website_url.value') python qr.py