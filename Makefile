all: publish

build: gradle.properties
	echo "Building app"
	apt install tree
	test -d /tmp/gradlecache || mkdir /tmp/gradlecache
	podman run -it -v $(shell pwd):/project -v /tmp/gradlecache:"/root/.gradle" mingc/android-build-box bash -c 'cd /project; bash ./gradlew build'

publish: build
	find . -name '*.apk'
