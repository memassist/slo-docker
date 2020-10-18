# Dockerized GCC-SLO (Suggestions for Locality Optimizations)

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

### Pull the pre-built Docker image from Docker Hub

// TODO

### Build the Docker image from source

- Download or clone this repository:
``` bash
git clone git@github.com:memassist/slo-docker.git
```

- Go into the *slo-docker* directory:
``` bash
cd slo-docker
```

- Build the image:
``` bash
docker-compose build --no-cache
```

## Usage / Getting started

The directory *examples/example1/* contains an example input C program taken from the
[SLO Handbook](http://slo.sourceforge.net/dochtml/ch04s03.html) to help you get started.
*example1* and its *Makefile* can be used as a template for your own projects. The structure of the Makefile
is explained here: [http://slo.sourceforge.net/dochtml/ch04s03.html](http://slo.sourceforge.net/dochtml/ch04s03.html).
Follow the instructions below to start analyzing the example program using GCC-SLO.

- Make sure you are inside the *slo-docker* directory.

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
- [Principles of Analysis performed by SLO](http://slo.sourceforge.net/principles.php)
- The documentation [ [pdf](http://slo.sourceforge.net/slo_doc.pdf) ] [ [html](http://slo.sourceforge.net/dochtml/) ] (aka The SLO Handbook)

## License

This project is licensed under the GPL-2.0 License - see the [LICENSE](LICENSE) file for details.
