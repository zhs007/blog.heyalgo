title: translate插件
date: 2019-04-05 16:18:11
tags:
---

今天加了``translate``插件，当然，首先需要在``config.yaml``里配置加载插件。

``` yaml
# plugins - enable plugins
plugins:
  - 'core'
  - 'assistant'
  - 'jarvisnode'
  - 'jarvisnodeex'
  - 'timestamp'
  - 'xlsx2json'
  - 'filetransfer'
  - 'usermgr'
  - 'userscript'
  - 'filetemplate'
  - 'crawler'
  - 'translate'
```

翻译插件直接用``jarviscrawlercore``的服务，也有自己的配置文件``translate.yaml``。

``` yaml
# jarvis telegram bot plugin translate config file

# translate service addr
translateservaddr: 127.0.0.1:7051
```


有几个命令

``` sh
# 进入翻译模式
translate -s zh-CN -d en -p google -r=true
# 退出翻译模式
translate -s zh-CN -d en -p google -r=false
```

这个翻译其实最主要是在聊天群组里用的，我觉得现在短句的聊天，其实google翻译已经可以很方便的让对话双方能看懂了，这个就是在聊天群组里，可以将国外同事的说话自动翻译成中文，而把自己的自动翻译成英文，还可以强制双向翻译（也就是中->英->中），这样你可以发现表述方式可能不太对，需要调整一下。  
对我来说，这个功能有了以后，能省掉不少时间。