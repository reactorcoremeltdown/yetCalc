all: build

build: gradle.properties
	echo "Building app"
	apt install tree
	test -d /tmp/gradlecache || mkdir /tmp/gradlecache
	podman run -it -v $(shell pwd):/project -v /tmp/gradlecache:"/root/.gradle" mingc/android-build-box bash -c 'cd /project; bash ./gradlew build'

publish:
	rm -fr /var/lib/fdroid/unsigned/*
	mv /var/storage/wastebox/Backups/app-release-unsigned.apk /var/lib/fdroid/unsigned/yetzio.yetcalc_$(shell date +%s).apk
	touch /var/lib/fdroid/metadata/yetzio.yetcalc.yml
	cd /var/lib/fdroid && /opt/fdroidserver/fdroid publish --verbose && /opt/fdroidserver/fdroid update --verbose
