.PHONY: tests doc

tests:
	busted tests

doc:
	ldoc .