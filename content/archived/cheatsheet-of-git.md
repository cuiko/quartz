---
title: Git 速查
description: 快速查看常用的 git 命令。
tags:
  - Command
  - Document
draft: false
date: 2024-01-31
---
### 三种状态

- 已提交(committed)
    
    表示数据已经安全地保存在本地数据库.
    
- 已修改(modified)
    
    表示修改了文件, 但还没保存到数据库中.
    
- 已暂存(staged)
    
    表示对一个已修改文件的当前版本做了标记, 使之包含在下次提交的快照中.
    

### 三个阶段

- 工作区
    
    工作区是对项目的某个版本独立提取出来的内容.
    
- 暂存区
    
    暂存区是一个文件, 保存了下次将要提交的文件列表信息.
    
- Git 目录(仓库)
    
    Git 仓库目录是 Git 用来保存项目的原数据和对象数据库的地方.
    

### 基本的 Git 工作流程

- 在工作区修改文件.
- 将下次想要提交的更改选择性地暂存, 这样只会将更改的部分添加到暂存区.
- 提交更新, 找到暂存区的文件, 将快照永久性存储到 Git 目录.

---

### 命令速查

- 初次运行 Git 前的配置
- 1.配置系统变量
    
    ```Shell
    # 查看所有配置及其所在的文件
    git config --list --show-origin <key>
    # 配置每个用户的仓库配置
    git config --system
    # 配置当前用户
    git config --golbal
    # 配置当前项目
    git config --local
    ```
    
- 2. 配置用户信息
    
    ```Shell
    # 设置提交时显示的作者名
    git config --global user.name "foo"
    # 设置提交时显示的邮箱
    git config --global user.email "baz@bar.com"
    ```
    
- 3. 文本编辑器
    
    ```Shell
    git config --global core.editor vim
    ```
    
- 4. 其他
    
    ```Shell
    # 检查配置信息
    git config --list
    # 检查具体的某项配置
    git config user.name
    # 获取帮助
    git help <verb>
    git <verb> --help
    man git-<verb>
    ```
    
- 获取 Git 仓库
    - 将尚未进行版本控制的本地目录转换为 Git 仓库.
        
        ```Shell
        git init
        git init -bare
        ```
        
    - 从其他服务器克隆一个已存在的 Git 仓库.
        
        ```Shell
        git clone https://github.com/author/project
        ```
        
        - 文件状态
            - 已跟踪
                
                指被纳入了版本控制的文件.
                
            - 未跟踪
                
                Git 在之前的快照(提交)中没有这些文件.
                
        
        ```Shell
        # 检查当前文件状态
        git status
        # 紧凑模式
        git status -s
        # Untracked files 未追踪
        # Changes to be committed 已暂存
        # Changes not staged for commit 已追踪的文件内容发生了变化(工作区)
        # 但还没有放到暂存区, 通过 git add 添加到暂存区
        
        # 跟踪新文件/添加至暂存区
        git add README.md
        ```
        
- 查看已暂存和未暂存的修改
    
    ```Shell
    # 查看工作区当前文件和暂存区之间的差异
    git diff
    # 查看已暂存的文件和最后一次提交之间的差异
    git diff --cached
    # 仅显示变化的文件
    git diff --stat
    ```
    
- 提交
    
    ```Shell
    # 提交
    git commit
    # 提交(单行描述)
    git commit -m "baz"
    # 将已追踪的文件暂存起来一并提交 (git add)
    git commit -a
    # 修改上一次提交的描述/提交不保留上一次提交记录
    git commit --amend
    # 重置上一次提交的作者
    git commit --amend --reset-author
    # 修改上一次提交的作者
    git commit --amend --author="baz"
    # 修改上一次提交的时间
    git commit --amend --date="baz"
    # 合并多次提交
    # git log
    # commit1 A.1 --|
    # commit2 A.2 --|
    # commit3 A.3 --|--> 合并这 4 个 commit
    # commit4 A.4 --|
    # commit5 B.1
    git rebase -i commit5 # 需要当前 HEAD 合并到的 commit hash 的前一条 commit hash
    git rebase -i HEAD~4 # 合并最近 4 条提交
    git merge --squash <branch> # 从把其他分支的多条提交压缩成一条
    # Commands:
    # p, pick <commit> = use commit
    # r, reword <commit> = use commit, but edit the commit message
    # e, edit <commit> = use commit, but stop for amending
    # s, squash <commit> = use commit, but meld into previous commit
    # f, fixup <commit> = like "squash", but discard this commit's log message
    # x, exec <command> = run command (the rest of the line) using shell
    # b, break = stop here (continue rebase later with 'git rebase --continue')
    ```
    
- 移除文件
    
    如果直接从工作区删除文件, 运行 `git status` 后, 文件会显示在 changes note staged for commit(未暂存) 部分.
    
    运行 `git rm` 可以记录此次移除文件的操作(changes to be commited).
    
    ```Shell
    git rm README.md
    git rm -f README.md # 删除文件前已缓存或者修改过则必须使用强制删除选项 -f
    git rm --cached README.md # 从 git 仓库中删除(不删除本地文件)
    ```
    
- 移动文件
    
    ```Shell
    git mv readme.md README.md # 重命名
    ```
    
- 查看提交日志
    
    ```Shell
    git log -<n> # 查看前 n 条日志
    git log -p/--patch -1 # 查看最近一条的提交的差异
    git log --stat # 查看提交修改的文件
    
    git log --pretty=oneline # 以一行的方式显示提交描述
    git log --oneline # 简写
    git log --pretty=format:"%h - %cn, %cd: %s" # 以格式化的方式显示提交信息
    
    git log --since=2.weeks # 查看最近两周的所有提交
    git log --until=2.weeks # 查看两周前的所有提交
    
    git log --author="author" # 查看某个作者的提交记录
    git log --committer="committer" # 查看某个提交者的提交记录
    git log --grep="keyword" # 搜索提交说明中的关键字
    git log -S content-keyword # 搜索提交内容中含有 keyword 的提交
    
    git show <commit> # 查看提交内容
    ```
    
- 撤销操作
    
    ```Shell
    git reset --hard README.md # 取消暂存 README.md 文件
    git checkout -- README.md # 将 README.md 文件恢复到上次提交的状态
    git reset --soft HEAD～1 # 撤销上一条提交，并保留修改的文件
    ```
    
- 回滚
    
    ```Shell
    git reset --hard <commit0> # 直接从当前提交(commit3)回滚到指定提交(commit0), 中间提交都无了(commit3/2/1)
    git revert --hard <commit0> # 撤销指定提交的 commit, 会把 commit0 的提交从现在的 git 流里删除, 可能需要解决冲突
    ```
    
- 远程仓库
    
    ```Shell
    git clone <url> # 获取远程仓库
    git remote -v # 查看远程仓库简写和其对应的路径
    git remote add <shortname> <url> # 添加远程仓库
    git remote show <remote> # 展示仓库的相关信息(地址/当前分支/远程分支状态/本地分支)
    git fetch <remote> # 拉取远程更新(需要手动合并)
    git push <remote> <branch> # 推送到远程分支
    git pull <origin> <branch> # 拉取指定分支的远程引用, 并合并到本地分支
    git remote rename <oldName> <newName> # 重命名仓库简称
    git remote remove <remote> # 删除远程仓库
    ```
    
- 标签
    
    **轻量标签**
    
    相当于某个提交的应用, 只附带当前提交信息.
    
    **附注标签**
    
    附注标签是存储在 Git 数据库中的一个完成对象, 它是可以被校验的, 其中包含打标签者的名字、电子邮件、地址、日期时间, 此外还有一个标签信息, 能够用 GPG 签名并验证.
    
    ```Shell
    git tag # 展示已有标签
    git tag -l "v1.1.*" # 检索标签 v1.1.1, v1.1.2
    git tag -a "v1.0" -m "this is v1.0" # -a 创建一个附注标签 -m 为标签添加描述
    git show v1.4 # 查看标签信息和对应的提交信息
    git tag v1.0 # 创建一个轻量标签 不需要使用 -a、-s 或 -m 选项, 只需要提供标签名字
    git tag -a v1.2 <commit-hash> # 为提交补上标签
    git push <remote> <tagname> # 将标签推送到远程仓库
    git push <remote> --tags # 将所有不在远程仓库的标签全部推送上去
    git tag -d v1.2 # 删除本地标签
    git push origin --delete <tagname> # 删除远程仓库标签
    # 检出标签文件版本
    git checkout -b <new-branch> # 创建并切到换新分支
    git checkout -b <new-branch> <commit/branch> # 创建并切到换新分支, 同时制定开始的提交/分支
    git checkout v1.2 # 检出 v1.2 的提交
    git chekcout -b <new-branch> <tagname/remote-branch> # 创建新分支, head 为 tag/remote-branch 的 commit
    ```
    
- GIt 别名
    
    ```Shell
    git config --global alias.unstage 'reset HEAD --'
    git unstage fileA # == git reset HEAD -- fileA
    ```
    
- HEAD、HEAD~、HEAD^ 说明
    
    **HEAD**: 指向当前所在分支的最新提交
    
    **HEAD~{n}**: 指向**当前路径**的第 n 个提交
    
    HEAD = HEAD~0
    
    HEAD~ = HEAD~1
    
    HEAD~~ = HEAD~2
    
    HEAD^n: 切换**父级提交路径**的第 n 个提交(父级本身就代表了回溯了 1 次)
    
    ```Shell
    # 当前提交
    HEAD = HEAD~0 = HEAD^0
    
    # 主线回溯
    HEAD~1 = HEAD^ 主线的上一次提交
    HEAD~2 = HEAD^^ 主线的上二次提交
    HEAD~3 = HEAD^^^ 主线的上三次提交
    
    # 如果某个节点有其他分支并入
    HEAD^1 主线提交（第一个父提交）
    HEAD^2 切换到了第2个并入的分支并得到最近一次的提交
    HEAD^2~3 切换到了第2个并入的分支并得到最近第 4 次的提交
    HEAD^3~2 切换到了第3个并入的分支并得到最近第 3 次的提交
    
    # ^{n} 和 ^ 重复 n 次的区别
    HEAD~1 = HEAD^
    HEAD~2 = HEAD^^
    HEAD~3 = HEAD^^^
    # 切换父级
    HEAD^1~3 = HEAD~4
    HEAD^2~3 = HEAD^2^^^
    HEAD^3~3 = HEAD^3^^^
    ```
    
- 分支
    
    ```Shell
    git branch # 查看本地分支
    git branch -r # 查看远程分支
    git branch -v # 查看本地分支及其最后的提交描述
    git branch <branch-name> # 创建分支
    git checkout <branch-name> # 切换分支
    git checkout -b <branch-name> # 创建分支并切换
    git branch -d <branch-name> # 删除本地分支
    git branch -D <branch-name> # 强制删除本地分支(被删除分支未被合并或推送)
    git push <remote> --delete <branch-name> # 删除远程分支
    git branch --set-upstream-to <remote/branch-name> # 本地分支关联远程分支
    git push --set-upstream-to <remote> <branch-name> # 推送本地分支到远程
    git merge <branch-name> # 合并指定分支到当前当前分支
    git branch -m <old-name> <new-name> # 分支重命名
    ```
    
    冲突说明
    
    ```Shell
    <<<<<<< HEAD:index.html
    <div id="footer">contact : email.support@github.com</div>
    =======
    <div id="footer">
    please contact us at support@github.com
    </div>
    >>>>>>> iss53:index.html
    ```
    
    === 上半部分表示 HEAD 所指示的版本(当前分支).
    
    === 下半部分表示需要合并的版本(希望合并的分支).
    
    解决冲突后(删除 <<< / === / >>>), 使用 `git add` 来将其标记为冲突已解决.
    
- .gitignore
    
    [https://github.com/github/gitignore](https://github.com/github/gitignore)
    
- submodule
    
    ```Shell
    git submodule add <repository-url> # 添加子模块
    git config submodule.<repository>.url <url> # 设置子模块 url
    git log --submodule # 查看子模块相关的提交记录
    git submodule sync --recursive # 修改 .gitmodule 的子模块 url 后, 同步配置到子模块内的 remote 上
    ```
    
    **clone 包含子模块的仓库流程**
    
    ```Shell
    # 方式1
    git clone <repository-url> # clone 父项目
    cd <submodule-name> # 进入子模块目录, ls 后发现为空
    git submodule init # 初始化子模块仓库
    git submodule update # 拉取父项目中的合适的提交
    # 方式2
    git submodule update --init # 初始化并更新子模块
    git submodule update --init --recursive # 递归更新子模块内的子模块
    # 方式3
    git clone --recurse-submodules <repository-url> # clone 父项目的同时自动初始化并更新子模块
    ```
    
    **更新仓库内的子模块**
    
    ```Shell
    # 方式 1
    cd <submodule> # 进入子模块
    git pull # 拉取更新
    git diff --submodule # 查看子模块更新的 commit
    
    git pull --recurse-submodules # 拉取更新(包括子模块内的子模块)
    # 方式 2
    git submodule update --remote <submodule> # 更新子模块
    
    git config --global diff.submodule log # 设置 git diff 默认行为
    ```
    
    **删除仓库内的子模块**
    
    - Delete the relevant section from the `.gitmodules` file.
    - Stage the `.gitmodules` changes:
        
        `git add .gitmodules`
        
    - Delete the relevant section from `.git/config`.
    - Remove the submodule files from the working tree and index:
        
        `git rm --cached path_to_submodule` (no trailing slash).
        
    - Remove the submodule's `.git` directory:
        
        `rm -rf .git/modules/path_to_submodule`
        
    - Commit the changes:
        
        `git commit -m "Removed submodule "`
        
    - Delete the now untracked submodule files:
        
        `rm -rf path_to_submodule`
        

---

### 参考

- [Pro Git](https://git-scm.com/book/en/v2)