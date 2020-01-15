#import "UmengAnalyticsPushPlugin.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

@interface UmengAnalyticsPushPlugin () <UNUserNotificationCenterDelegate>
@end

#endif

@implementation UmengAnalyticsPushPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"umeng_analytics_push"
            binaryMessenger:[registrar messenger]];
  UmengAnalyticsPushPlugin* instance = [[UmengAnalyticsPushPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]) {
      [self init:call result:result];
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

- (void)init:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appKey = call.arguments[@"key"];

  NSString *channel = call.arguments[@"channel"];
  if (!channel) channel = @"default";

  [UMConfigure initWithAppkey:appKey channel:channel];

  NSNumber *logEnable = call.arguments[@"logEnable"];
  if (logEnable) [UMConfigure setLogEnabled:[logEnable boolValue]];

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

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMConfigure setLogEnabled:YES];

    [UMConfigure initWithAppkey:@"你的友盟iOSAppKey" channel:@"appstore"];
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge | UMessageAuthorizationOptionAlert | UMessageAuthorizationOptionSound;
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
#endif
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError *_Nullable error) {
        if (granted) {
        } else {
        }
    }];
    return YES;
}

@end
