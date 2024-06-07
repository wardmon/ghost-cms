使用git的时候，通常的用法是 cd 到 repository目录下进行相关的操作，比如说有这么一个repository， D:\\pygit2（通过 git clone https://github.com/libgit2/pygit2.git）  
通常的做法是 cd D:\\pygit2,然后再执行git的相关指令，比如 git status, git log 等等，这种情况下，git命令默认的是 .gitr和working-tree在同一个目录下  
其实还有一种做法，在执行git命令的时候显式指定git-dir(.git目录)和working-tree，这就是本节要讲述的 --git-dir 和 --work-tree 参数  
如果想将pygit2 repository中的某些commit copy到D:\\pygit2以外的目录中，该怎么办？当然通过git clone 再创建一个repository可以做到，但是否是最简洁的方式？而且git clone存在其他一些不必要的开销，在某些情况下（比如含有大量的commit，branch）或许不是很合适。此时可以考虑使用git checkout 或者 git reset命令来实现，只需显式指定working-tree即可。具体实现方法如下：  
 假定想将D:\\pygit2中的master copy到D:\\bak中  
 方法一、  
 1.1 git --git-dir=D:\\\\pygit2\\\\.git --work-tree=D:\\\\bak status   
 此时可以看到很多提示信息，意思是D:\\\\bak和D:\\pygit2 repository相比很多文件缺失  
 1.2 git --git-dir=D:\\\\pygit2\\\\.git --work-tree=D:\\\\bak checkout -b tmp -f master  
 使用-f强制checkout，并创建一个tmp的branch  
 1.3 git --git-dir=D:\\\\pygit2\\\\.git --work-tree=D:\\\\bak branch -d tmp  
 删除tmp branch  
 1.4 此时可以看到D:\\\\bak中的内容已经被更新为D:\\\\pygit2\\\\.git master branch的内容  
 方法二、  
 2.1 git --git-dir=D:\\\\pygit2\\\\.git --work-tree=D:\\\\bak reset --quiet --hard  
 2.2 此时可以看到D:\\\\bak中的内容已经被更新为D:\\\\pygit2\\\\.git master branch的内容,不过这种方法存在一定的弊端，那就是index中的内容都已经丢失，想要恢复  
 的话存在一定的难度，所以在使用reset之前还是慎重一些比较好。

需要注意的是， git-dir传入的一定是git的repository，也就是.git文件夹。