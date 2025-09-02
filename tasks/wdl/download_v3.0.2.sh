#!/bin/bash

wget https://github.com/PacificBiosciences/HiFi-human-WGS-WDL/releases/download/v3.0.2/hifi-human-wgs-singleton.zip
wget https://github.com/PacificBiosciences/HiFi-human-WGS-WDL/releases/download/v3.0.2/hifi-human-wgs-family.zip
unzip hifi-human-wgs-singleton.zip
unzip hifi-human-wgs-family.zip
rm hifi-human-wgs-singleton.zip hifi-human-wgs-family.zip
