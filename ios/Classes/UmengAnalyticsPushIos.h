#import <Flutter/Flutter.h>

@interface UmengAnalyticsPushFlutterIos : NSObject

+ (void)iosInit:(NSDictionary *_Nullable)launchOptions appKey:(NSString *)appKey channel:(NSString *)channel logEnabled:(BOOL)logEnabled;

@end