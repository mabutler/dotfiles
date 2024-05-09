#!/bin/zsh
warp() {
    # TODO: add git repo bookmarks (if in a git repo check for local bookmarks)
    #
    # may be able to redo this with existing git project
    # see https://github.com/mfaerevaag/wd
    USAGE="Usage: warp make|to|rm|show [bookmark]" ;
    local folder=$(git rev-parse --show-toplevel 2>/dev/null)

    if  [[ -z $folder ]] ; then
        folder=$HOME
    fi

    if  [ ! -e $folder/.cd_bookmarks ] ; then
        mkdir $folder/.cd_bookmarks
    fi

    case $1 in
        # create bookmark
        create)
            ;&
        make) shift
            if [ ! -f $folder/.cd_bookmarks/$1 ] ; then
                echo "cd `pwd`" > $folder/.cd_bookmarks/"$1" ;
            else
                echo "Try again! Looks like there is already a bookmark '$1'"
            fi
            ;;
        # goto bookmark
        go)
            ;&
        to) shift
            if [ -f $folder/.cd_bookmarks/$1 ] ; then
                source $folder/.cd_bookmarks/"$1"
            else
                echo "Mmm...looks like your bookmark has spontaneously combusted. What I mean to say is that your bookmark does not exist." ;
            fi
            ;;
        # delete bookmark
        delete)
            ;&
        rm) shift
            if [ -f $folder/.cd_bookmarks/$1 ] ; then
                rm $folder/.cd_bookmarks/"$1" ;
            else
                echo "Oops, forgot to specify the bookmark" ;
            fi
            ;;
        # list bookmarks
        list)
            ;&
        show) shift
            \ls $folder/.cd_bookmarks/ ;
            ;;
         *) echo "$USAGE" ;
            ;;
    esac
}

_warp () {
    if (( $+functions[_warp-$words[2]] )); then
        _call_function ret _warp-$words[2]
    else
        local -a commands
        commands=('make' 'to' 'rm' 'list')
        _describe 'commands' commands
    fi
}
_warp-to () {
    local -a fileList
    fileList=$(warp list)
    fileList=( ${(f)fileList} )
    _describe 'commands' fileList
}
# alias of warp to
_warp-go () {
    _call_function ret _warp-to
}

_warp-rm () {
    _call_function ret _warp-to
}
# alias of warp rm
_warp-delete () {
    _call_function ret _warp-rm
}

_warp-list () {
    #nothing
}
#alias of warp list
_warp-show () {
    _call_function ret _warp-list
}

_warp-create () {
    #nothing
}
_warp-make () {
    _call_function ret _warp-create
}
compdef _warp warp
