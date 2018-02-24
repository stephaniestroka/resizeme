#!/bin/sh

# default values:
CURRENTDIR=$(pwd)
OUTDIR=out
ADAPTIVE=""

function help {
  echo ""
  echo "The following commands are available: "
  echo ""
  echo "-i / --input:   The input directory is recursively searched for image files."
  echo "-o / --output:  The output directory is used to store the converted images."
  echo "-w / --width:   The width to which the image should be resized. The height is resized according to the images aspect ratio."
  echo "-q / --quality: The quality of the image. Values allowed are in between 1 and 100. The better the quality, the lower the compression."
  echo "-a / --adaptive-resize: Instead of using regular resize, use adaptive resize (see 'man convert')."
  echo "-h / --help:    Prints this message."
#  echo "-d / --dry-run: Verify that the command is working correctly."
  echo ""
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -h|--help)
      help
      exit
      ;;
    -i|--input)
      INDIR="$2"
      shift # past argument
      shift # past value
      ;;
    -o|--output)
      OUTDIR="$2"
      shift # past argument
      shift # past value
      ;;
    -w|--width)
      WIDTH="$2"
      shift # past argument
      shift # past value
      ;;
    -q|--quality)
      QUALITY="$2"
      shift # past argument
      shift # past value
      ;;
    -a|--adaptive-resize)
      ADAPTIVE="adaptive-"
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ -z $INDIR ]; then
  echo "[ERROR] Please specify an input directory."
  help
  exit
fi

if [ -n "$QUALITY" ]; then
  if [ "$QUALITY" -lt 1 ] || [ "$QUALITY" -gt 100 ]; then
    echo "[ERROR] The image quality value must be between 1 and 100."
    help
    exit
  fi
fi

# create directory if it does not exist
[ -d $OUTDIR ] || mkdir $OUTDIR
[[ $OUTDIR == /* ]] || OUTDIR="${CURRENTDIR}/${OUTDIR}"

cd $INDIR
for file in $(find . -type f \( -iname '*.jpg' -o -iname '*.gif' -o -iname '*.png' -o -iname '*.jpeg' \)); do
  [[ $file == ./* ]] && file=${file:2}
  echo "Converting $file"
  dir=$(dirname $OUTDIR/$file)
  mkdir -p $dir
  if [ -n "$WIDTH" ] && [ -n "$QUALITY" ]; then
    convert $file -${ADAPTIVE}resize ${WIDTH} -quality ${QUALITY} ${OUTDIR}/${file}
  elif [ -n "$WIDTH" ]; then
    convert $file -${ADAPTIVE}resize ${WIDTH} ${OUTDIR}/${file}
  elif [ -n "$QUALITY" ]; then
    convert $file -quality ${QUALITY} ${OUTDIR}/${file}
  fi
done;
cd --
