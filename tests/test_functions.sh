#!/bin/bash -e

cd functions
for i in `ls`; do
  ./$i
done