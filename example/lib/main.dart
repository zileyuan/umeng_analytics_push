import 'package:flutter/material.dart';
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    UmengAnalyticsPush.init('112233',
        channel: 'default', logEnable: true, "334455");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('UmengAnalytics on\n'),
        ),
      ),
    );
  }
}
