//
//  QQApiManager.m
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "QQApiManager.h"


@interface QQApiManager()

@property (nonatomic, strong) TencentOAuth *oAuth;

@property (nonatomic, copy) QQLoginCallBack callBack;

@end

@implementation QQApiManager

+ (QQApiManager *)shareInstance
{
    static dispatch_once_t onceToken;
    static QQApiManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[QQApiManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.oAuth = [[TencentOAuth alloc] initWithAppId:@"101423971" andDelegate:self];
    }
    return self;
}

- (void)qqStartLoginWithCallBack:(QQLoginCallBack)callBack
{
    self.callBack = callBack;
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [self.oAuth setAuthShareType:AuthShareType_QQ];
    [self.oAuth authorize:permissions inSafari:NO];
}

#pragma mark - qqdelegate
- (void)tencentDidLogin
{
    if (![self.oAuth getUserInfo])
    {
        self.callBack(YES, @"登录失败", nil,nil,nil);
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    self.callBack(NO, @"退出登录", nil,nil,nil);
}

- (void)tencentDidNotNetWork
{
    self.callBack(NO, @"登录失败", nil,nil,nil);
}

- (void)getUserInfoResponse:(APIResponse *)response
{
    self.callBack(YES, @"登录成功", self.oAuth.openId,response.jsonResponse[@"nickname"],response.jsonResponse[@"figureurl_qq_2"]);
}

@end
