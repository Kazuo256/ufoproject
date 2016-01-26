#!/bin/bash

mkdir externals
cd externals

git clone https://github.com/Kazuo256/luxproject.git
cp -r luxproject/lib/lux ../

git clone https://github.com/Kazuo256/ufoproject.git -b infra_domain_activity
cp -r ufoproject/lib/ufo ../
cp -r ufoproject/scripts ../
cp ufoproject/.gitignore ../

cd ..

mkdir activities
mkdir infra
mkdir domain
mkdir resources
mkdir assets

echo "require 'ufo'" > main.lua
cat scripts/extra/.gitignore_for_project >> .gitignore

