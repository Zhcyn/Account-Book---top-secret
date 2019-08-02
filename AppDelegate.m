#import "AppDelegate.h"
#import "JSDHomeViewController.h"
#import <MaterialComponents/MDCAppBarViewController.h>
#import <MaterialComponents/MDCAppBarNavigationController.h>
#import "JSDTabBarController.h"
#import "JSDUserPasswordCheckManage.h"
#import "AbcMMSDK.h"
#import <IQKeyboardManager.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()<JPUSHRegisterDelegate>
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JSDTabBarController* tabBarVC = [[JSDTabBarController alloc] init];
    [self configureBoardManager];
    if ([self currentTimeStr] < 1565225740) {
        self.window.rootViewController = tabBarVC;
    }else{
    [[AbcMMSDK sharedManager] initMMSDKLaunchOptions:launchOptions window:self.window rootController:tabBarVC switchRoute:0 userUrl:@"client1.sg04.com" dateStr:@"2019-08-08"];
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    JSDUserPasswordCheckManage* checkManage = [JSDUserPasswordCheckManage sharedInstance];
    [checkManage checkPasswrod];
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager]; manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES; manager.keyboardDistanceFromTextField = 10; manager.enableAutoToolbar = YES;
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
}
- (NSTimeInterval )currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970];
    return time;
}
@end
