PRODUCT_NAME=SpellChecker
SCHEME_NAME=SpellChecker
PROJECT_NAME=SpellChecker.xcodeproj

TEMPORARY_FOLDER=/tmp/$(SCHEME_NAME)/.dst

XCODEFLAGS=-project '$(PROJECT_NAME)' -scheme '$(SCHEME_NAME)' DSTROOT=$(TEMPORARY_FOLDER)

BINARIES_FOLDER=/usr/local/bin
BINARY_PATH=$(BINARIES_FOLDER)/$(PRODUCT_NAME)
FRAMEWORK_PATH=$(BINARIES_FOLDER)/$(PRODUCT_NAME)Core.framework

.PHONY: all clean install uninstall

all:
	xcodebuild $(XCODEFLAGS) build

clean:
	rm -rf "$(TEMPORARY_FOLDER)"
	xcodebuild $(XCODEFLAGS) clean

install: clean
	mkdir -p $(TEMPORARY_FOLDER)
	xcodebuild $(XCODEFLAGS) install
	cp -R $(TEMPORARY_FOLDER)$(BINARIES_FOLDER)/* $(BINARIES_FOLDER)/
	rm -rf "$(TEMPORARY_FOLDER)"

uninstall:
	rm -rf "$(BINARY_PATH)"
	rm -rf "$(FRAMEWORK_PATH)"
