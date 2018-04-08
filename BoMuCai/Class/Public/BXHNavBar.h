//
//  BXHNavBar.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXHNavBar : UIView

@property (nonatomic, strong) UIColor *shadeColor;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

- (void)backAlphaChange:(CGFloat)alpha up:(BOOL)up;

@end
