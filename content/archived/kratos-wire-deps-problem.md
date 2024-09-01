---
title: kratos-layout 初始化时 wire 依赖报错
description: 翻阅 kratos issues 后找到原因和解决办法。
tags:
  - Go
  - Troubleshooting
  - go-kratos
draft: false
date: 2024-01-07
---
### 遇到问题

通过 [kratos-layout](https://github.com/go-kratos/kratos-layout) 构建项目时报错

```Plain
> go generate ./...
../../pkg/mod/github.com/google/wire@v0.5.0/cmd/wire/main.go:34:2: missing go.sum entry for modu
le providing package github.com/google/subcommands (imported by github.com/google/wire/cmd/wire); to add:
        go get github.com/google/wire/cmd/wire@v0.5.0
../../pkg/mod/github.com/google/wire@v0.5.0/internal/wire/copyast.go:21:2: missing go.sum entry 
for module providing package golang.org/x/tools/go/ast/astutil (imported by github.com/google/wire/interna
l/wire); to add:
        go get github.com/google/wire/internal/wire@v0.5.0
../../pkg/mod/github.com/google/wire@v0.5.0/internal/wire/parse.go:30:2: missing go.sum entry fo
r module providing package golang.org/x/tools/go/packages (imported by github.com/google/wire/internal/wir
e); to add:
        go get github.com/google/wire/internal/wire@v0.5.0
../../pkg/mod/github.com/google/wire@v0.5.0/internal/wire/analyze.go:26:2: missing go.sum entry 
for module providing package golang.org/x/tools/go/types/typeutil (imported by github.com/google/wire/cmd/
wire); to add:
        go get github.com/google/wire/cmd/wire@v0.5.0
cmd/reviewise/wire_gen.go:3: running "go": exit status 1
```

### 排查问题

确定 go.mod 的依赖都正确安装后再尝试还是报同样的错

翻阅 [issues](https://github.com/go-kratos/kratos/issues/778#issuecomment-1508422248) 后找到问题

> 这个错误实际上是`cmd/{PROJECT}/wire_gen.go`中的`//go:generate go run github.com/google/wire/cmd/wire`报出的，和是否安装wire无关

### 解决问题

两种方式

- `go get -d github.com/google/wire/cmd/wire@v0.5.0`
- 新建一个 `cmd/{PROJECT}/tools.go`, `PROJECT` 是你的`wire.go`的文件夹
    
    ```Go
    //go:build tools
    // +build tools
    
    package main
    
    import (
    	_ "github.com/google/wire/cmd/wire"
    )
    ```
    
    接着执行下面的代码即可
    
    ```Shell
    # 更新依赖
    go mod tidy
    go generate ./..
    ```
    

---

## 参考

- [go generate 失败 · Issue #778 · go-kratos/kratos](https://github.com/go-kratos/kratos/issues/778)
- [encounter error when run go generate ./... · Issue #113 · go-kratos/kratos-layout](https://github.com/go-kratos/kratos-layout/issues/113)