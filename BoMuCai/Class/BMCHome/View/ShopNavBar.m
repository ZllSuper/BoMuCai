//
//  ShopNavBar.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopNavBar.h"

@implementation ShopNavBar

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithScrollView:scrollView])
    {
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self).offset(10);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-10);
            make.size.mas_equalTo(CGSizeMake(60, 40));
            make.centerY.mas_equalTo(self).offset(10);
        }];
    }
    return self;
}

- (void)backAlphaChange:(CGFloat)alpha up:(BOOL)up
{
    // 0 - 1  0.5
//    NSLog(@"原始 alpha = %f", alpha);
    // 判断方向
    if (up) //内容向上  alpha ====> 1
    {
        //alpha 0 ====> 0.5   btn 1 ==== > 0   select = NO
        if (alpha <= 0.5)
        {
            // 1 / 0.5 * (0.5 - alpha)
            self.leftBtn.selected = self.rightBtn.selected = NO;
            self.leftBtn.alpha = self.rightBtn.alpha = 1 / 0.5 * (0.5 - alpha);
        }
        else
        {
            //alpha 0.5 ====> 1   btn  0 ==== > 1 select = YES
            //  1 / 0.5 * (alpha - 0.5)
            self.leftBtn.selected = self.rightBtn.selected = YES;
            self.leftBtn.alpha = self.rightBtn.alpha = 1 / 0.5 * (alpha - 0.5);
        }
        
//        NSLog(@"大 alpha = %f", self.leftBtn.alpha);

    }
    else //内容向下  alpha ====> 0
    {
        //alpha 1 ====> 0.5   btn 1 ==== > 0  select = YES
        // 1 / 0.5 * (alpha - 0.5)
        if (alpha >= 0.5)
        {
            self.leftBtn.selected = self.rightBtn.selected = YES;
            self.leftBtn.alpha = self.rightBtn.alpha =  1 / 0.5 * (alpha - 0.5);
        }
        else  //alpha 0.5 ====> 0   btn 0 ==== > 1 select = NO
        {     // 1 / 0.5 * (0.5 - alpha)
            
            self.leftBtn.selected = self.rightBtn.selected = NO;
            self.leftBtn.alpha = self.rightBtn.alpha = 1 / 0.5 * (0.5 - alpha);
        }
//        NSLog(@"小 alpha = %f", self.leftBtn.alpha);
    }
    
}

#pragma mark - get
- (UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:ImageWithName(@"PublicBackArrow") forState:UIControlStateSelected];
        [_leftBtn setImage:ImageWithName(@"WhiteArrow") forState:UIControlStateNormal];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_rightBtn setTitleColor:Color_MainText forState:UIControlStateSelected];
        _rightBtn.titleLabel.font = Font_sys_14;
    }
    return _rightBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
