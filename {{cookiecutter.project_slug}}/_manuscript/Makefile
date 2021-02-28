all: clean build render remove-build

clean:
	rm -Rf _build/; rm -Rf _site/
	
build:
	./_make-site.sh build

render:
	./_make-site.sh render

remove-build:
	rm -Rf _build

preview:
	./_compose-manuscript.sh
