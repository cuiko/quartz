---
title: 如何通过 x-ui 快速搭建代理服务并避免被墙
description: ws + tls + Cloudflare cdn 拯救被墙的节点。
tags:
  - Network
  - Tutorial
draft: false
date: 2024-01-07
---
## 需要

- 一台 VPS
    - Ubuntu 20.04
        
        **需要能切换到 root**
        
    - 能够通过 **ssh** 访问到 VPS
- 一个 **[Cloudflare](https://www.cloudflare.com/zh-cn/)** 账号
- 一个**域名**

## 步骤

1. **安装 x-ui**

```Shell
# 切换到 root 用户进行操作，根据提示配置用户名和密码
bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/956bf85bbac978d56c0e319c5fac2d6db7df9564/install.sh) 0.3.4.4
# 安装 bbr，输入 15
x-ui
```

1. **Cloudflare 设置域名和开启 tls**
    1. 进入 [Cloudflare](https://www.cloudflare.com/zh-cn/)
    2. 添加域名，比如 example.com
        
        如果是其他平台购买的域名，需要在其平台修改域名解析到 Cloudflare
        
        - [dana.ns.cloudflare.com](http://dana.ns.cloudflare.com/)
        - [jeremy.ns.cloudflare.com](http://jeremy.ns.cloudflare.com/)
        
    3. 添加任意主机名，比如 p.example.com
        
        **下面所有关于 p.example.com 都是你设置的主机名 + 你的域名**
        
    4. 侧边栏找到 **SSL/TLS**，将加密模式改为 **Full**
    5. 点击右上角头像图标，进入我的信息，再找到侧边栏 **API Tokens**
        
        复制 **Global API Key**，待会要用
        
2. **申请和安装证书到 VPS**
    
    ```Shell
    # 切换到 root 用户
    x-ui
    
    # 根据提示依次输入
    # 16(申请 SSL 证书)
    # 2(通过 Cloudflare 解析)
    # y(同意)
    # 你的域名(p.example.com)
    # 你的 Global API Key
    
    # 证书会安装到 /root/cert，需要用到 fullchain.cer 和 p.example.com.key
    sudo ls /root/cert
    > ca.cer	fullchain.cer  p.example.com.cer  p.example.com.key
    ```
    
3. **添加入站**
    - 协议选择 `vless`，也可以选 `vmess` ，具体区别看下方**参考**
    - 端口 `443`
    - 添加一个用户
    - 网络选择 `ws`
    - 路径输入任意值，比如 `/p`
    - 请求头添加 **Host** ，值为 `p.example.com`
    - 勾选 `tls`
    - 域名填入 `p.example.com`
    - 证书选择 `certificate file path`
    - 公钥文件路径填入 `/root/cert/fullchain.cer`
    - 密钥文件路径 `/root/cert/p.example.com.key`
    - 其他的根据你的需求设置后点击添加
4. **测试**
    1. 点击新建的入站左侧的**操作**按钮 → 点击**二维码 →** 设备支持就扫码/不支持就点复制
    2. 以我用的 **ClashX** 为例，因为不支持链接导入，我需要找到一个订阅转换工具，上网搜索**订阅转换**（你要是放心的话，用我搭建的 [订阅转换 API](https://sub.cuiko.top/)），输入复制的链接到**订阅链接**输入框内，点击**生成订阅链接**后会生成一个订阅地址
    3. 点击 **ClashX** 小图标后，键盘按 `CMD+M` 添加刚刚复制的订阅地址
    4. Enjoy

---

## 参考

- [FranzKafkaYu/x-ui](https://github.com/FranzKafkaYu/x-ui)
- [使用 V2Ray 的 WebSocket 传输协议 + Cloudflare 拯救被墙的 IP-Work Blog](https://www.wlgo.cc/archives/1708.html)
- [【全网首发】永不被盗的订阅转换方法！使用worker搭建永久免费的私人反代订阅转换服务，新手小白必备，建议人手一个](https://www.youtube.com/watch?v=X7CC5jrgazo)
- [【零基础】最新保姆级纯小白节点搭建教程，人人都能学会，目前最简单、最安全、最稳定的专属节点搭建方法，手把手自建节点搭建教学，晚高峰高速稳定，4K秒开的科学上网线路体验 – Telegraph](https://telegra.ph/bnode-10-24)
- [VMess 协议 | Project X](https://xtls.github.io/development/protocols/vmess.html#%E7%89%88%E6%9C%AC)
- [VLESS 协议 | Project X](https://xtls.github.io/development/protocols/vless.html)
- [快速配置 vps 基本环境](https://cuiko.github.io/vps-setup.html)
- [检测 IP 是否被墙](https://ping.pe/)
- [检测端口是否被墙](https://tcp.ping.pe/)