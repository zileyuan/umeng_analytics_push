#import "UmengAnalyticsPushIos.h"
#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import <UMCommonLog/UMCommonLogHeaders.h>

extern FlutterEventSink _eventSink;
NSString *g_appkey;
NSString *g_channel;
NSDictionary *g_launchOptions;
@implementation UmengAnalyticsPushFlutterIos

+ (void)iosPreInit:(NSDictionary *_Nullable)launchOptions appkey:(NSString *)appkey channel:(NSString *)channel {
    g_launchOptions = launchOptions;
    g_appkey = appkey;
    g_channel = channel;
}
// 初始化友盟
+ (void)iosInit:(BOOL)logEnabled pushEnabled:(BOOL)pushEnabled {
    [UMConfigure setLogEnabled:logEnabled];
    [UMConfigure initWithAppkey:g_appkey channel:g_channel];
    NSLog(@"application init umeng ok");
    if (pushEnabled) {
        // Push组件基本功能配置
        UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
        //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
        entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
        [UMessage registerForRemoteNotificationsWithLaunchOptions:g_launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"================= PUSH授权成功 ====================");
            }else{
                NSLog(@"================= PUSH拒绝授权 ====================");
            }
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFuncion:) name:@"umeng_analytics_push" object:nil];
    }
}

// 处理友盟推送
+ (void)handleMessagePush:(NSDictionary *)userInfo {
    if (userInfo)
    {
        _eventSink(userInfo);
    }
}

@end