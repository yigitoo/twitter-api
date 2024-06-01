all: default
default: run
install:
	bundle install

run:
	ruby main.rb

.PHONY: all defualt install run