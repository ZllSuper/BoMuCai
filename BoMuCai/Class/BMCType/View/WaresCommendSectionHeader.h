//
//  WaresCommendSectionHeader.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaresCommendSectionHeader : UIView

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *leftLine;

@property (nonatomic, strong) UIView *rightLine;

+ (CGFloat)showHeight;

@end
