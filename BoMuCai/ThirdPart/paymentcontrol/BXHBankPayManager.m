//
//  BXHBankPayManager.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/10/30.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHBankPayManager.h"
@interface BXHBankPayManager ()

@property (nonatomic) UPPaymentResultBlock callBack;

@end


@implementation BXHBankPayManager

+ (BXHBankPayManager *)defaultManager
{
    static dispatch_once_t onceToken;
    static BXHBankPayManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (BOOL)startPayWithTn:(NSString *)tn formViewController:(UIViewController *)vc andComplete:(UPPaymentResultBlock)block
{
    self.callBack = block;
    NSString *appScheme = @"BaiCaiUPPay";
    //00正式  //01测试
   return [[UPPaymentControl defaultControl] startPay:tn fromScheme:appScheme mode:@"00" viewController:vc];
}

- (void)handleWithUrl:(NSURL *)url
{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:self.callBack];
}

@end
