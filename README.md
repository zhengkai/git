# Git 要点

## config

分全局 `~/.gitconfig` 和项目的 `.git/config`

我个人的例子 [gitconfig](https://github.com/zhengkai/conf/blob/master/dotfiles/gitconfig)

## merge `--no-ff`

![--no-ff](doc/img/no-ff.webp)

## 已过时的标准模型

始祖级文章，开山之作 <https://nvie.com/posts/a-successful-git-branching-model/>

![git model](doc/img/git-model.webp)

## git commit --amend

## git rebase

```
[pull]
	rebase = true

[rebase]
	autostash = true
```

讲解细则：

1. 分支合并时，提前 `rebase` 可以类似 `--no-ff`
2. 同一个分支，`push` 前 `pull --rebase` 可以避免不必要的打结
3. 以提交顺序为准，而不是时间
4. rebase 时有冲突，修复冲突并 `--continue` 继续

## git 操作应该预览

其实 vscode 的显示比 vim 漂亮得多，这个甚至是当初我在 [stackoverflow](https://stackoverflow.com/questions/53590727/how-to-show-different-colors-in-files-list-when-i-filling-git-commit-message-in) 提问后 vim 才增加的这个显示

像 `thumbs.db`、`.DS_Store` 这类垃圾文件不要提交到版本库，推荐了解下 [gitignore 模板合集](https://github.com/github/gitignore)

## 裸仓库

创建方式

    git init --bare base.git

其实 git 仓库不需要有远端 server。其实 git 仓库只分两种，裸仓库（github、gitlab 等托管的就是这种，你本地也可以建），和带工作目录的（本地正常开发时的）

## git reflog

只要进了仓库的就基本都能救回来

## 签名

其实 git commit 里的 author 是随便填的，你写谁的邮箱，就显示谁的头像

有约束力的是

![verified](doc/img/verified.webp)

以前用 GPG，略麻烦，现已增加用 ssh key 做签名

```
[user]
	signingKey = /home/zhengkai/.ssh/id_ecdsa.pub

[commit]
	gpgsign = true
```

如本仓库的 [commit 历史](https://github.com/zhengkai/git/commits/master/?since=2024-06-24&until=2024-06-24)里可以看到，最初的两次 GPG 是不同的签名，一次 github 一次作者 ssh-key
