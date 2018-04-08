//
//  PCOrderCommentViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PCOrderModel.h"

@interface PCOrderCommentViewController : UIViewController

//@property (nonatomic, weak) PCOrderModel *orderModel;
@property (nonatomic, copy) NSString *iconImageUrl;

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
