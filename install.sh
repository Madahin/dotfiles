#!/bin/bash

# Functions
function prog_exist()
{
    if ! command -v ${1} &> /dev/null
    then
        echo "${1} could not be found"
        return 1
    else
        return 0
    fi
}

function check_existing_conf()
{
    if [[ -f "${1}" ]]
    then
        echo "There is already a ${2} configuration on this system"
        echo "Continuing while erase the existing configuration"

        read -p "Do you whant to continue ? " -n 1 -r
        echo    # (optional) move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -f "${1}"
            return 0
        else
            return 1
        fi
    fi
}

function install_nvim()
{
    conf_path="${XDG_DATA_HOME:-$HOME/.config/nvim}/init.lua"
    lua_LSP_path="${XDG_DATA_HOME:-$HOME/.config/nvim}/lua/LSP"
    lua_packer_path="${XDG_DATA_HOME:-$HOME/.config/nvim}/lua/packer"

    version=$(nvim -v | head -n1 | cut -d ' ' -f 2 | cut -c2-)
    echo "nvim version: ${version}"

    if [[ "${version}" < "0.5.0" ]]
    then
        echo "nvim version is too old"
        return 1
    fi

    if ! check_existing_conf ${conf_path} "neovim"
    then
        return 1
    fi

    mkdir -p ${lua_packer_path}
    if ! check_existing_conf "${lua_packer_path}/plugins.lua" "neovim packer"
    then
        return 1
    fi

    mkdir -p ${lua_LSP_path}
    if ! check_existing_conf "${lua_LSP_path}/plugins.lua" "neovim LSP"
    then
        return 1
    fi




    echo checking for packer.nvim
    packer_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/packer.nvim"
    if [[ -d "${packer_path}" ]]
    then
        echo packer.nvim already exist
    else
        mkdir -p ${packer_path}
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    fi
 
    ln -s "${PWD}/init.lua" "${conf_path}"
    ln -s "${PWD}/nvim_lua/plugin_lsp.lua" "${lua_LSP_path}/plugins.lua"
    ln -s "${PWD}/nvim_lua/plugin_packer.lua" "${lua_packer_path}/plugins.lua"

    echo "Installation complete"

    return 0
}

function install_kitty()
{
    conf_path="${XDG_DATA_HOME:-$HOME/.config/kitty}/kitty.conf"
    
    if ! check_existing_conf ${conf_path} "kitty"
    then
        return 1
    fi

    ln -s "${PWD}/kitty.conf" "${XDG_DATA_HOME:-$HOME/.config/kitty}/kitty.conf"
    
    echo "Installation complete"

    return 0
}

function install_rofi()
{
    conf_path="${XDG_DATA_HOME:-$HOME/.config/rofi}/config.rasi"
    echo ${conf_path}

    if ! check_existing_conf ${conf_path} "rofi"
    then
        return 1
    fi

    ln -s "${PWD}/config.rasi" ${conf_path}

    echo "Installation complete"

    return 0
}

for prog in nvim kitty rofi
do
    if prog_exist ${prog}
    then
        func="install_${prog}"
        if ${func}
        then
            echo "${prog} configuration successfully installed"
            echo
        else
            echo "Unable to install ${prog} configuration"
        fi
    else
        echo "Skipping"
    fi
done
