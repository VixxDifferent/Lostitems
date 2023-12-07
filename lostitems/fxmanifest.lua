--[[ FX Information ]] --
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]] --
name 'lostitems'
author 'Vixx'
version '1.0.0' -- this is most likely the last time i'm going to touch this script 9/23/2023.
description 'A lostitems Resource that shows players their items when they do /lostitems.'

--[[ Manifest ]] --

server_scripts {
    'server/sv-main.lua'
}

shared_scripts {
    'config.lua'
}
