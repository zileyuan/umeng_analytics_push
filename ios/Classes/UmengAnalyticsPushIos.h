#import <Flutter/Flutter.h>

@interface UmengAnalyticsPushFlutterIos : NSObject

+ (void)iosInit:(NSDictionary *_Nullable)launchOptions appkey:(NSString *)appkey channel:(NSString *)channel logEnabled:(BOOL)logEnabled;

@end