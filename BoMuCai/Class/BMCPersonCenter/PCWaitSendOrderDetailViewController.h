//
//  PCWaitSendOrderDetailViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCWaitSendOrderDetailViewController;
@protocol PCWaitSendOrderDetailViewControllerProtcol <NSObject>

- (void)waitSendDetailControllerDelOrder:(PCWaitSendOrderDetailViewController *)viewController;

@end

@interface PCWaitSendOrderDetailViewController : UIViewController

@property (nonatomic, weak) id <PCWaitSendOrderDetailViewControllerProtcol>protcol;

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
