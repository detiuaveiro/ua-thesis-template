#!/bin/bash
#
# This script will convert all pages WITHOUT actual colors
# but with grays expressed in color values to actual grays.
#
# There should be no visual difference between the original
# document and the one created.
#
# However, the final document will have less color pages. In some cases
# this will reduce the cost of printing the document.
#
# REQUIREMENTS: pdftops, gs-noX11 (from ghostscript)

BUILD="build/tmp"

function forceGray {
    pdftops -level3sep "$1" "$1-aux.ps"
    gs -o "$1" -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -sProcessColorModel=DeviceGray "$1-aux.ps"
    rm "$1-aux.ps"
}


if [ $# -eq 0 ]; then
    echo "Usage: $0 filename.pdf"
    echo "    output will be named 'filename-final.pdf'"
    exit
fi

FILENAME="$1"

if [ ! -f ${FILENAME} ]; then
    echo "${FILENAME} not found!"
    exit 1
fi

if [ -d "$BUILD" ]; then
    rm -f "$BUILD"/*
else
    mkdir -p "$BUILD"
fi

if [ ! -d "$BUILD" ] || [ ! -w "$BUILD" ]; then
    echo "Unable to write to $BUILD"
    exit 1
fi

gs -sDEVICE=pdfwrite -dSAFER -o "$BUILD/%d-`basename $FILENAME .pdf`-split.pdf" "$FILENAME" || exit 1

for i in "$BUILD"/*-"`basename ${FILENAME} .pdf`-split.pdf"; do
    echo "$i"
    COLORS=$(convert "$i" -colorspace CMYK -unique-colors txt:- | grep  \%| grep -v "0%,0%,0%" | cut -d ' ' -f 2 | sed -e "s/%//g" -e "s/(//g" -e "s/)//g")
    if [ "X${COLORS}" == "X" ]; then
        forceGray "$i"
        continue
    fi

    GRAY=1
    for c in "$COLORS"; do
        COLOR=$(echo "$c" |sed -e "s/,/ /g")
        COLOR_C=$(echo -n "$COLOR" | cut -d ' ' -f 1)
        COLOR_M=$(echo -n "$COLOR" | cut -d ' ' -f 2)
        COLOR_Y=$(echo -n "$COLOR" | cut -d ' ' -f 3)
        if [ "${COLOR_C}$COLOR_M" != "${COLOR_M}${COLOR_Y}" ]; then
            GRAY=0
            break
        fi
    done

    if [ "${GRAY}" -eq 1 ]; then
        forceGray "$i"
    fi
done

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="${FILENAME%.*}-final.pdf" $(ls "$BUILD"/*-split.pdf | sort -n -t \/ -k 2)

rm -rf "$BUILD"
