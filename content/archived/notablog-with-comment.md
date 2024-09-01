---
title: 为 notablog 添加评论功能
description: 通过 utterances 实现静态博客的评论功能。
tags:
  - Blog
  - Optimization
  - Tutorial
draft: false
date: 2024-01-09
---
## 介绍

[**utterances**](https://github.com/utterance/utterances) 是一个基于 Github issues 的评论组件，能够基于 Github issues 实现评论的邮件通知和回复通知，支持 `Markdown` 语法，非常适合静态页面使用。
![[assets/Untitled 36.png]]

## 步骤

### 1. 生成自己的 u**tterances script**

进入 [utterances](https://utteranc.es/)，根据自己需求进行定制。

### 2. 添加 utterances 到 ejs 模板

1. 在你 `notablog-starter` 目录的 `themes/pure-ejs/layout/partials` 下面创建 `utterances.html`，将生成的 `script` 复制进去。
2. 添加样式和应用 utterances
    - `themes/pure-ejs/assets/css/notablog.css`
        
        ![[assets/Untitled 37.png]]
        
    - `themes/pure-ejs/layouts/post.html`
        
        ![[assets/Untitled 38.png]]
        

### 3. 测试

```Shell
notablog generate .
```

- 进入任意的 **post**，应该就能看到底部的评论组件了。
    
    ![[assets/Untitled 39.png]]
    

---

## 参考

- [utterances](https://utteranc.es/)
- [How to use utterances in generated blog? · Issue #32 · dragonman225/notablog](https://github.com/dragonman225/notablog/issues/32)
- [feat: add utterances · cuiko/notablog-starter@c8f20a3](https://github.com/cuiko/notablog-starter/commit/c8f20a36047586557d3c049d3f7646f0d0943411)
