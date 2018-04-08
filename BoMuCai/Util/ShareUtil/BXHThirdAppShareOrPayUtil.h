//
//  BXHThirdAppShareOrPayUtil.h
//  ECar
//
//  Created by 步晓虎 on 15/2/8.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXSharePlug.h"
#import "QQSharePlug.h"
#import "MessageSharePlug.h"
#import "WBSharePlug.h"


typedef void (^BXHThirdAppShareOrPayHandel)(NSInteger code, ShareStatues statue, NSString *message,BXHShareType type);

@interface BXHThirdAppShareOrPayUtil : NSObject <TencentSessionDelegate>

//单例
+ (BXHThirdAppShareOrPayUtil *)shareInstance;

//注册qq
- (void)connectQQAuth:(NSString *)appId;

//注册微信
- (void)connectWXAPP:(NSString *)appId;

//注册微博
- (void)connectWBApp:(NSString *)appKey;

+ (BOOL)isWxInstall;

+ (BOOL)isWbInstall;

+ (BOOL)isQQInstall;

+ (BOOL)canSendMessage;

+ (BOOL)canSendMediaMessage;

//支付和分享回调
- (BOOL)handleOpenURL:(NSURL *)url application:(UIApplication *)application;

//一键分享
//types为BXHShareType集合  分享到哪些第三方
//mediaType 多媒体类型
//media 多媒体当为文字的时候不传
- (void)shareToTypes:(NSArray *)types title:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)image  mediaType:(BXHMediaType)mediaType meida:(id)media handel:(BXHThirdAppShareOrPayHandel)handel;

//分享单个
- (void)shareTitle:(NSString *)title descStr:(NSString *)desc thumbImage:(UIImage *)image shareType:(BXHShareType)shareType mediaType:(BXHMediaType)mediaType meida:(id)media handel:(BXHThirdAppShareOrPayHandel)handel;

@end
