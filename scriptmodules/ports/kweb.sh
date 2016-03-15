#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="kweb"
rp_module_desc="kweb - Minimal Kiosk Web Browser"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_kweb() {
    getDepends evince vlc tint2 lxterminal uget git
}

function sources_kweb() {
    if [[ "$__raspbian_ver" -lt 8 ]]; then
        wget -O- -q http://steinerdatenbank.de/software/kweb-1.6.8.tar.gz | tar -zxv
    else
        wget -O- -q http://steinerdatenbank.de/software/kweb-1.6.9.tar.gz | tar -zxv
    fi
    git clone git://github.com/rg3/youtube-dl youtube-dl
}

function install_kweb() {
    if [[ "$__raspbian_ver" -lt 8 ]]; then
        cd kweb-1.6.8
    else
        cd kweb-1.6.9
    fi
    
    ./debinstall
    cd ..
    cp -R youtube-dl/ "$md_inst"
    ln -s "$md_inst/youtube-dl/youtube_dl/__main__.py" /usr/bin/youtube-dl
    chmod 755 /usr/bin/youtube-dl
}

function configure_kweb() {
    mkRomDir "ports"
    addPort "$md_id" "kweb" "kweb - Minimal Kiosk Web Browser" "xinit kweb"
}
