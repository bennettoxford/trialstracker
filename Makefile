export DOCKER_BUILDKIT=1

build:
	docker build . -t trialstracker

.PHONY: dist
static-site:
	# Install npm dependencies and build the main.js file
	cd app/js && npm ci && npm run build

	# Copy app contents into dist, preserving file attributes and keeping only
	# main.js in js; remove stale and excluded files.
	rsync \
		--archive \
		--delete \
		--delete-excluded \
		--include='/js/main.js' \
		--exclude='/js/*' \
		app/ dist/

test:
	cd app/js && npm ci && npm run test
