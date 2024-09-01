---
title: 快速配置 vps 基本环境
description: 通过 dotfiles 配置 zsh、rust、lua、tmux、nvim(lazyvim)。
tags:
  - Command
  - Tutorial
draft: false
date: 2024-01-08
---
## 1. 创建用户

```Shell
# Ubuntu 20.04
# 通过 ssh 连接到 vps
ssh root@<ip> -p <port>
# 创建个人用户
adduser
# 分配 sudo 权限
usermod -aG sudo <username>
# 修改 ssh 配置
sudo vim /etc/ssh/sshd_config
# 在最后一行添加
# 禁止 root 用户通过 ssh 登陆
PermitRootLogin no
# 修改远程端口(大于 1024 小于 65535)
Port 12345
# 保存并退出
:wq !sudo tee %
# 重启 ssh 服务
sudo systemctl restart ssh
# TODO: 只允许使用 RSA 登陆，禁用密码登陆
```

## 2. 配置 dotfiles

```Shell
# 拉取 dotfiles
git clone https://github.com/imzhongqi/dotfiles ～/.ditfiles
# 安装 stow
sudo apt install stow
# 初始化 submodule
cd ~/.ditfiles
git submodule init
# 删除 .git
rm -rf .git
```

## 3. 安装常用命令

```Shell
# 安装 zsh
sudo apt install zsh
# 设置默认 shell 为 zsh
chsh -s $(which zsh)
# 启用 zsh 配置
cd ~/.ditfiles
stow zsh
# 进入配置好的 zsh
zsh
# 安装 rust(部分命令需要用到)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# 添加 cargo/bin 目标到 $PATH
pathctl put ~/.cargo/bin
# 安装 exa
cargo install exa
# 安装 fd
cargo install fd-find
# 安装 rg
cargo install ripgrep
# 安装 lua 5.3(Ubuntu 20.04 只能安装到 5.3)
sudo apt install lua5.3
# 安装 fzf
wget https://github.com/junegunn/fzf/releases/download/0.45.0/fzf-0.45.0-linux_amd64.tar.gz
x fzf-0.45.0-linux_amd64.tar.gz
sudo install fzf /usr/local/bin
# 安装 tmux
wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
x tmux-3.3a.tar.gz
# 安装 tmux 编译依赖
sudo apt install libevent-dev ncurses-dev
# 编译 tmux
cd tmux-3.3a
./configura && make
sudo install tmux /usr/local/bin
# 安装 tmux 插件
# 进入 tmux 后按 ctrl+z+I
# 安装 lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
# 安装 nvim
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
x nvim-linux64.tar.gz
mv nvim-linux64 nvim
sudo install nvim /usr/local/share
# 添加 nvim 到 $PATH
pathctl put /usr/local/share/nvim/bin
```

---

## 参考

- [imzhongqi/dotfiles](https://github.com/imzhongqi/dotfiles)
- [[🚀 Getting Started | LazyVim]](https://www.lazyvim.org/#%EF%B8%8F-requirements)