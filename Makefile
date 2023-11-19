all: publish

build: gradle.properties
	echo "Building app"
	test -d /tmp/gradlecache || mkdir /tmp/gradlecache
	podman run -it -v $(shell pwd):/project -v /tmp/gradlecache:"/root/.gradle" mingc/android-build-box bash -c 'cd /project; bash ./gradlew build'

publish: build
	tree
