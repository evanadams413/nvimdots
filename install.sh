#!/bin/bash

echo "=================== 脚本启动 ==================="
echo "本脚本仅支持 Linux 系统和 macOS 系统，且需要 git 命令。"
read -p "确定运行此脚本吗(y/n): " condition

cd $HOME

if [ condition = y || condition = Y ]; then

    # 将原有配置文件备份
    if [ -d "$HOME/.config/nvim/" ]; then
        mv $HOME/.config/nvim/ $HOME/.config/nvim.bak
        echo "已将您的 neovim 配置备份(nvim.bak)!"
    fi
    # 安装字体
    read -p "是否安装 Nerd Font 字体(y/n): " condition02
    if [ condition02 = y || condition02 = Y ]; then
        git clone https://github.com/ryanoasis/nerd-fonts.git --depth 1
        nerd-fonts/install.sh
        rm -r nerd-fonts
    fi
    # 安装依赖
    read -p "是否安装所需依赖(y/n): " condition03
    if [ condition03 = y || condition03 = Y ]; then
        if [ "$(uname)"=="Darwin" ]; then
            # Mac OS X 操作系统
            brew install gcc cmake fd ripgrep npm yarn
        elif [ "$(expr substr $(uname -s) 1 5)"=="Linux" ]; then
            # GNU/Linux操作系统
            packagesNeeded='gcc cmake fd ripgrep npm yarn'
            if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
            elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
            elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
            elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
            else echo "无法识别您系统的包管理器。 你需要手动安装: $packagesNeeded">&2; fi
        fi
    fi
    # 拉取配置文件
    git clone https://github.com/evanadams413/nvimdots ~/.config/nvim/
    echo "安装完成!"

elif [ condition = n || condition = N ]; then
    echo "安装中止!"
fi

echo "=================== 脚本结束 ==================="
