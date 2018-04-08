//
//  WaresShopCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaresShopCell : UITableViewCell

@property (nonatomic, strong) UIImageView *shopIconImageView;

@property (nonatomic, strong) UILabel *shopNameLabel;

@property (nonatomic, strong) UIButton *goinBtn;

+ (CGFloat)showHeight;

@end
