SHELL = /bin/bash
PRE-COMMIT := $(shell which pre-commit)
# The test_runner needs this in order to find its shell libraries.
export LIB_DIR := $(shell pwd)/lib

all: .prereqs.stamp pre-commit test

test:
	pushd tests > /dev/null && ./test_runner -s /bin/bash

# Shortcut to run pre-commit hooks over the entire repo.
pre-commit: .git/hooks/pre-commit
	pre-commit run --all-files

# Update the pre-commit hooks if the pre-commit binary is updated.
.git/hooks/pre-commit: $(PRE-COMMIT)
	pre-commit install

# Re-check prereqs if the prereqs configuration is newer than the last time
# we checked.
.prereqs.stamp: etc/prereqs.conf
	bin/prereqs -c etc/prereqs.conf
	touch .prereqs.stamp

clean:
	rm -f .*.stamp

.PHONY: all clean pre-commit
