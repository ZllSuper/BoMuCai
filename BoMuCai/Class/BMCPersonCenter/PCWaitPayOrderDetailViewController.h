//
//  PCWaitPayOrderDetailViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCWaitPayOrderDetailViewController;
@protocol PCWaitPayOrderDetailViewControllerProtcol <NSObject>

- (void)waitPayDetailControllerDelOrder:(PCWaitPayOrderDetailViewController *)viewController;

@end

@interface PCWaitPayOrderDetailViewController : UIViewController

@property (nonatomic, weak) id <PCWaitPayOrderDetailViewControllerProtcol>protcol;

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
