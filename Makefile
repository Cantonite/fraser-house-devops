init:
	@terraform -chdir=environments/$(ENV_NAME) init

apply:
	@terraform -chdir=environments/$(ENV_NAME) apply -auto-approve

destroy:
	@terraform -chdir=environments/$(ENV_NAME) destroy -auto-approve

deploy_test: ENV_NAME=test
deploy_test: init apply
	@echo "Test Deployed"

deploy_live: ENV_NAME=live
deploy_live: init apply
	@echo "Live Deployed"

qr:
	@mkdir -p .output
	@URL=$$(terraform -chdir=environments/$(ENV_NAME) output -json | jq -r '.website_url.value') python qr.py