## 2.0.0

- Support null safety
- 支持 null safety

## 1.2.05

- Upgrade the analytics of Umeng to 9.3.3, upgrade the push to 6.2.0, and upgrade some dependent SDKs
- 升级友盟统计到9.3.3，升级推送到6.2.0，以及一些依赖的SDK升级

## 1.2.04

- Support obtaining deviceToken
- 支持获取deviceToken

## 1.2.03

- Format code to improve score
- 格式化代码，提高评分

## 1.2.02

- Modified variable naming
- 修正变量命名

## 1.2.01

- Please note that 1.2 version and 1.1 version are not compatible
- 1.2版本和1.1版本不兼容，请注意
- Removed the initialized customMessage parameter
- 去除了初始化的customMessage参数
- Do not process Custom messages separately, process all message types in a unified manner, please refer to the documentation for details
- 不单独处理Custom消息，统一处理所有消息类型，详细参见说明文档
- Added Dart's MessageModel class, which is used to convert the message body sent over. For details, please refer to the documentation
- 增加了Dart的MessageModel类，用于转换发送过来的消息体，详细使用参见说明文档

## 1.1.07

- When customizing the message, click on the message to wake up the background activity (do not create a new activity)
- 自定义消息的时候，点击消息可以唤醒后台的Activity（不创建新的Activity）

## 1.1.06

- Update usage document
- 更新使用文档

## 1.1.05

- Update usage document
- 更新使用文档

## 1.1.04

- Update usage document
- 更新使用文档

## 1.1.03

- Solve the problem of Crash monitoring under IOS
- 解决IOS下监听会Crash的问题

## 1.1.02

- Add CustomMessage condition control, modify the document
- 加入CustomMessage条件控制，修改文档

## 1.1.01

- Umeng upgraded to the latest version of SDK (including IOS and Android), and there was no compiling problem in the test
- 友盟升级到最新版SDK(包含IOS和Android)，亲测没有编译等问题
- Added vendor Push channel support (Xiaomi, Huawei, Oppo, Vivo, Meizu), test Xiaomi can accept offline Push
- 加入厂商Push通道支持(Xiaomi，Huawei，Oppo，Vivo，Meizu)，亲测Xiaomi可以接受离线Push

## 1.0.14

- Plus the utdid component on the Android side of Umeng, there is no need to remove it under special circumstances.
- 加上友盟Android端的utdid组件，有特殊情况不需要的自行去除

## 1.0.13

- Solve insecure connections in README.MD, add points, :)
- 解决README.MD中的不安全连接，加点评分，:)

## 1.0.12

- Solve the problem of the compilation error of the new version IOS SDK of Umeng
- 解决友盟新版本IOS SDK编译错误的问题
- Removal of Umeng's security optional components may lead to conflicts with other SDKs
- 去除友盟的安全可选组件，可能导致和别的SDK冲突

## 1.0.11

- Solve the problem that the new version SDK of Umeng does not match each other
- 解决友盟新版本SDK相互不匹配的问题

## 1.0.10

- Solve the problem that the new version SDK of Umeng does not match each other
- 解决友盟新版本SDK相互不匹配的问题

## 1.0.9

- Solve the new version SDK compilation error of Umeng
- 解决友盟新版本SDK编译错误

## 1.0.8

- Update the SDK version that Umeng depends on
- 更新友盟依赖的SDK版本

## 1.0.7

- Update the document, some nouns are consistent with Umeng
- 更新文档，一些名词和友盟一致
- Corrected the userNotificationCenter writing of the custom response message IOS, thanks [gaoyong06](https://github.com/gaoyong06)
- 修正自定义响应消息IOS的userNotificationCenter写法，感谢[gaoyong06](https://github.com/gaoyong06)

## 1.0.6

- Add page buried point events (startPage, endPage)
- 增加页面埋点事件（startPage，endPage）
- Add custom event (event)
- 增加自定义事件（event）
- Add Push custom response
- 增加Push的自定义响应

## 1.0.5

- adjustment description
- 调整说明

## 1.0.4

- adjustment description
- 调整说明

## 1.0.3

- fix bugs
- 修复错误

## 1.0.2

- Document update
- 文档更新

## 1.0.1

- Plug-in mode compatible with Flutter1.12
- 兼容Flutter1.12后的插件模式

## 1.0.0

- Integration of basic Umeng Analytics functions
- 集成基本的Umeng的Analytics分析功能
- Integrated basic Umeng Push function (support Alias, Tags function)
- 集成基本的Umeng的Push推送功能（支持别名Alias，标签Tags功能）
