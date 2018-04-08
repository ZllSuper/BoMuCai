//
//  AppDelegate.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "AppDelegate.h"
#import "BXHLaunchViewController.h"
#import "BMCCartViewController.h"
#import "BMCHomeViewController.h"
#import "BMCTypeViewController.h"
#import "BMCTenderHallViewController.h"
#import "BMCPersonCenterViewController.h"

#import "BXHPayUtil.h"
#import "BXHWXPayUtil.h"
#import "BXHBankPayManager.h"

#import "WXApiManager.h"

#import "BXHAlertViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <TencentOpenAPI/TencentOAuth.h>


@interface AppDelegate () <BXHLaunchViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    EMOptions *options = [EMOptions optionsWithAppkey:@"1143170301115115#baicai"];
    options.apnsCertName = @"BaiCaiDevelopPush";

    EMError *error = [[EMClient sharedClient] initializeSDKWithOptions:options];
    if (error)
    {
        
    }
    
    [BXHWXPayUtil registAppWithAppKey:@"wx5c1124364bed58d5"];
    
    self.window = [[UIWindow alloc] initWithFrame:DEF_SCREENBOUNDS];
    
    self.mainTabBarController = [[BXHTabBarController alloc] init];
    
    BXHLaunchViewController *vc = [[BXHLaunchViewController alloc] init];
    vc.delegate = self;
    self.window.rootViewController = self.mainTabBarController;
//    [self.window makeKeyAndVisible];
    [vc show];
//    [self.mainTabBarController presentViewController:vc animated:NO completion:nil];
    
    // Override point for customization after application launch.
    return YES;

}

- (void)socketLink
{
   
}

- (void)baiduSourceInit
{
//    self.mapManager = [[BMKMapManager alloc]init];
//    BOOL ret = [self.mapManager start:@"o4qG7uwwdT8QOl4ikMECxAnW" generalDelegate:self];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
    //定位服务是否可用
}

- (void)locatonAuthReuqest
{
    BOOL enable = [CLLocationManager locationServicesEnabled];
    //是否具有定位权限
    int status = [CLLocationManager authorizationStatus];
    if(!enable || status == 0)
    {
        //请求权限
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
        {
            //由于IOS8中定位的授权机制改变 需要进行手动授权
            CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
            //获取授权认证
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
    }
    else if (status == kCLAuthorizationStatusRestricted)
    {
        BXHAlertViewController *alertController = [BXHAlertViewController alertControllerWithTitle:@"提示" type:BXHAlertMessageType];
        alertController.message = @"定位功能不可用！";
        [alertController addAction:[BXHAlertAction actionWithTitle:@"确定" titleColor:Color_Main_Light handler:^(BXHAlertAction *action) {
            
        }]];
        [self.mainTabBarController presentViewController:alertController animated:YES completion:nil];
    }
    else if (status == kCLAuthorizationStatusDenied)
    {
        
        BXHAlertViewController *alertController = [BXHAlertViewController alertControllerWithTitle:@"提示" type:BXHAlertMessageType];
        alertController.message = @"定位权限未开启，请前往隐私修改！";
        [alertController addAction:[BXHAlertAction actionWithTitle:@"立即前往" titleColor:Color_Main_Light handler:^(BXHAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }]];
        [alertController addAction:[BXHAlertAction actionWithTitle:@"取消" titleColor:Color_Text_LightGray handler:^(BXHAlertAction *action) {
        }]];
        
        [self.mainTabBarController presentViewController:alertController animated:YES completion:nil];
    }
    
}

//- (void)remoteLonginAction:(NSDictionary *)dict
//{
//    [[BXHSocketManager instanceManager] close];
//    BXHAlertViewController *alertController = [BXHAlertViewController alertControllerWithTitle:@"提示" type:BXHAlertMessageType];
//    alertController.message = @"您的账号在其他地方登录了！";
//    [alertController addAction:[BXHAlertAction actionWithTitle:@"重新登录" titleColor:Color_Main_Light handler:^(BXHAlertAction *action) {
//        [[BXHSocketManager instanceManager] reconnect];
//        
//    }]];
//    [alertController addAction:[BXHAlertAction actionWithTitle:@"退出登录" titleColor:Color_Text_LightGray handler:^(BXHAlertAction *action) {
//        [KAccountInfo logout];
//        [MainAppDelegate.mainTabBarController logOut];
//    }]];
//    [self.rootViewController presentViewController:alertController animated:YES completion:nil];
//}


#pragma mark launchDelegate

- (void)netWorkStatusChangeMorn
{
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if(status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown)
//        {
//            [[BXHSocketManager instanceManager] close];
//        }
//        else
//        {
//            if ([BXHSocketManager instanceManager].socketState == BXHSocketClose)
//            {
//                [[BXHSocketManager instanceManager] reconnect];
//            }
//        }
//        
//    }];
}


- (void)bxhLaunchViewControllerDidDismiss:(BXHLaunchViewController *)vc
{
//    [self locatonAuthReuqest];
}

- (void)bxhLaunchViewControllerWillDismiss:(BXHLaunchViewController *)vc
{
    
    [self baiduSourceInit];

    [self.window makeKeyAndVisible];
    
    BMCHomeViewController *homeVc = [[BMCHomeViewController alloc] init];
    
    BaseNaviController *nav1 = [[BaseNaviController alloc] initWithRootViewController:homeVc];
    BaseNaviController *nav2 = [[BaseNaviController alloc] initWithRootViewController:[[BMCTypeViewController alloc] init]];
    BaseNaviController *nav3 = [[BaseNaviController alloc] initWithRootViewController:[[BMCTenderHallViewController alloc] init]];
    BaseNaviController *nav4 = [[BaseNaviController alloc] initWithRootViewController:[[BMCCartViewController alloc] init]];
    BaseNaviController *nav5 = [[BaseNaviController alloc] initWithRootViewController:[[BMCPersonCenterViewController alloc] init]];
    
    self.mainTabBarController.controllers = @[nav1,nav2,nav3,nav4,nav5];
    
    [homeVc requestRefresh];
    
    [self netWorkStatusChangeMorn];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[BXHPayUtil shareInstance] alipayResultUrl:url];
    }
    else if([url.host isEqualToString:@"pay"])
    {
        [[BXHWXPayUtil shareInstance] handleOpenUrl:url];
    }
    else if ([url.host isEqualToString:@"uppayresult"])
    {
        [[BXHBankPayManager defaultManager] handleWithUrl:url];
    }
    else if ([url.host isEqualToString:@"oauth"])
    {
        [[WXApiManager sharedManager] handleOpenUrl:url];
    }
    else
    {
        [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"])
    {
        //跳转支付宝钱包进行支付，处理支付结果
        [[BXHPayUtil shareInstance] alipayResultUrl:url];
    }
    else if ([url.host isEqualToString:@"pay"])
    {
        [[BXHWXPayUtil shareInstance] handleOpenUrl:url];
    }
    else if ([url.host isEqualToString:@"uppayresult"])
    {
        [[BXHBankPayManager defaultManager] handleWithUrl:url];
    }
    else if ([url.host isEqualToString:@"oauth"])
    {
        [[WXApiManager sharedManager] handleOpenUrl:url];
    }
    else
    {
        [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}


@end
