//
//  PCApplyRefundResultViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PCApplyRefundResultViewControllerDelegate <NSObject>


@end

@interface PCApplyRefundResultViewController : UIViewController

@property (nonatomic, weak) id <PCApplyRefundResultViewControllerDelegate>delegate;

@end
