#!/bin/bash

CMD=${0}

convert() {
  in="$1"
  out="$2"
  ffmpeg -i "${in}" \
    -acodec libvorbis -aq 4 -vn -ac 2 \
    -map_metadata 0 \
    "${out}"
}

usage() {
  echo "Usage: ${CMD} [-R] [-p] -i <Input file/directory> -o <Output file/directory>"
  echo "       -R: Traverse directories recursively"
  echo "       -p: Automatically create parent directory for output file"
  exit 1
}

process_file() {
  inputFile="$1"
  outputFile="$2"
  outputdir=`dirname "${outputFile}"`
  if [ ! -d "${outputdir}" ]; then
    if [ ${createDir} -eq 1 ]; then
      mkdir -p "${outputdir}"
    else
      echo "Directory ${outputdir} does not exist"
      exit 1
    fi
  fi
  convert "${inputFile}" "${outputFile}"
}

process_directory() {
  local inputDir="$1"
  local outputDir="$2"
  for I in "${inputDir}"/*; do
    inputfn=`basename "${I}"`
    if [ -f "${I}" ]; then
      outputfn=${inputfn%.*}.ogg
      process_file "${I}" "${outputDir}/${outputfn}"
    elif [ -d "${I}" -a ${recursive} -eq 1 ]; then
      process_directory "${I}" "${outputDir}/${inputfn}"
    else 
      echo "${I} is not a file... skipping"
    fi
  done
}

recursive=0
createDir=0
inputFileOrDir=''
outputFileOrDir=''

while getopts ":Rpi:o:" opt; do
  case ${opt} in
    R )
      recursive=1
      ;;
    p )
      createDir=1
      ;;
    i )
      inputFileOrDir="${OPTARG}"
      ;;
    o )
      outputFileOrDir="${OPTARG}"
      ;;
    \? )
      usage
      ;;
  esac
done

if [ -z "${inputFileOrDir}" -o -z "${outputFileOrDir}" ]; then
  usage
fi

if [ -f "${inputFileOrDir}" ]; then
  process_file "${inputFileOrDir}" "${outputFileOrDir}"
elif [ -d "${inputFileOrDir}" ]; then
  process_directory "${inputFileOrDir}" "${outputFileOrDir}"
fi
