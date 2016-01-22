#!/bin/bash

cd externals/luxproject
git pull
cd ..
cp -r luxproject/lib/lux ../

cd ufoproject
git pull
cd ..
cp -r ufoproject/lib/ufo ../
cp -r ufoproject/scripts ../
cp ufoproject/.gitignore ../
