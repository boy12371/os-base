TARGETS := $(shell ls scripts | grep -vE 'clean|run|help|config')

.dapper:
	@echo Downloading dapper
	@curl -sL https://github.com/boy12371/dapper/releases/download/v0.5.4/dapper-`uname -s`-`uname -m|sed 's/v7l//'` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	./.dapper $@ 2>&1 | tee $@.log

config: .dapper
	./.dapper config

shell-bind: .dapper
	./.dapper -m bind -s

help:
	@./scripts/help

.DEFAULT_GOAL := ci

.PHONY: $(TARGETS) config
