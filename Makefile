all:  stamps cpp-minimal python-minimal

stamps:
	mkdir -p stamps

stamps/cppdeps.stamp: gnuradio-cppdeps/Dockerfile
	docker build -f gnuradio-cppdeps/Dockerfile -t gnuradio/gnuradio-cppdeps gnuradio-cppdeps
	@touch stamps/cppdeps.stamp

cppdeps: stamps/cppdeps.stamp

stamps/pydeps.stamp: gnuradio-pydeps/Dockerfile
	docker build -f gnuradio-pydeps/Dockerfile -t gnuradio/gnuradio-pydeps gnuradio-pydeps
	@touch stamps/pydeps.stamp

pydeps: cppdeps stamps/pydeps.stamp

stamps/builddeps.stamp: gnuradio-builddeps/Dockerfile
	docker build -f gnuradio-builddeps/Dockerfile -t gnuradio/gnuradio-builddeps gnuradio-builddeps
	@touch stamps/builddeps.stamp

builddeps: pydeps stamps/builddeps.stamp

stamps/builder.stamp: gnuradio-builder/Dockerfile
	docker build -f gnuradio-builder/Dockerfile -t gnuradio/gnuradio-builder gnuradio-builder
	@touch stamps/builder.stamp

builder: builddeps stamps/builder.stamp

stamps/cpp-prefix.stamp: stamps/builder.stamp
	CPPONLY=YES PREFIX=${PWD}/gnuradio-cpp-minimal/prefix ./run-builder.sh
	touch stamps/cpp-prefix.stamp

cpp-prefix: builder stamps/cpp-prefix.stamp

stamps/cpp-minimal.stamp: gnuradio-cpp-minimal/Dockerfile
	docker build -f gnuradio-cpp-minimal/Dockerfile -t gnuradio/gnuradio-cpp-minimal gnuradio-cpp-minimal
	@touch stamps/cpp-minimal.stamp

cpp-minimal: cpp-prefix stamps/cpp-minimal.stamp

stamps/prefix.stamp:
	PREFIX=${PWD}/gnuradio-python-minimal/prefix ./run-builder.sh
	touch stamps/prefix.stamp

prefix: builder stamps/prefix.stamp

stamps/python-minimal.stamp: gnuradio-python-minimal/Dockerfile
	docker build -f gnuradio-python-minimal/Dockerfile -t gnuradio/gnuradio-python-minimal gnuradio-python-minimal
	touch stamps/python-minimal.stamp

python-minimal: prefix stamps/python-minimal.stamp

clean:
	@rm -rf work/prefix/*
	@rm -rf work/build/*
	@rm -rf gnuradio-cpp-minimal/prefix
	@rm -rf stamps/*
	@find -type f -name '*~' -delete
