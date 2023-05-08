#!/bin/bash

rm -rf Temp

find . -name "000_3.jpg" -type f -delete

find . -name "001.jpg" -type f -delete

find . -name "*.jpg" -exec sh -c 'sips -s format pdf "$0" --out "${0%.*}.pdf"' {} \;

find . -name "*.jpg" -type f -delete

