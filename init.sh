#!/bin/bash
prj_home=$(readlink -n -f $0 | xargs dirname | xargs dirname)

# shell
for conf in bash_profile gitconfig on-my-zsh shrc tmux.conf zshrc
do
    ln -s ${prj_home}/shell/${conf} $HOME/.${conf}
done

# zsh theme
ln -s $prj_home/shell/me-ys.zsh-theme $prj_home/shell/oh-my-zsh/themes/

# checks 
for tool in zsh tmux vim 
do
    if [[ -z $(which $tool 2>/dev/null) ]]; then
        echo "you need zsh: sudo yum install -y $tool"
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
        ;;
    esac
fi

