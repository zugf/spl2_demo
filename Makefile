SHELL := /bin/bash

.PHONY : create-rest-token
create-rest-token:
	@SESSIONTOKEN=$$(curl -k -u admin:splunkdev https://127.0.0.1:8089/services/auth/login -d username=admin -d password=splunkdev | grep -oPm1 "(?<=<sessionKey>)[^<]+") ; \
	TOKEN_RESPONSE=$$(curl -k -s  -H "Authorization: Bearer $$SESSIONTOKEN" -X POST https://localhost:8089/services/authorization/tokens?output_mode=json --data name=admin --data audience=web) ; \
	TOKEN=$$(echo $$TOKEN_RESPONSE | sed -nr 's/.*token"."([^"]*)".*/\1/p') ; \
	echo $$TOKEN ; \
	jq --arg token "$$TOKEN" '.["splunk.commands.token"]=$$token' .vscode/settings.json > temp.json && mv temp.json .vscode/settings.json

.PHONY: link_apps
link_apps:
	@source_dir="$${PWD}/apps"; \
	target_dir="$${SPLUNK_HOME}/etc/apps"; \
	for subdir in "$$source_dir"/*; do \
		if [ -d "$$subdir" ]; then \
			base_name=$$(basename "$$subdir"); \
			echo link "$$subdir -> $$target_dir/$$base_name"; \
			ln -s -f "$$subdir" "$$target_dir/$$base_name"; \
		fi \
	done

.PHONY : finalize-setup
finalize-setup:
finalize-setup:
	# make link_apps
	# splunk start --accept-license --answer-yes --no-prompt --seed-passwd $$SPLUNK_PASSWORD
	make create-rest-token	

clean-devcontainer:
	docker container rm dev_spl2demo || true
	docker volume rm spl2demo_etc || true
	docker volume rm spl2demo_var || true

.PHONY: create_app_packages
create_app_packages:
	@src_dir="apps"; \
	target_dir="deploy/apps"; \
	mkdir -p "$$target_dir"; \
	cd "$$src_dir"; \
	for dir in */; do \
	  base=$$(basename "$$dir"); \
	  tar -czf "../$$target_dir/$$base.tar.gz" "$$dir"; \
	done