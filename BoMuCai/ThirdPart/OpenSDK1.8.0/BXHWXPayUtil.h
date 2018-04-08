//
//  BXHWXPayUtil.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/9/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "BCPayModel.h"

typedef void(^PayResultCallBack)(BOOL sucdess, NSString *message);

@interface BXHWXPayUtil : NSObject <WXApiDelegate>

+ (instancetype)shareInstance;

+ (void)registAppWithAppKey:(NSString *)appKey;

- (void)handleOpenUrl:(NSURL *)url;

- (void)startPayWithPayModel:(BCPayModel *)payModel withCallBack:(PayResultCallBack)callBack;

@end
