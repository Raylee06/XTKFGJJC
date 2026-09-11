#!/bin/bash

# 获取 dotfiles 目录的绝对路径
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "正在安装 dotfiles..."

# 1. 备份原有的 .bashrc (防止搞坏了系统)
if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
    echo "备份原有的 .bashrc 到 .bashrc.bak"
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi

# 2. 建立软链接
# ln -sf: -s 建立软链接, -f 强制覆盖已存在的链接
ln -sf "$DIR/bashrc" "$HOME/.bashrc"

echo "安装完成！请运行 'source ~/.bashrc' 使配置生效。"
