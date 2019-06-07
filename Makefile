# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build  --buildmode=c-shared
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BUILD_DIR=build
NAME=openshiftcompliance
LIBRARY_NAME=lib$(NAME)
SHARED_LIBRARY_NAME=$(BUILD_DIR)/$(LIBRARY_NAME).so
HEADER_FILE_NAME=$(BUILD_DIR)/$(LIBRARY_NAME).h
PKG_CONFIG=$(NAME).pc
PKG_CONFIG_DIR=$(realpath $(BUILD_DIR))

.PHONY: build test clean

all: test build
build: 
	GO111MODULE=on $(GOBUILD) -o $(SHARED_LIBRARY_NAME) -v lib.go
	sed -e 's|@PREFIX@|$(PKG_CONFIG_DIR)|' $(PKG_CONFIG).in > $(BUILD_DIR)/$(PKG_CONFIG)
test: 
	$(GOTEST) -v ./...
clean: 
	$(GOCLEAN)
	rm -f $(SHARED_LIBRARY_NAME) $(HEADER_FILE_NAME)
	rm -f $(BUILD_DIR)/$(PKG_CONFIG)

# Dependencies are managed by Go mod.
deps:
	GO111MODULE=on go mod vendor
