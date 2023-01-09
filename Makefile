init:
	@terraform -chdir=environments/$$ENV_NAME init

apply: init
	@terraform -chdir=environments/$$ENV_NAME apply -auto-approve

destroy:
	@terraform -chdir=environments/$$ENV_NAME destroy -auto-approve

qr:
	@mkdir -p .output
	@URL=$$(terraform -chdir=environments/$$ENV_NAME output -json | jq -r '.website_url.value') python qr.py