OUTPUT=$(shell bundle exec rbprettier '**/*.rb')

pretty:
	bundle exec rbprettier --write '**/*.rb'

pretty_check:
ifneq ($(OUTPUT), "")
	@echo $( OUTPUT )
	@echo "prettier errors found"
	@exit 1
endif
