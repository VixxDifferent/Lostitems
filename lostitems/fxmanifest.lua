--[[ FX Information ]] --
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]] --
name 'lostitems'
author 'Vixx'
version '1.0.0' 
description 'A lostitems Resource that shows players their items.'

--[[ Manifest ]] --

server_scripts {
    'server/sv-main.lua',
    '@ox_lib/init.lua',

}

shared_scripts {
    'config.lua'
}
