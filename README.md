GNU Radio Docker Containers
---------------------------

This repository, the GNU Radio project keeps the docker containers for the CI that builds GNU Radio and runs tests, every time someone makes a pull request against the GNU Radio code base.

The organization is such that you find the individual containers in directories below ci/, generally named `distro-distro version-GNU Radio version`.

For the containers that get re-built on PRs and commits to this repo itself, see .github/workflows/build-dockers.yml . When making a PR for a new worker, don't forget to include that in that file!
