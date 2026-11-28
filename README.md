GNU Radio Docker Containers
---------------------------

This repository, the GNU Radio project keeps the docker containers for the CI that builds GNU Radio and runs tests, every time someone makes a pull request against the GNU Radio code base.

The organization is such that you find the individual containers in directories below ci/, generally named `distro-distro version-GNU Radio version`.

For the containers that get re-built on PRs and commits to this repo itself, see .github/workflows/build-dockers.yml . When making a PR for a new worker, don't forget to include that in that file! If the worker is not an amd64 image (like the 32-bit Debian builders, which are based on `i386/debian`), also set `platforms` (e.g., `linux/386`) on its matrix entry, so the published image carries the right platform.

Workers that are published for both `linux/amd64` and `linux/arm64` (currently
the native GNU Radio 4 ones) are listed by tag in the
`build-and-push-multiarch-image` job instead; the `merge-multiarch-manifest`
job reads the same list. Their Dockerfile has to be `ci/ci-<tag>/Dockerfile`.
Each architecture is built natively on its own runner, so the Dockerfile has to
build on both, and can't download binaries for one specific architecture.

Published images
----------------

On pushes to `master`, the workflow pushes every container to Docker Hub as
`gnuradio/ci:<tag>` and to the GitHub Container Registry as
`ghcr.io/gnuradio/ci:<tag>`, with the `<tag>` it has in build-dockers.yml
(e.g., `gnuradio/ci:debian-14-3.11`). Pull requests only build the containers.
The CI workflows of GNU Radio and GNU Radio 4 pull them by these names, so
`docker run -it --rm gnuradio/ci:<tag>` gets you the environment a CI job runs
in.

The multi-architecture containers are pushed as `<tag>-amd64` and
`<tag>-arm64` first. Once all of them have built, `<tag>` is written as a
manifest list of the two, so pulling `<tag>` gets the image for the host's
architecture. If any of those builds fails, none of the plain tags is updated.

Building a container locally
----------------------------

The workflow uses the repository root as build context. To build a container
yourself, run, from the repository root, e.g.:

    docker build -f ci/ci-debian-14-3.11/Dockerfile -t gnuradio-ci:debian-14-3.11 .

Add `--platform linux/386` for the 32-bit Debian containers, like the workflow
does. Many of the Dockerfiles first compile sccache from source in a separate
stage, which takes a while.

Making PRs
----------

If you have push access to unprotected branches on this repo, feel encouraged
to push your branch as `username/branchname` to the gnuradio/gnuradio-docker
and make a PR from there. This has the advantage that you get to use our docker
layer/artifact caching, which means that unchanged steps Dockerfiles build
within seconds instead of minutes.

Pulling in distribution updates
-------------------------------

With the layer cache, a Dockerfile step only runs again when it, a step before
it, or the base image changed. To rebuild a container with its distribution's
current packages anyway, bump the date in the `ENV security_updates_as_of=...`
line that most Dockerfiles have at the start of their main stage; that changes
the cache key of every step after it.
