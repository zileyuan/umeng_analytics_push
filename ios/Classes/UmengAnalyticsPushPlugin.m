#import "UmengAnalyticsPlugin.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>

@implementation UmengAnalyticsPushPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"umeng_analytics_push"
            binaryMessenger:[registrar messenger]];
  UmengAnalyticsPushPlugin* instance = [[UmengAnalyticsPushPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]) {
      [self init:call result:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)init:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appKey = call.arguments[@"key"];

  NSString *channel = call.arguments[@"channel"];
  if (!channel) channel = @"default";

  [UMConfigure initWithAppkey:appKey channel:channel];

  NSNumber *logEnable = call.arguments[@"logEnable"];
  if (logEnable) [UMConfigure setLogEnabled:[logEnable boolValue]];

  NSString *messageSecret = call.arguments[@"messageSecret"];
  if (!messageSecret) messageSecret = @"";
}

@end
