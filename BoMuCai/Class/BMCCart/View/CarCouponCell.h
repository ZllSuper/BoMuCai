//
//  CarCouponCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCouponModel.h"

@interface CarCouponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *derateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIButton *selBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *limitLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftIconImageView;

@property (weak, nonatomic) ShopCouponModel *weakModel;

@end
