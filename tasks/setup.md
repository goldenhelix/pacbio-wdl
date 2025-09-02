wget https://github.com/PacificBiosciences/HiFi-human-WGS-WDL/releases/download/v3.0.2/hifi-human-wgs-singleton.zip
wget https://github.com/PacificBiosciences/HiFi-human-WGS-WDL/releases/download/v3.0.2/hifi-human-wgs-family.zip

unzip both to wdl folder (merge)
python wdl-container-converter.py --directory wdl --update
