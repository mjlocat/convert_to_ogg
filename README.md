# convert_to_ogg
Converts various audio formats to OGG

## Prerequisites
- [ffmpeg](https://ffmpeg.org/)
- [libvorbis](https://xiph.org/vorbis/)
- Whatever extras are required for ffmpeg to read the source files

## Installation
### System wide installation in /usr/local/bin
``` sh
# sudo make install
```
### Installation in another directory
``` sh
$ make install INSTALL_DIR=~/.bin
```
*NOTE*: This will create the target directory if it doesn't already exist

## Usage
```
Usage: convert_to_ogg [-R] [-p] -i <Input file/directory> -o <Output file/directory>
       -R: Traverse directories recursively
       -p: Automatically create parent directory for output file
```
