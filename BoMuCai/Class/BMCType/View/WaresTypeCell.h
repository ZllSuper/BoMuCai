//
//  WaresTypeCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaresTypeCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *rightLabel;

+ (CGFloat)showHeight;

@end
