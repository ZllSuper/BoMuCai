//
//  BXHBankPayManager.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/10/30.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPPaymentControl.h"

@interface BXHBankPayManager : NSObject

+ (BXHBankPayManager *)defaultManager;

- (BOOL)startPayWithTn:(NSString *)tn formViewController:(UIViewController *)vc andComplete:(UPPaymentResultBlock)block;

- (void)handleWithUrl:(NSURL *)url;

@end
