#!/bin/bash

# am besten einzeln copy & past und gucken.

apt install git
#  sleep 5
apt install build-essential
# sleep 5
apt install libuv1-dev
# sleep 5
apt install libssl-dev
# sleep 5
apt install libhwloc-dev
# sleep 5
apt install cmake
# sleep 5
git clone https://github.com/xmrig/xmrig.git
# sleep 5
cd xmrig/
# sleep 5
mkdir build
# sleep 5
cd build/
# sleep 5
cmake ..
# sleep 5
make
# sleep 5
echo Teil-1 CPU Mining fertig Cudo_Support idealerweise manuell per Terminal installieren

###  Vorraussetzung ist die Installation der propräteren Nvidia-Treiber auf einer Debian basierten Distro
###  Die meisten Linuxdistros bieten mittlerweile eine Installationsanleitung / ein Script ec. an.

### Nvidia - Cuda support.
### die folgenden 5 Zeilen sind von:  https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#debian
sudo apt install linux-headers-$(uname -r)
sudo apt-key del 7fa2af80
sudo wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt -y install cuda


### xmrig - Cuda Plugin
cd ~/xmrig/
git clone https://github.com/xmrig/xmrig-cuda.git cuda
cd cuda
mkdir build
cd build
sudo cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda
sudo make -j$(nproc)
cd
sudo ln libxmrig-cuda.so ~/xmrig/build/libxmrig-cuda.so

sudo init 6 #Reboot , damit der Kernel die neuen  Nvidia Module  lädt (sudo dmesg , bei Problemen)

Vor Ausführung des:
https://github.com/xmrig/xmrig/blob/master/scripts/randomx_boost.sh
ist die Installation von:
apt install msr-tools
#Paketlisten werden gelesen… Fertig
#Abhängigkeitsbaum wird aufgebaut… Fertig
#Statusinformationen werden eingelesen… Fertig
#Die folgenden NEUEN Pakete werden installiert:
#  msr-tools
#0 aktualisiert, 1 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
#Es müssen 10,1 kB an Archiven heruntergeladen werden.
#Nach dieser Operation werden 46,1 kB Plattenplatz zusätzlich benutzt.
#Holen:1 http://deb.debian.org/debian bookworm/main amd64 msr-tools amd64 #1.3-5 [10,1 kB]
#Es wurden 10,1 kB in 0 s geholt (278 kB/s).
#Vormals nicht ausgewähltes Paket msr-tools wird gewählt.
#(Lese Datenbank ... 303799 Dateien und Verzeichnisse sind derzeit #installiert.)
#Vorbereitung zum Entpacken von .../msr-tools_1.3-5_amd64.deb ...
#Entpacken von msr-tools (1.3-5) ...
#msr-tools (1.3-5) wird eingerichtet ...
#Trigger für man-db (2.11.2-2) werden verarbeitet ...
#root@mx25:/home/u25/xmrig/scripts# ./randomx_boost.sh 
#Detected Zen3 CPU
#MSR register values for Zen3 applied


# inhalt der ~/xmrig/build/config.json
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": true,
    "pools": [
    	{
            "algo": "rx/0",
            "coin": "monero",
            "url": "127.0.0.1:18081",
            "user": "41......................",
            "daemon": true
        }  
    ]
}

# Download mit bis zu 100 MBit/s   Upload mit bis zu 50 MBit/s 
# https://getmonero.dev/interacting/monero-config-file.html
./xmonero/monerod  --data-dir=/mnt/moblock/.bitmonero --out-peers=12 --in-peers=12 --limit-rate-up=1024 --limit-rate-down=2048
## systemd # systemctl isolate multi-user.target # nicht damit mehr RAM frei ist . (ggf. Performance Vorteil)
# non grafical Alt+F2 bzw. neues Terminalfenster
sudo ./xmrig/build/xmrig
# im dritten Fenster ggf. bpytop um bzw. Systemmonitor zur Temperaturüberwachung ec. 

Ausserdem, bei verwendung von Arbeitsrechner, zum Mining zwischendurch:
while true; do [ xprintidle -gt 30000 ] && screen -X stuff 'r'; sleep 12; done
https://odysee.com/@Josef_Federl:9/Automatisiertes_Resumen_von_Xmrig

