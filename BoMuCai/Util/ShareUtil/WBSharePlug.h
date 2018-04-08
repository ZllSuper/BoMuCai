//
//  WBSharePlug.h
//  QueenBK
//
//  Created by 步晓虎 on 15/8/24.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSharePlug.h"
#import "WeiboSDK.h"

#define kRedirectURI @"http://api.weibo.com/oauth2/default.html"

@interface WBSharePlug : BaseSharePlug<WeiboSDKDelegate>

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, copy) NSString *wbRefreshToken;

@end
