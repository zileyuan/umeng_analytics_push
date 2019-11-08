# umeng_analytics_push

Flutter plugin for [umeng:analytics](http://mobile.umeng.com/analytics)

## Usage

### Init

```dart
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

UMengAnalytics.init('AppKey', channel: 'default', policy: Policy.BATCH,
    encrypt: true, reportCrash: false);
```
