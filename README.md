# Umeng Analytics&Push Flutter Plugins（umeng_analytics_push） [![pub package](https://img.shields.io/pub/v/umeng_analytics_push)](https://pub.flutter-io.cn/packages/umeng_analytics_push)

- Language: [English](https://github.com/zileyuan/umeng_analytics_push) | [中文简体](https://github.com/zileyuan/umeng_analytics_push/blob/master/README_zh.md)
- Umeng API: [umeng:analytics](http://mobile.umeng.com/analytics) & [umeng:push](http://mobile.umeng.com/push)
- Note: The following document description shall prevail, do not refer to the settings in the example

## Usages

### Import

[![pub package](https://img.shields.io/pub/v/umeng_analytics_push)](https://pub.flutter-io.cn/packages/umeng_analytics_push)

```yaml
dependencies:
  umeng_analytics_push: ^x.x.x #最新版本见上方

# Or import through Git (choose one, Git version may be updated more timely)

dependencies:
  umeng_analytics_push:
      git:
        url: https://github.com/zileyuan/umeng_analytics_push.git
```

### Android settings (with Kotlin example)

#### Create a custom FlutterApplication class as the startup class, if the push function is not needed, uemng_push_id is set to empty, If you do not need to customize Push click, set the last parameter to false

```kotlin
package com.demo.umeng.app

import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid

class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "uemng_app_key", "default",
                false, "uemng_message_secret", false)
    }
}
```

#### Modify MainActivity, add Umeng settings

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

#### Modify the AndroidManifest.xml file

```xml
<application
  android:name="com.demo.umeng.app.MyFlutterApplication">
</application>
```

### IOS settings (with Swift example)

#### Modify AppDelegate.swift file, If Push function is not needed then pushEnabled is set to false

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

    // If you need to handle custom Push clicks, use the following code
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        UmengAnalyticsPushFlutterIos.handleCustomMessagePush(userInfo)
        completionHandler()
    }
}
```

#### Modify Runner-Bridging-Header.h file

```objectivec
#import "GeneratedPluginRegistrant.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import <umeng_analytics_push/UmengAnalyticsPushIos.h>
```

### Use in Flutter

#### Operation Alias

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.addAlias('1001', 'jobcode');
UmengAnalyticsPush.setAlias('1002', 'jobcode');
UmengAnalyticsPush.deleteAlias('1002', 'jobcode');
```

#### Operation Tags

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.addTags('manager');
UmengAnalyticsPush.deleteTags('manager');
```

#### Page buried point operation

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.pageStart('memberPage');
UmengAnalyticsPush.pageEnd('memberPage');
```

#### Custom event

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.event('customEvent', '1000');
```

#### Custom click Push response(Turn on the switch when initialization is required)

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UmengAnalyticsPush.addPushCustomMessageCallback((custom) {
  print(custom);
});
```
