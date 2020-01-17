#import "UmengAnalyticsPushPlugin.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>

@implementation UmengAnalyticsPushPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"umeng_analytics_push"
            binaryMessenger:[registrar messenger]];
  UmengAnalyticsPushPlugin* instance = [[UmengAnalyticsPushPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"addTags" isEqualToString:call.method]) {
      [self addTags:call result:result];
  } else if ([@"deleteTags" isEqualToString:call.method]) {
      [self deleteTags:call result:result];
  } else if ([@"addAlias" isEqualToString:call.method]) {
      [self addAlias:call result:result];
  } else if ([@"setAlias" isEqualToString:call.method]) {
      [self setAlias:call result:result];
  } else if ([@"deleteAlias" isEqualToString:call.method]) {
      [self deleteAlias:call result:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)addTags:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *tags = call.arguments[@"tags"];
  [UMessage addTags:@tags response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
      }
  }];
}

- (void)deleteTags:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *tags = call.arguments[@"tags"];
  [UMessage deleteTags:tags response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
      }
  }];
}

- (void)addAlias:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *alias = call.arguments[@"alias"];
  NSString *type = call.arguments[@"type"];
  [UMessage addAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
  }];
}

- (void)setAlias:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *alias = call.arguments[@"alias"];
  NSString *type = call.arguments[@"type"];
  [UMessage setAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
  }];
}

- (void)deleteAlias:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *alias = call.arguments[@"alias"];
  NSString *type = call.arguments[@"type"];
  [UMessage removeAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
  }];
}

@end
