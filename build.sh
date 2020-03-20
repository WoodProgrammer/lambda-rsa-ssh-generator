#!/bin/bash

export OLD_PWD="$(pwd)"
export FULL_PATH="${OLD_PWD}/function.zip"

pushd v-env/lib/python3.7/site-packages
    zip -r9 ${FULL_PATH} .
popd

pwd

cp v-env/lambda_function.py .

zip -g function.zip lambda_function.py

rm lambda_function.py

pushd deploy
    terraform init
    terraform plan -var project=staging -var function_path=${FULL_PATH}
    terraform apply -var project=staging -var function_path=${FULL_PATH}
popd