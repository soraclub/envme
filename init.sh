#!/bin/bash
prj_home=$(readlink -n -f $0 | xargs dirname)

# shell
for conf in bash_profile gitconfig on-my-zsh shrc tmux.conf zshrc
do
    if [[ -f $HOME/.${conf} ]]; then
        mv $HOME/.${conf} $HOME/.${conf}.bak
    fi
    if [[ -L $HOME/.${conf} ]]; then
        unlink $HOME/.${conf} 
    fi
    ln -s ${prj_home}/shell/${conf} $HOME/.${conf}
done

# zsh theme
ln -s $prj_home/shell/me-ys.zsh-theme $prj_home/shell/oh-my-zsh/themes/

# check which
if [[ -z $(whereis which | cut -d':' -f 2) ]]; then 
    echo "you need which: sudo yum install -y which"
    exit
fi


# checks 
for tool in zsh tmux vim 
do
    if [[ -z $(which $tool 2>/dev/null) ]]; then
        echo "you need zsh: sudo yum install -y $tool"
        exit
    fi
done

# vim
if [[ ! -z $(which vim) ]]; then
    VIM=$(which vim)
    vimver=$($VIM --version | head -1 | grep -Po 'IMproved (\d+)' | cut -d' ' -f 2)
    case $vimver in 
        7|8)
            ln -s $prj_home/vim/vim${vimver} $HOME/.vim
        ;;
        *)
            echo "i do not know your vim"
            exit
        ;;
    esac
fi

