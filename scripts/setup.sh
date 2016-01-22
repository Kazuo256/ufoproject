#!/bin/bash

git clone https://github.com/Kazuo256/luxproject.git
cp -r luxproject/lib/lux .
rm -rf luxproject

git clone https://github.com/Kazuo256/ufoproject.git
cp -r ufoproject/lib/ufo .
rm -rf ufoproject

mkdir activities
mkdir infra
mkdir domain
mkdir assets

echo "require 'ufo'" > main.lua
