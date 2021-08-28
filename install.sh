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

function install_nvim()
{
    version=$(nvim -v | head -n1 | cut -d ' ' -f 2 | cut -c2-)
    echo "nvim version: ${version}"

    if [[ "${version}" < "0.5.0" ]]
    then
        echo "nvim version is too old"
        return 1
    fi

    if [[ -f "${XDG_DATA_HOME:-$HOME/.config/nvim}/init.vim" ]]
    then
        echo "There is already a nvim configuration on this system"
        echo "Continuing while erase the existing configuration"

        read -p "Do you whant to continue ? " -n 1 -r
        echo    # (optional) move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -f "${XDG_DATA_HOME:-$HOME/.config/nvim}/init.vim"
        else
            return 1
        fi
    fi

    echo checking for vim-plug
    if [[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]]
    then
        echo vim-plug already exist
    else
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi

    ln -s "${PWD}/init.vim" "${XDG_DATA_HOME:-$HOME/.config/nvim}/init.vim"

    echo "Installation complete"

    return 0
}

for prog in nvim
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
