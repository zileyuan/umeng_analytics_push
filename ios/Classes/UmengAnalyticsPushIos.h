#import <Flutter/Flutter.h>

@interface UmengAnalyticsPushFlutterIos : NSObject

+ (void)iosPreInit:(NSDictionary *_Nullable)launchOptions appkey:(NSString *)appkey channel:(NSString *)channel;
+ (void)iosInit:(BOOL)logEnabled pushEnabled:(BOOL)pushEnabled;
+ (void)handleMessagePush:(NSDictionary *)userInfo;

@end