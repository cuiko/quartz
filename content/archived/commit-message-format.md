---
title: 开源社区提交格式参考
description: 通过简单的格式和描述让自己和他人更清晰地读懂你做了什么。
tags:
  - Document
draft: false
date: 2022-05-30
---
**Commit Message Format**

```Markdown
<type>(<scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. Not capitalized. No period at the end.
  │       │
  │       └─⫸ Commit Scope: animations|bazel|benchpress|common|compiler|compiler-cli|core|
  │                          elements|forms|http|language-service|localize|platform-browser|
  │                          platform-browser-dynamic|platform-server|router|service-worker|
  │                          upgrade|zone.js|packaging|changelog|docs-infra|migrations|ngcc|ve|
  │                          devtools
  │
  └─⫸ Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```

The `<type>` and `<summary>` fields are mandatory, the `(<scope>)` field is optional.

---

### **Type**

Must be one of the following:

- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **ci**: Changes to our CI configuration files and scripts (examples: CircleCi, SauceLabs)
- **docs**: Documentation only changes
- **feat**: A new feature
- **fix**: A bug fix
- **perf**: A code change that improves performance
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **test**: Adding missing tests or correcting existing tests
- **deps**: change dependency
- **style**: code style
- **chore**: 日常工作，如文档修改，示例等
- **break**: break change

### Scope

提交的代码修改的代码文件范围

### Summary

用简短的话语清晰的描述提交的代码做了什么事

---

## 参考

- [贡献指南 | Kratos](https://go-kratos.dev/docs/community/contribution/)
- [angular/CONTRIBUTING.md at main · angular/angular](https://github.com/angular/angular/blob/main/CONTRIBUTING.md)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)