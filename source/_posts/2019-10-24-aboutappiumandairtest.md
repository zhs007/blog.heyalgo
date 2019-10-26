title: 如何用Appium & Airtest进行自动化移动App测试
date: 2019-10-24 16:32:05
tags: [appium, airtest, android, app, 测试, 自动化测试, App测试]
keywords: appium, airtest, android, app, 测试, 自动化测试, App测试
description: 如何用Appium & Airtest进行自动化移动App测试
---

### Mobile App的自动化测试

现在App的自动化测试方案已经相对成熟了，现成的框架来看，集成度比较好的大概就是Appium和Airtest了。  

### Appium

appium官网下载下来的其实是 appium desktop，一个桌面版的应用，用来分析App的。  
但相比airtest来说，appium desktop的操作实在是有些反人类了，而且bug很多，经常会卡主。  
如果只是想分析dump下来的uiautomator数据，我建议直接用airtest会方便很多，看起来airtest是每分钟都会dump数据，然后比对显示更新，操作起来流畅多了。  
至于数据内容，其实大同小异，不管最后用什么来开发，其实都差不多的。  

appium也可以调试app里面的webview，但这个要看app发布时是否开启调试功能（Android需要在代码里开启），然后，在Android环境下，还存在这各种浏览器内核，不同内核支持也不一样。  

appium直接npm安装的那个包，其实是一个node.js的服务，需要用户自己写客户端来做单元测试的。  
appium的客户端语言支持非常多，基本上常用的都有支持。

### Airtest

airtest是网易的一个项目，原理和Appium几乎一样，支持图像识别，这个主要用于游戏吧。对于App来说，UI界面层用的是网易自己的poco，这个到最底层其实和appium一样，都是用的uiautomator这些。  

airtest主要用python来开发脚本。

### Appium 安装和环境配置

appium的安装很简单，直接 npm 即可。

``` sh
npm i appium -g
```

如果需要调android app，建议还是把android环境装全会比较好，android sdk这些都需要，个人建议装个android studio，然后新建个默认项目，如果能编译且在手机上运行成功，基本上就没问题了。

### Appium 启动参数

Android设备，启动Appium，一定需要传入appPackage和appActivity。  

个人建议使用adb查看当前活跃Activity来获取这些信息，网上一般用 ``adb shell dumpsys activity | grep mFocusedActivity``，但貌似我查不到，我用 ``adb shell dumpsys activity | grep ActivityRecord`` 这个指令，能查到当前活跃的全部app，自己剔除掉后台应用就好。  
或者 ``adb shell dumpsys window windows | grep mFocusedApp`` 。  

至于udid和deviceName，可以 adb devices 得到。  

比较常用的App，譬如微信，我给的参数是这样的。  

``` json
{
  "platformName": "Android",
  "appPackage": "com.tencent.mm",
  "appActivity": ".ui.LauncherUI",
  "deviceName": "XXX",
  "platformVersion": "9.0",
  "udid": "XXX",
  "noReset": true
}
```

最少这样的参数就可以启动App了，``noReset``如果给false，会reset app，慎用。

### Appium node.js客户端包的选择

官方推荐了2个node.js包，分别是 wd 和 webdriverio 。  
看起来 wd 用的人多一些，但我试了一下，感觉 wd 没怎么维护的样子，而且文档太少了。  
webdriverio 文档要稍全一些，appium 官方例子里，也有专门的 webdriverio 的例子。  

所以，我个人的选择是 webdriverio 。

### Appium Android Selector

我不建议在这个层面过多的考虑跨平台问题的，所以 selector 直接用 Android 的 UiSelector 吧。

下面是一些简单的例子代码，更细致的使用，建议直接查 UiSelector 的官方文档。

``` js
/**
 * findByID
 * @param {object} obj - webdriverio element or client
 * @param {string} id - id
 */
async function findByID(obj, id) {
  const selector = 'new UiSelector().resourceId("' + id + '")';
  return await obj.$$(`android=${selector}`);
}

/**
 * findByID
 * @param {object} obj - webdriverio element or client
 * @param {bool} clickable - clickable
 */
async function findByClickable(obj, clickable) {
  const selector = 'new UiSelector().clickable(' + clickable + ')';
  return await obj.$$(`android=${selector}`);
}

/**
 * findByClass
 * @param {object} obj - webdriverio element or client
 * @param {string} className - className
 */
async function findByClass(obj, className) {
  const selector = 'new UiSelector().className("' + className + '")';
  return await obj.$$(`android=${selector}`);
}

/**
 * findByDesc
 * @param {object} obj - webdriverio element or client
 * @param {string} desc - description
 */
async function findByDesc(obj, desc) {
  const selector = 'new UiSelector().description("' + desc + '")';
  return await obj.$$(`android=${selector}`);
}

/**
 * findWithText
 * @param {array} lst - webdriverio elements
 * @param {string} txt - txt
 */
async function findWithText(lst, txt) {
  for (let i = 0; i < lst.length; ++i) {
    const ct = await lst[i].getText();
    if (ct == txt) {
      return lst[i];
    }
  }

  return undefined;
}

```

