#!/bin/bash

archive_name=${1:-certificates}

ls -1 | grep -v ".sh" | grep -v ".cnf" | grep -v ".md" | zip ${archive_name} -@
