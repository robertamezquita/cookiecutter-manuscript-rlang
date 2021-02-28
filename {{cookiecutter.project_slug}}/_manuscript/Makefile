all: clean build render remove-build

clean:
	rm -Rf _build/; rm -Rf _site/
	
build:
	./.make-site.sh build

render:
	./.make-site.sh render

remove-build:
	rm -Rf _build
