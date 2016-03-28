# Docker-TeX2PDF

Provides a Docker container for watching a .tex-file, and produce a PDF when it changes.

## Getting started

Simply pull the image from the Docker Hub to get started
```sh
docker pull amlinger/tex2pdf
```

### Building the Image

_This is only necessary if you are into tweaking the configuration of this project._

With your Docker Machine up and running, and standing in the repo folder, issue
```sh
docker build -t tex2pdf .
```
(This will also tag your image with `tex2pdf`, which is optional).

## Usage

To get a tex-file called `current.tex` to be watched, and compiled to `current.pdf` on each update, use 

```sh
docker run -d -v $PWD:/tex-files/ -e FILENAME current tex2pdf
```
