# locate for a specific folder
#
# Usage:   clocate $regexFileName $path=pwd
# Example: clocate .zsh*          ../../
clocate() {
    if [ -z $2 ]; then
        directory=$(pwd)
    else
        directory=$2
    fi

    locate -ir $(realpath $directory)/".*"/"$1"
}

