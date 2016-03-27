Apache Zeppelin on Docker
==========

This repo contains a Dockerfile to build a Docker image with Zeppelin and Apache Spark. It depends on [Spark Docker](https://github.com/sequenceiq/docker-spark) image by sequenceiq.

## Building the image
```
docker build -t alghimo/docker-zeppelin:latest .
```

## Running the image
*Important*: If you are on Windows:
- Increase the memory of the VM that your docker is using. To test this, I increased the memory to 4GB. If you can increase the number of CPUs, do it as well.
- Enable port forwarding, it will make it easier to access Zeppelin.

```
docker run -it -p 9995:9995 -h zeppelin --name zeppelin alghimo/docker-zeppelin:latest bash
```
or
```
docker run -d -h zeppelin --name zeppelin alghimo/docker-zeppelin:latest
```
In case you want to open some extra ports for the UI, etc: -p 8088:8088 -p 8042:8042 -p 4040:4040

## Versions
```
Hadoop 2.6.0, Apache Spark v1.6.0 and latest Zeppelin on Centos. Zeppelin is cloned and build when building the image.
```

## Testing

Once running, just browse to http://localhost:9995.
