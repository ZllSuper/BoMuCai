//
//  CarConfirmPayViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarConfrimPayModel : NSObject

@property (nonatomic, copy) NSString *orderId; //	订单编号

@property (nonatomic, copy) NSString *amount; //	订单金额

@property (nonatomic, copy) NSString *realAmount; //	修改订单金额

@property (nonatomic, copy) NSString *yunfei; //	运费

@property (nonatomic, copy) NSString *couponPrice; //	优惠金额

@end

@interface CarConfirmPayViewController : UIViewController

- (instancetype) initWithCarConfirmPayModel:(CarConfrimPayModel *)model;

@end
