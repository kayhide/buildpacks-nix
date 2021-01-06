image-build: images/Dockerfile.build
	cd images && docker build -t nix-builder:build -f ./Dockerfile.build .

image-run: images/Dockerfile.run
	cd images && docker build -t nix-builder:run -f ./Dockerfile.run .

empty-buildpack:
	cd buildpacks && \
	pack package-buildpack empty.cnb --config ./empty-package.toml --format file

builder:
	pack create-builder nix-builder --config ./builder.toml
