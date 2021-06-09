
all: clean build render remove-rmd

clean:
	rm -Rf _site/
	
build:
	./_make-site.sh build

render:
	./_make-site.sh render

remove-rmd:
	rm *.Rmd