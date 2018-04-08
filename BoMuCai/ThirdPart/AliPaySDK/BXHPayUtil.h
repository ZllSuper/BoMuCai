//
//  BXHPayUtil.h
//  GuoGangTong
//
//  Created by 步晓虎 on 2017/1/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface BXHPayResultUtil : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, strong) NSDictionary *result;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *resultMsg;

@property (nonatomic, assign) NSUInteger resultStatus;

- (instancetype)initWithAliPayResult:(NSDictionary *)dict;

@end

@interface BXHPayUtil : NSObject

+ (BXHPayUtil *)shareInstance;

- (void)payCommodityName:(NSString *)name subName:(NSString *)subName tradeNo:(NSString *)tradeNo amount:(CGFloat)amount callBack:(CompletionBlock)callBack;

- (void)payWithSignOrderString:(NSString *)signStr complete:(CompletionBlock)complete;

- (void)alipayResultUrl:(NSURL *)url;

@end
