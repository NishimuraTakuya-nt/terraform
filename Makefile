.PHONY: init plan apply destroy fmt validate lint sec

# dev | prod | common
ENV ?= dev

init:
	terraform -chdir=./env/$(ENV) init

plan:
	terraform -chdir=./env/$(ENV) plan

apply:
	terraform -chdir=./env/$(ENV) apply

destroy:
	terraform -chdir=./env/$(ENV) destroy

fmt:
	terraform fmt -recursive

validate:
	find . -type f -name "*.tf" -exec dirname {} \;|sort -u | while read m; do (terraform validate "$$m" && echo "√ $$m") || echo "× $$m"; done

lint:
	tflint --recursive

sec:
	tfsec .

check: fmt validate lint sec
	echo "All checks passed!"

docs:
	terraform-docs markdown table --output-file README.md --output-mode inject env/$(ENV)

clean:
	find . -type d -name ".terraform" -exec rm -rf {} +
	find . -type f -name "*.tfstate*" -exec rm -rf {} +