title: Windows下的一些坑
date: 2019-12-28 10:28:49
tags: [Windows, server, 部署]
keywords: Windows, server, 部署
description: Windows服务器的一些坑
---

### Golang 的条件编译

``Golang``里依然有部分代码是按平台来区分的，如果你调用了一些平台依赖代码，那么你就只能使用条件编译，来解决跨平台编译错误。  
``Golang``的条件编译，是针对整个文件的，所以建议把平台依赖的实现，拆开成不同的文件，譬如 a.win32.go、a.linux64.go 这样的。  
但在vscode下，还未能正常识别条件编译，文件会报错，但``go build``是没问题的。

条件编译其实很简单，就是在文件最开始处加注释。  

``` golang
// +build windows

package jarviscore
```

条件编译支持多条，单条里是或的关系，多条是与的关系。

``` golang
// +build linux darwin  
// +build 386
```

这个将限制此源文件只能在 ``linux/386`` 或 ``darwin/386`` 平台下编译。

### cgo的交叉编译

据说cgo是可以交叉编译的，前提条件是用跨平台的C或C++编译器，没有尝试过，但个人觉得如果要在linux下编译Windows版本，应该还是非常麻烦的（有一堆依赖）。

个人觉得比较靠谱的方案，还是docker，或尽可能不用cgo。

### node-gyp在Windows下的编译

有些``node.js``库是c++的，所以会需要``node-gyp``来编译。  
在windows下，会需要先安装依赖，不过现在已经有比较简单的一键安装方案了。

```
npm install --global --production windows-build-tools
```

建议这种，还是安装以前，去``node-gyp``官网查一下，也许未来方案有调整也说不定。

看起来，上面那条指令会自动安装 ``python 2.7``。但我是先一步自己手动安装的 ``python 2.7`` 。

### node.js 版本号

``node.js``一般是偶数版本号为release，奇数版本号为开发版，所以有些库对奇数版本号支持得不好，grpc好像至今还不能在v13下编译过。  
所以我建议不管是宿主主机环境下安装，还是docker安装，都指定版本号到v12。

### 国内网络环境下复杂node.js项目的安装方案

淘宝专门做了``cnpm``，其实能解决大部分的安装问题。

```
npm install --registry=https://registry.npm.taobao.org
```

但有些 ``node-gyp`` 项目，安装脚本写得很复杂，有些是先下载一个打包好的依赖库，然后编译什么的，这个依赖库往往是github这些直接下载的，而github用的是aws，而aws的下载看起来是临时生成一个下载通道，一段时间内下载不下来，最后连断点续传都做不到，一定会失败。  

其实npm安装时，会专门有个cache目录，这些下载文件就是先下载到cache目录里的，就算下载失败，cache其实也是不清理的，所以有些安装错误，就是卡在cache里文件不对，需要手动清理cache。

```
npm cache clean --force
```

这里其实不是要你清理cache，因为已经确定是网络问题导致文件下载失败，不停的清理cache也没用是不是。  
其实我们可以通过别的方式把文件下载下来，覆盖cache里错误的文件，让安装继续走下去。

Windows下，这个cache目录一般在

```
C:\Users\Administrator\AppData\Roaming\npm-cache\
```

### Docker

Windows下Docker也很麻烦。还是去官网下载``Docker Desktop``，需要账号登录。

然后，装好以后，有``Windows containers``和``Linux containers``，我们一般常用的都是``Linux containers``。  
