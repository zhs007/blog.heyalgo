title: 关于puppeteer的一点记录
date: 2019-03-26 16:13:51
tags: puppeteer
keywords: puppeteer
description: 近期使用puppeteer的一点记录
---
关于``puppeteer``，留点记录。

首先，在``page``层面，``$()``和``$eval()``是不一样的，``$()``返回一个nodejs对象，``$eval()``其实是做页面操作，而且``$eval()``里面的输出也在浏览器里面。  
也就是说其实是2个不同的JS环境，一个是宿主的``NodeJS``，一个是``Chrome``。  

还有点需要注意的，就是``$eval()``的返回值是你自己控制的，可以用来传递跨域对象。  
但目前只有基本对象可以传递，``ArrayBuffer``是传不过来的，但可以通过``base64``以后传``string``。  

如果需要加载页面以外的js，可以用  
``` js
// url
await page.addScriptTag({url: 'https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/index.js'});
// local file
await page.addScriptTag({path: './browser/base64.js'});
```

运行js代码，用``page.evaluate``，这个里面是页面的js空间，类似chrome控制台操作，这个函数的返回值是你自己控制的，可以用来传递js对象。  

页面可以用``fetch``取数据。  
``` js
const response = await fetch(curimg[0].src);
```
返回是一个``ReadableStream``，可以转``arrayBuffer``、``json``、``text``等。  

``fetch``也可能会有CORS错误，如果是页面里本来的数据，可以通过``page.on.request``来侦听。

有些页面有很复杂的CSP限制，可以关闭CSP，原理上是做了层代理。  
``` js
await page.setBypassCSP(true);
```

``page.waitFor``这一组命令非常常用，得在页面层通盘考虑，因为有时错过了事件，最后就只能超时了，所以超时事件一定要处理，否则会跳过很多你不希望跳过的代码。

``` js
  await page.waitForNavigation({waitUntil: 'load'}).catch((err) => {
    console.log('catch a err ', err);
  });
```

然后就是，很多页面会加载``jQuery``，``jQuery``会覆盖``chrome``自己的``$()``，其实2个返回值都是不一样的，个人觉得还是干脆把没加载``jQuery``的页面也手动加载一下最省事。