# 友盟分析推送Flutter插件（umeng_analytics_push） [![pub package](https://img.shields.io/pub/v/umeng_analytics_push)](https://pub.flutter-io.cn/packages/umeng_analytics_push)

- 语言: [English](https://github.com/zileyuan/umeng_analytics_push) | [中文简体](https://github.com/zileyuan/umeng_analytics_push/blob/master/README_zh.md)
- 友盟API详见: [umeng:analytics](https://mobile.umeng.com/analytics) & [umeng:push](https://mobile.umeng.com/push)
- 注意注意: 以下面文档说明为准，不要参考example里面的设置

## 用法

### 导入

[![pub package](https://img.shields.io/pub/v/umeng_analytics_push)](https://pub.flutter-io.cn/packages/umeng_analytics_push)

```yaml
dependencies:
  umeng_analytics_push: ^x.x.x #最新版本见上方，插件1.x支持flutter1.x，插件2.x支持flutter2.x

# 或者通过Git导入（二选一，Git版本可能更新更加及时）

dependencies:
  umeng_analytics_push:
      git:
        url: https://github.com/zileyuan/umeng_analytics_push.git
```

### Android设置（以Kotlin示例）

#### 创建自定义FlutterApplication类作为启动类，如果不需要push功能则uemng_push_id设置为空，如果不需要自定义Push点击，则设置最后一个参数为false

```kotlin
package com.demo.umeng.app

import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "uemng_app_key", "default",
                false, "uemng_message_secret")
    }
}
```

#### 修改MainActivity，增加Umeng的设置

```kotlin
package com.demo.umeng.app

import android.os.Handler
import android.os.Looper
import android.content.Intent
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushPlugin

class MainActivity: FlutterActivity() {
    var handler: Handler = Handler(Looper.myLooper())

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onNewIntent(intent: Intent) {
        // Actively update and save the intent every time you go back to the front desk, and then you can get the latest intent
        setIntent(intent);
        super.onNewIntent(intent);
    }

    override fun onResume() {
        super.onResume()
        UmengAnalyticsPushFlutterAndroid.androidOnResume(this)
        if (getIntent().getExtras() != null) {
            var message = getIntent().getExtras().getString("message")
            if (message != null && message != "") {
                // To start the interface, wait for the engine to load, and send it to the interface with a delay of 5 seconds
                handler.postDelayed(object : Runnable {
                    override fun run() {
                        UmengAnalyticsPushPlugin.eventSink.success(message)
                    }
                }, 5000)
            }
        }
    }

    override fun onPause() {
        super.onPause()
        UmengAnalyticsPushFlutterAndroid.androidOnPause(this)
    }
}
```

#### 修改AndroidManifest.xml文件

```xml
<application
  android:name="com.demo.umeng.app.MyFlutterApplication">
</application>
```

#### 加入厂商通道, 详见官方文档 [umeng:push:vendor](https://developer.umeng.com/docs/67966/detail/98589)

##### 修改MyFlutterApplication

```kotlin
package com.demo.umeng.app

import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "uemng_app_key", "default",
                false, "uemng_message_secret", false)
        // Register Xiaomi Push (optional)
        UmengAnalyticsPushFlutterAndroid.registerXiaomi(this, "xiaomi_app_id", "xiaomi_app_key")
        // Register Huawei Push (optional, need add other infomation in AndroidManifest.xml)
        UmengAnalyticsPushFlutterAndroid.registerHuawei(this)
        // Register Oppo Push (optional)
        UmengAnalyticsPushFlutterAndroid.registerOppo(this, "oppo_app_key", "oppo_app_secret")
        // Register Vivo Push (optional, need add other infomation in AndroidManifest.xml)
        UmengAnalyticsPushFlutterAndroid.registerVivo(this)
        // Register Meizu Push (optional)
        UmengAnalyticsPushFlutterAndroid.registerMeizu(this, "meizu_app_id", "meizu_app_key")
    }
}
```

##### 修改AndroidManifest.xml, 填写真实的Id和key

```xml
<application
  android:name="com.demo.umeng.app.MyFlutterApplication">
    <!-- Vivo push channel start (optional) -->
    <meta-data
        android:name="com.vivo.push.api_key"
        android:value="vivo_api_key" />
    <meta-data
        android:name="com.vivo.push.app_id"
        android:value="vivo_app_id" />
    <!-- Vivo push channel end-->

    <!-- Huawei push channel start (optional) -->
    <meta-data
        android:name="com.huawei.hms.client.appid"
        android:value="appid=huawei_app_id" />
    <!-- Huawei push channel end-->
</application>
```

##### 使用下面的参数发送，可接受离线消息

```js
"mipush": true
"mi_activity": "io.github.zileyuan.umeng_analytics_push.OfflineNotifyClickActivity"  
```

### IOS设置（以Swift示例）

#### 修改AppDelegate.swift文件，如果不需要Push功能则pushEnabled设置为false

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        UmengAnalyticsPushFlutterIos.iosInit(launchOptions, appkey:"uemng_app_key", channel:"appstore", logEnabled:false, pushEnabled:true);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // 如果需要处理Push点击，用下面代码
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        UmengAnalyticsPushFlutterIos.handleMessagePush(userInfo)
        completionHandler()
    }
}
```

#### 修改Runner-Bridging-Header.h文件

```objectivec
#import "GeneratedPluginRegistrant.h"
#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import <umeng_analytics_push/UmengAnalyticsPushIos.h>
```

### Flutter中使用

#### 点击Push响应

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';
import 'package:umeng_analytics_push/message_model.dart';

UmengAnalyticsPush.addPushMessageCallback((MessageModel message) {
  print("UmengAnalyticsPush Message ======> $message");
});
```

#### 操作Alias

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.addAlias('1001', 'jobcode');
UmengAnalyticsPush.setAlias('1002', 'jobcode');
UmengAnalyticsPush.deleteAlias('1002', 'jobcode');
```

#### 操作Tags

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.addTags('manager');
UmengAnalyticsPush.deleteTags('manager');
```

#### 页面埋点操作

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.pageStart('memberPage');
UmengAnalyticsPush.pageEnd('memberPage');
```

#### 自定义事件

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.event('customEvent', '1000');
```
