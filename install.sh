#!/bin/bash

tools="git zsh tmux vim"

check() {
    for tool in $tools
        do
            if dpkg -l | grep $tool >/dev/null 2>&1;then
                echo "$tool was installed "
            else
                echo "starting install $tool"
                # TODO Base On Diffrent System
                sudo apt-get install $tool -y
            fi
        done
    }
clone_private_dotfile() {
    cd
    if [ -d conf ];then
        echo "conf was cloned"
    else
        git clone http://github.com/cmdbdu/conf.git
        echo "clone conf "
    fi
    }

# 安装vim 插件管理器 NeoBundle
install_neobundle() {
    echo "install neobundle"
    if [ -d ~/.vim/bundle ];then
        echo "dir was esxit"
        if [ -f ~/.vim/bundle/neobundle.vim ];then
            echo "~/.vim/bundle/neobundle.vim esxit"
        else
            git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
        fi
    else
        echo "mkdir ~/.vim/bundle"
        mkdir -p ~/.vim/bundle
    fi
    } 

# 配置VIM
conf_vim() {
    echo "conf_vim"
    if [ -d ~/.vim ];then
        echo ".vim esxit"
	if [ -f ~/.vim/vimrc ];then
            echo ".vim/vimrc esxit also"
        else
            cp ~/conf/vimrc .vim   
        fi
    else
       mkdir ~/.vim
       cp ~/conf/vimrc .vim   
       echo "cp ~/conf/vimrc .vim. "
    fi

    }


# 配置TMUX
conf_tmux() {
    
    if [ -f ~/.tmux.conf ];then
        echo "file was esxit"
    else
       cp ~/conf/.tmux.conf ~
       echo "cp ~/conf/.tmux.conf ~"
    fi

    }

# 安装oh-my-zsh
conf_zsh() {
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    chsh -s /bin/zsh
    echo 'zsh'
    }
# 安装zsh需要字体
conf_fonts() {
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -fr fonts
    }
conf_tools() {
    check
    clone_private_dotfile
    install_neobundle
    conf_vim
    conf_tmux
    conf_zsh
    conf_fonts
    }

conf_tools

echo "ALL THINGS WAS DONE !!!"
