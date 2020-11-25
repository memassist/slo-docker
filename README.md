# Dockerized GCC-SLO (Suggestions for Locality Optimizations)

[![build](https://github.com/memassist/slo-docker/workflows/build/badge.svg)](https://github.com/memassist/slo-docker/actions)

A Dockerized version of GCC-SLO for easy installation and usage.

[GCC-SLO](https://sourceforge.net/projects/slo/files/gcc-slo/) is a
[data locality](https://en.wikipedia.org/wiki/Locality_of_reference) profiler and
[SLO](https://sourceforge.net/projects/slo/files/slo/) is a visualizer of the data analyzed by GCC-SLO.
SLO suggests refactorings that can improve the data locality of an input program. The documentation of SLO
can be found in [slo.sourceforge.net](http://slo.sourceforge.net/).

## Installation

Docker and Docker Compose should be installed in your system:

- Docker: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)
- Docker Compose: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Then use the following steps to install GCC-SLO.

### Use the pre-built Docker image

- Pull the image from the GitHub Container Registry:
```bash
docker pull ghcr.io/memassist/slo:latest
```

### Build the Docker image from source

Use the following steps to build the image from source instead of pulling the pre-built image.

- Download or clone this repository, go into the *slo-docker* directory and build the image:
``` bash
git clone git@github.com:memassist/slo-docker.git
cd slo-docker/slo
docker build -t ghcr.io/memassist/slo:latest --build-arg UID=1000 --build-arg GID=1000 .
cd ..
```

## Getting started

The directory *examples/example1/* contains an example input C program taken from the
[SLO Handbook](http://slo.sourceforge.net/dochtml/ch04s03.html) to help you get started.
*example1* and its *Makefile* can be used as a template for your own projects. The structure of the Makefile
is explained here: [http://slo.sourceforge.net/dochtml/ch04s03.html](http://slo.sourceforge.net/dochtml/ch04s03.html).
Follow the instructions below to start analyzing the example program using GCC-SLO.

- Make sure you downloaded or cloned this repository and are inside the *slo-docker* directory.
``` bash
git clone git@github.com:memassist/slo-docker.git
cd slo-docker
```

- Start the *slo* Docker container:
``` bash
docker-compose up -d
```

- Start a *bash* shell in the container:
``` bash
docker exec -it slo bash
```

- From this shell, navigate to the *example1* project directory:
``` bash
cd ~/examples/example1
```

- Use *[make](https://en.wikipedia.org/wiki/Makefile)* to instrument the project, build it and perform dynamic analysis:
``` bash
make clean
make
```

The file *example1.slo.zip* is generated after *make* finishes. Open this file with the
[SLO visualizer](https://sourceforge.net/projects/slo/files/slo/) to view the results and the suggested refactorings.

## References

For more information on SLO and how it works refer to:

- [SLO's website](http://slo.sourceforge.net/)
- [Principles of analysis performed by SLO](http://slo.sourceforge.net/principles.php)
- The documentation [ [pdf](http://slo.sourceforge.net/slo_doc.pdf) ] [ [html](http://slo.sourceforge.net/dochtml/) ] (aka The SLO Handbook)

## License

This project is licensed under the GPL-2.0 License - see the [LICENSE](LICENSE) file for details.
