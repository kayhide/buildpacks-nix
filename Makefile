all: buildpacks/empty.cnb run-image build-image builder
.PHONY: all


buildpacks/empty.cnb: buildpacks/empty-package.toml $(shell find buildpacks/empty -type f)
buildpacks/empty.cnb:
	cd buildpacks && \
	pack package-buildpack empty.cnb --config ./empty-package.toml --format file

run-image: images/Dockerfile.run
	cd images && \
	docker build -t buildpacks-nix-run -f ./Dockerfile.run .
.PHONY: run-image

build-image: images/Dockerfile.build
	cd images && \
	docker build -t buildpacks-nix-build -f ./Dockerfile.build .
.PHONY: build-image

builder:
	pack create-builder buildpacks-nix/builder --config ./builder.toml
.PHONY: builder


samples: samples-app-bash
.PHONY: samples

samples-app-bash:
	cd samples/app-bash && \
	pack build buildpacks-nix-samples-app-bash --builder buildpacks-nix/builder
.PHONY: samples-app-bash
