# 友盟分析推送Flutter插件（umeng_analytics_push）

- 语言: [English](https://github.com/zileyuan/umeng_analytics_push) | [中文简体](https://github.com/zileyuan/umeng_analytics_push/blob/master/README_zh.md)
- 友盟API详见: [umeng:analytics](http://mobile.umeng.com/analytics) & [umeng:push](http://mobile.umeng.com/push)
- 注意注意: 以下面文档说明为准，不要参考example里面的设置

## 用法

### 导入

```yaml
dependencies:
  umeng_analytics_push: ^1.0.5

# 或者通过Git导入（二选一，Git版本可能更新更加及时）

dependencies:
  umeng_analytics_push:
      git:
        url: https://github.com/zileyuan/umeng_analytics_push.git
```

### Android设置（以Kotlin示例）

#### 创建自定义FlutterApplication类作为启动类,如果不需要push功能则uemng_push_id设置为空

```kotlin
package com.demo.umeng.app

import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "uemng_app_id", "default",
                false, "uemng_push_id")
    }
}
```

#### 修改MainActivity，增加Umeng的设置

```kotlin
package com.demo.umeng.app

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }

  override fun onResume() {
    super.onResume()
    UmengAnalyticsPushFlutterAndroid.androidOnResume(this)
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

### IOS设置（以Swift示例）

#### 修改AppDelegate.swift文件

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        UmengAnalyticsPushFlutterIos.iosInit(launchOptions, appkey:"uemng_app_id", channel:"appstore", logEnabled:false);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```

#### 修改Runner-Bridging-Header.h文件

```objectivec
#import "GeneratedPluginRegistrant.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import <umeng_analytics_push/UmengAnalyticsPushIos.h>
```

### Flutter中使用

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
