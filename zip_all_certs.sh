#!/bin/bash

archive_name=${1:-certificates}

zip "${archive_name}" "*.pem" "*.jks" "*.pkcs12"

