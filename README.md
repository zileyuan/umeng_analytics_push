# Umeng Analytics&Push Flutter Plugins（umeng_analytics_push） [![pub package](https://img.shields.io/pub/v/umeng_analytics_push)](https://pub.flutter-io.cn/packages/umeng_analytics_push)

- Language: [English](https://github.com/zileyuan/umeng_analytics_push) | [中文简体](https://github.com/zileyuan/umeng_analytics_push/blob/master/README_zh.md)
- Umeng API: [umeng:analytics](https://mobile.umeng.com/analytics) & [umeng:push](https://mobile.umeng.com/push)
- Note: The following document description shall prevail, do not refer to the settings in the example

## Usages

### Import

[![pub package](https://img.shields.io/pub/v/umeng_analytics_push)](https://pub.flutter-io.cn/packages/umeng_analytics_push)

```yaml
dependencies:
  umeng_analytics_push: ^x.x.x #The latest version is shown above, plugin1.x supports flutter1.x, plugin2.x supports flutter2.x

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
                false, "uemng_message_secret")
    }
}
```

#### Modify MainActivity, add Umeng settings

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

#### Modify the AndroidManifest.xml file

```xml
<application
  android:name="com.demo.umeng.app.MyFlutterApplication">
</application>
```

#### Add the vendor push channel, see the official documentation for details [umeng:push:vendor](https://developer.umeng.com/docs/67966/detail/98589)

##### Modify MyFlutterApplication

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

##### Modify the AndroidManifest.xml, fill in the real id or key

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

##### Use the following parameters to send, accept offline messages

```js
"mipush": true
"mi_activity": "io.github.zileyuan.umeng_analytics_push.OfflineNotifyClickActivity"  
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

    // If you need to handle Push clicks, use the following code
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        UmengAnalyticsPushFlutterIos.handleMessagePush(userInfo)
        completionHandler()
    }
}
```

#### Modify Runner-Bridging-Header.h file

```objectivec
#import "GeneratedPluginRegistrant.h"
#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import <umeng_analytics_push/UmengAnalyticsPushIos.h>
```

### Use in Flutter

#### Click Push response

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';
import 'package:umeng_analytics_push/message_model.dart';

UmengAnalyticsPush.addPushMessageCallback((MessageModel message) {
  print("UmengAnalyticsPush Message ======> $message");
});
```

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
