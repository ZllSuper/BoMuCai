//
//  QQApiManager.h
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>

typedef void(^QQLoginCallBack)(BOOL success, NSString *message, NSString *userId, NSString *nickName, NSString *headerImage);

@interface QQApiManager : NSObject <TencentSessionDelegate>

+ (QQApiManager *)shareInstance;

- (void)qqStartLoginWithCallBack:(QQLoginCallBack)callBack;

@end
