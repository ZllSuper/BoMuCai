//
//  PCApplyRefundViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCApplyRefundResultViewController.h"

@interface PCApplyRefundViewController : UIViewController

@property (nonatomic, weak) id <PCApplyRefundResultViewControllerDelegate>delegate;

- (instancetype)initWithOrderId:(NSString *)orderId;

@end