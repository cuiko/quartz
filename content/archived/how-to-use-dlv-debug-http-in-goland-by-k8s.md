---
title: Goland 通过 dlv 调试远程 k8s 应用
description: 本地通过代理转发流量到跳板机达到调试目的。
tags:
  - Command
  - Go
  - IDE
  - K8s
  - Tutorial
draft: false
date: 2024-01-06
---
1. 设置本地代理转发
    
    ```Shell
    # ~/.ssh/config
    Host remote
    	ProxyCommand nc -x localhost:<proxy-port> %h %p
    
    Host remote
    	HostName <server-address>
    	User <user>
    	# 第一个 2345 是本地端口, 第二个 2345 是远程端口
    	LocalForward 2345 localhost:2345
    ```
    
2. 连接远程服务器, 并设置端口转发
    
    ```Shell
    # local-port: 远程主机的本地端口
    # pod-port: pod 内容器的接口
    kubectl port-forward -n <namespace> <pod> <local-port>:<pod-port>
    ```
    
3. 设置 `goland`

- `goland` 的 _Debug Configurations_ 添加 _Go Remote_, `Host` 设置为 `localhost`, `Port` 设置为 `2345`
- 编译携带 `gcflags`
    
    ```Shell
    go build -gcflags "all=-N -l" main.go
    ```
    

1. 运行 `dlv`
    
    ```Shell
    dlv attach <pid> --headless --api-version=2 --listen=:<local>
    ```
    
2. 测试
    
    1. 请求测试接口
    
    ```Shell
    curl -v http://<your-app-http-api>?key=123
    ```