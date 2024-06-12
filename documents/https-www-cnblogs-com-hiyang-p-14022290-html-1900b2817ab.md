### 错误

复制`` fd: /lib64/libc.so.6: version `GLIBC_2.18' not found (required by fd)
 ``

### 产生原因

由于Linux系统的glibc版本太低，而软件编译时使用了较高版本的glibc引起的！

查看当前版本命令

复制`# strings /lib64/libc.so.6 | grep ^GLIBC
GLIBC_2.2.5
GLIBC_2.2.6
GLIBC_2.3
GLIBC_2.3.2
GLIBC_2.3.3
GLIBC_2.3.4
GLIBC_2.4
GLIBC_2.5
GLIBC_2.6
GLIBC_2.7
GLIBC_2.8
GLIBC_2.9
GLIBC_2.10
GLIBC_2.11
GLIBC_2.12
GLIBC_2.13
GLIBC_2.14
GLIBC_2.15
GLIBC_2.16
GLIBC_2.17
GLIBC_PRIVATE
GLIBC_2.8
GLIBC_2.5
GLIBC_2.9
GLIBC_2.7
GLIBC_2.6
GLIBC_2.11
GLIBC_2.16
GLIBC_2.10
GLIBC_2.17
GLIBC_2.13
GLIBC_2.2.6
`

glibc是gnu发布的libc库，即c运行库，glibc是linux系统中最底层的api，几乎其它任何运行库都会依赖于glibc。glibc除了封装linux操作系统所提供的系统服务外，它本身也提供了许多其它一些必要功能服务的实现。

很多linux的基本命令，比如cp, rm, ll, ln等，都得依赖于它，如果操作错误或者升级失败会导致系统命令不能使用，严重的造成系统退出后无法重新进入，所以操作时候需要慎重。

## 升级

复制`1、下载文件
下载地址：https://mirrors.tuna.tsinghua.edu.cn/gnu/glibc/glibc-2.18.tar.gz

2、安装部署
解压
tar -zxvf  glibc-2.18.tar.gz

创建编译目录
cd glibc-2.18 
mkdir build

编译、安装
cd build/
../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin

make -j 8
make install
`

升级后可以通过`strings /lib64/libc.so.6 | grep ^GLIBC`验证是否有指定版本。

posted @ [hiyang](https://www.cnblogs.com/hiyang)阅读(7107) 评论() [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=14022290)收藏 举报