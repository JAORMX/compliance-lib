# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build  --buildmode=c-shared
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BUILD_DIR=build
LIBRARY_NAME=libopenshiftcompliance
SHARED_LIBRARY_NAME=$(BUILD_DIR)/$(LIBRARY_NAME).so
HEADER_FILE_NAME=$(BUILD_DIR)/$(LIBRARY_NAME).h
BINARY_UNIX=$(BINARY_NAME)_unix

.PHONY: build test clean

all: test build
build: 
	GO111MODULE=on $(GOBUILD) -o $(SHARED_LIBRARY_NAME) -v lib.go
test: 
	$(GOTEST) -v ./...
clean: 
	$(GOCLEAN)
	rm -f $(SHARED_LIBRARY_NAME) $(HEADER_FILE_NAME)
# We don't have to run this just yet
# run:
# 	$(GOBUILD) -o $(BINARY_NAME) -v ./...
# 	./$(BINARY_NAME)

# Dependencies are managed by Go mod.
deps:
	GO111MODULE=on go mod vendor
