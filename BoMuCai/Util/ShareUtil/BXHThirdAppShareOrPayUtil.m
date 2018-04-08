//
//  BXHThirdAppShareOrPayUtil.m
//  ECar
//
//  Created by 步晓虎 on 15/2/8.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import "BXHThirdAppShareOrPayUtil.h"
#import "JKPopMenuView.h"
#import "NSString+BXHMyString.h"

@interface BXHThirdAppShareOrPayUtil () 

@property (nonatomic, strong) WXSharePlug *wxPlug;

@property (nonatomic, strong) QQSharePlug *qqPlug;

@property (nonatomic, strong) WBSharePlug *wbPlug;

@property (nonatomic, strong) MessageSharePlug *messagePlug;

@property (nonatomic, copy) BXHThirdAppShareOrPayHandel callBack;

@property (nonatomic, strong) TencentOAuth *oAuth;

@end

@implementation BXHThirdAppShareOrPayUtil

+ (BXHThirdAppShareOrPayUtil *)shareInstance
{
    static BXHThirdAppShareOrPayUtil *util = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[BXHThirdAppShareOrPayUtil alloc] init];
    });
    return util;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.wxPlug = [[WXSharePlug alloc] init];
        self.qqPlug = [[QQSharePlug alloc] init];
        self.wbPlug = [[WBSharePlug alloc] init];
        self.messagePlug = [[MessageSharePlug alloc] init];
        
        [self callBackControl];
    }
    return self;
}

#pragma mark - AppInstall
+ (BOOL)isWxInstall
{
    return [WXApi isWXAppInstalled];
}

+ (BOOL)isWbInstall
{
    return [WeiboSDK isWeiboAppInstalled];
}

+ (BOOL)isQQInstall
{
    return [TencentApiInterface isTencentAppInstall:kIphoneQQ];
}

+ (BOOL)canSendMessage
{
    return [MFMessageComposeViewController canSendText];
}

+ (BOOL)canSendMediaMessage
{
    return [MFMessageComposeViewController canSendAttachments];
}

#pragma mark -ConnectApp

- (void)connectQQAuth:(NSString *)appId
{
    self.oAuth = [[TencentOAuth alloc]initWithAppId:appId andDelegate:self];
//    [self.oAuth openSDKWebViewQQShareEnable];
//    self.oAuth.redirectURI = @"www.qq.com";
}

- (void)connectWXAPP:(NSString *)appId
{
    [WXApi registerApp:appId];
}

- (void)connectWBApp:(NSString *)appKey
{
    [WeiboSDK registerApp:appKey];
}

#pragma mark 回调
- (BOOL)handleOpenURL:(NSURL *)url application:(UIApplication *)application
{

    NSLog(@" appBack %@",[url.relativeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
   if ([[url host] isEqualToString:@"platformId=wechat"])
    {
        [WXApi handleOpenURL:url delegate:self.wxPlug];
    }
//    else if ([[url host] isEqualToString:@"pay"])
//    {
//        [WXApi handleOpenURL:url delegate:self];
//    }
    else if ([[url relativeString] hasPrefix:@"tencent1104718908"])
    {
        return  [QQApiInterface handleOpenURL:url delegate:self.qqPlug];
    }
    else if ([[url relativeString] hasPrefix:@"wb511000291"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self.wbPlug];
    }
    
    return YES;
}


#pragma makr - 开始分享
- (void)shareToTypes:(NSArray *)types title:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)image mediaType:(BXHMediaType)mediaType meida:(id)media handel:(BXHThirdAppShareOrPayHandel)handel
{
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    for (NSNumber *typeValue in types)
    {
        BXHShareType shareType = (BXHShareType)typeValue.integerValue;
        if (shareType == BXHWXSceneTimeline || shareType == BXHWXSceneSession)
        {
            if ([WXApi isWXAppInstalled])
            {
                [items addObject:[JKPopMenuItem itemWithType:shareType]];
            }
        }
        else if (shareType == BXHQQFriends || shareType == BXHQQZone)
        {
            if ([TencentApiInterface isTencentAppInstall:kIphoneQQ])
            {
                [items addObject:[JKPopMenuItem itemWithType:shareType]];
            }
        }
        else
        {
            [items addObject:[JKPopMenuItem itemWithType:shareType]];
        }
    }
    
    JKPopMenuView *jkpop = [JKPopMenuView menuViewWithItems:items];
    __weak BXHThirdAppShareOrPayUtil *weakSelf = self;
    [jkpop selectCallBack:^(JKPopMenuItem *item) {
        
        [weakSelf shareTitle:title descStr:desc thumbImage:image shareType:item.type mediaType:mediaType meida:media handel:handel];
    }];
    [jkpop show];
}

- (void)shareTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)image shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType meida:(id)media handel:(BXHThirdAppShareOrPayHandel)handel
{
    self.callBack = handel;
    self.callBack(1,ShareStatuesBegain,@"开始分享",shareType);
    switch (shareType)
    {
        case BXHWXSceneSession:
        case BXHWXSceneTimeline:
        {
            [self.wxPlug shareWithTitle:title descStr:desc thumbImage:image shareType:shareType mediaType:mediaType media:media];
        }
            break;
         case BXHQQFriends:
         case BXHQQZone:
        {
            [self.qqPlug shareWithTitle:title descStr:desc thumbImage:image shareType:shareType mediaType:mediaType media:media];
        }
            break;
        case BXHMessage:
        {
            [self.messagePlug shareWithTitle:title descStr:desc thumbImage:image shareType:shareType mediaType:mediaType media:media];
        }
            break;
        case BXHWeiBo:
        {
            [self.wbPlug shareWithTitle:title descStr:desc thumbImage:image shareType:shareType mediaType:mediaType media:media];
        }
            break;
        default:
            break;
    }
}

#pragma mark - EndShareCallBack
- (void)callBackControl
{
    __weak BXHThirdAppShareOrPayUtil *weakSelf = self;
    
    [self.wxPlug setShareCallBack:^(ShareStatues statue, NSString *message, NSInteger code) {
        weakSelf.callBack(code,statue,message,BXHWXSceneSession);
    }];
    
    [self.qqPlug setShareCallBack:^(ShareStatues statue, NSString *message, NSInteger code) {
        weakSelf.callBack(code,statue,message,BXHQQFriends);
    }];

    [self.wbPlug setShareCallBack:^(ShareStatues statue, NSString *message, NSInteger code) {
        weakSelf.callBack(code,statue,message,BXHWeiBo);
    }];

    [self.messagePlug setShareCallBack:^(ShareStatues statue, NSString *message, NSInteger code) {        weakSelf.callBack(code,statue,message,BXHMessage);
    }];
    
}


//#pragma mark - 微信wxDelegate
//-(void)onResp:(BaseResp*)resp
//{
////    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
////    NSString *strTitle;
//    /*if([resp isKindOfClass:[PayResp class]])
//    {
////        [[WXPayClient shareInstance] clean];
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        strTitle = [NSString stringWithFormat:@"支付结果"];
//        switch (resp.errCode)
//        {
//            case WXSuccess:
//                strMsg = @"支付结果：成功！";
////                [WXPayClient shareInstance].callBack(YES,nil);
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                break;
//                
//            default:
//                if([NSString stringIsEmpty:resp.errStr]) resp.errStr = @"支付失败";
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                [WXPayClient shareInstance].callBack(NO,[NSError errorWithDomain:resp.errStr code:resp.errCode userInfo:nil]);
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                break;
//        }
//    }
//    else*/ if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        if([NSString stringIsEmpty:resp.errStr]) resp.errStr = @"分享失败";
//        NSError *error = [NSError errorWithDomain:resp.errStr code:resp.errCode userInfo:nil];
//        self.callBack(error,resp.errCode == 0,@"");
//    }
//    else if([resp isKindOfClass:[SendAuthResp class]])
//    {
//        SendAuthResp *temp = (SendAuthResp*)resp;
//        
//        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else if ([resp isKindOfClass:[SendMessageToQQResp class]])
//    {
//        SendMessageToQQResp *sResp = (SendMessageToQQResp *)resp;
//        NSError *error = [NSError errorWithDomain:@"分享失败" code:[sResp.result integerValue] userInfo:nil];
//        self.callBack(error,[sResp.result integerValue] == 0,@"");
//    }
//}



@end
