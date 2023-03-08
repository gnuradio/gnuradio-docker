# GNU Radio Docker Images

This repository contains a range of GNU Radio-related Docker images.

- [GNU Radio Docker Images](#gnu-radio-docker-images)
  - [CI Builders](#ci-builders)
  - [OOT Development Environment](#oot-development-environment)
    - [Base Image for OOT Module](#base-image-for-oot-module)
    - [Multiple GNU Radio Versions in Parallel](#multiple-gnu-radio-versions-in-parallel)
    - [OOT Development Inside Container](#oot-development-inside-container)
    - [Github Workflows](#github-workflows)
    - [VSCode Devcontainer](#vscode-devcontainer)
  - [PyBOMBS Development](#pybombs-development)


## CI Builders

The CI builders are the base images used on CI jobs, such as the workflows used in the [gnuradio/gnuradio](https://github.com/gnuradio/gnuradio/tree/main/.github/workflows) project to run tests and build packages.

## OOT Development Environment

The `oot-dev` image provides a container environment for building, testing, and running GNU Radio out-of-tree (OOT) modules. The following examples demonstrate a few use cases for this image:

### Base Image for OOT Module

The `oot-dev` image can serve as the base image when building a dedicated image for an OOT module. For example, consider the following Dockerfile:

```Dockerfile
ARG tag=3.10.3-ubuntu-focal
FROM gnuradio/oot-dev:$tag
# List of dependencies for your GR OOT module.
ARG deps
# OOT repository URL and name:
ARG oot_url
ARG oot_name
# Install dependencies
RUN apt-get install -y $deps
# Install the OOT module
RUN git clone --recursive $oot_url && \
    cd $oot_name && mkdir build && cd build/ && \
    cmake .. && \
    cmake --build . && \
    cmake --install . && \
    ldconfig && \
    cd ../../ && rm -r $oot_name
```

Suppose the above Dockerfile is saved on a file named `oot.dockerfile`. In this case, for example, to build an image for the [gr-dvbs2rx project](https://github.com/igorauad/gr-dvbs2rx/), run:

```bash
docker build -f oot.dockerfile -t gr-dvbs2rx \
  --build-arg tag=3.10.5.1-ubuntu-jammy \
  --build-arg deps="libusb-1.0-0-dev libosmosdr-dev libsndfile1-dev" \
  --build-arg oot_url=https://github.com/igorauad/gr-dvbs2rx/ \
  --build-arg oot_name=gr-dvbs2rx \
  .
```

For a more advanced use case, refer to the actual [Dockerfile](https://github.com/igorauad/gr-dvbs2rx/blob/master/Dockerfile) used on the gr-dvbs2rx project.

### Multiple GNU Radio Versions in Parallel

The `oot-dev` image can be a convenient solution for running multiple GNU Radio versions in parallel on reproducible environments. For example, you can launch multiple containers with different GNU Radio
versions, as follows:

```bash
docker run --name gr3.8 gnuradio/oot-dev:3.8.2-ubuntu-bionic
```

```bash
docker run --name gr3.9 gnuradio/oot-dev:3.9.4-ubuntu-focal
```

```bash
docker run --name gr3.10 gnuradio/oot-dev:3.10.5.1-ubuntu-jammy
```

If you would like to run GUI applications inside these containers, such as `gnuradio-companion`, consider defining aliases like so:

Linux
```bash
alias docker-gui='docker run --env="DISPLAY" -v $HOME/.Xauthority:/root/.Xauthority --network=host'
```

OSX
```bash
alias docker-gui='docker run --env="DISPLAY=host.docker.internal:0"'
```

Then, run `docker-gui` instead of `docker run`. Also, in the case of OSX, you also need to authorize the container to access the host's X server:

```bash
xhost + localhost
```

### OOT Development Inside Container

The `oot-dev` image can be convenient for OOT development in general. For example, you can keep the OOT sources on the host while developing, building, and installing binaries inside the container. To do so, you can extend the commands explained in the previous section by adding a [bind mount option](https://docs.docker.com/engine/reference/run/#volume-shared-filesystems). Assuming you have the OOT sources in your host at `$HOME/src/my-oot/`, you can run the container as follows:

```bash
docker run --rm -it \
  -v $HOME/src/my-oot/:/src/my-oot/ \
  gnuradio/oot-dev:3.10.5.1-ubuntu-jammy
```

Option `-v $HOME/src/my-oot/:/src/my-oot/` creates a bind-mount at `/src/my-oot/` inside the container, which you can use to access the OOT files. Any changes made in this directory are automatically reflected back to the host. For example, inside the container, build the OOT as follows:

```bash
cd /src/my-oot/
mkdir -p build/
cmake ..
make
```

### Github Workflows

The `oot-dev` image is also useful for setting up Github workflows on your OOT module's repository, such as the following workflow:

```yml
name: Test
on: [push, pull_request]
env:
  BUILD_TYPE: Release
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: gnuradio/oot-dev:3.10.5.1-ubuntu-jammy
    steps:
    - uses: actions/checkout@v2
    - name: Configure CMake
      run: cmake -B ${{github.workspace}}/build -DCMAKE_BUILD_TYPE=${{env.BUILD_TYPE}}
    - name: Build
      run: cmake --build ${{github.workspace}}/build --config ${{env.BUILD_TYPE}}
    - name: Test
      run: cd ${{github.workspace}}/build && ctest -C ${{env.BUILD_TYPE}} -VV
```

For reference, refer to the workflow used on [gr-dvbs2rx](https://github.com/igorauad/gr-dvbs2rx/blob/master/.github/workflows/test.yml).

### VSCode Devcontainer

Finally, the `oot-dev` image also facilitates OOT development inside [devcontainers on VSCode](https://code.visualstudio.com/docs/remote/containers). All you need to do is install the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension, create a `.devcontainer/devcontainer.json` file in your project, and reopen the workspace inside the container. The `devcontainer.json` file should specify the image as follows:

```json
{
  "image": "gnuradio/oot-dev:tag"
}
```

where `tag` should be replaced by one of the [available tags](https://hub.docker.com/r/gnuradio/oot-dev/tags).

Furthermore, if you would like to run GUI applications (e.g., `gnuradio-companion`) directly from the VSCode terminal, you can append the following to your `devcontainer.json` file:

Linux
```json
{
  ...
  "runArgs": [
    "-v $HOME/.Xauthority:/root/.Xauthority",
    "--network=host"
  ],
  "containerEnv": {
    "DISPLAY": "$DISPLAY"
  }
}
```

OSX
```json
{
  ...
  "containerEnv": {
    "DISPLAY": "host.docker.internal:0"
  }
}
```

## PyBOMBS Development

The `pybombs-dev` image allows for testing PyBOMBS installation on CI. See, for example, its usage on the [gr-etcetera](https://github.com/gnuradio/gr-etcetera) project.