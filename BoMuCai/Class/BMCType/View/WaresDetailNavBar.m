//
//  WaresDetailNavBar.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailNavBar.h"

@implementation WaresDetailNavBar

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithScrollView:scrollView])
    {
        [self addSubview:self.backBtn];
        [self addSubview:self.collectBtn];
        [self addSubview:self.shareBtn];
        
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self).offset(10);
        }];
        
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self).offset(10);
        }];
        
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.shareBtn.mas_left).offset(-10);
            make.centerY.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
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
            [self.backBtn setImage:ImageWithName(@"WhiteArrow") forState:UIControlStateNormal];
            [self.backBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
            [self.collectBtn setImage:ImageWithName(@"WaresUnCollectIcon") forState:UIControlStateNormal];
            [self.collectBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
            [self.shareBtn setImage:ImageWithName(@"WaresShareIcon") forState:UIControlStateNormal];
            [self.shareBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
            self.shareBtn.alpha = self.backBtn.alpha = self.collectBtn.alpha = 1 / 0.5 * (0.5 - alpha);
        }
        else
        {
            //alpha 0.5 ====> 1   btn  0 ==== > 1 select = YES
            //  1 / 0.5 * (alpha - 0.5)
            [self.backBtn setImage:ImageWithName(@"PublicBackArrow") forState:UIControlStateNormal];
            [self.backBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.collectBtn setImage:ImageWithName(@"WaresBlackUnCollectIcon") forState:UIControlStateNormal];
            [self.collectBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.shareBtn setImage:ImageWithName(@"WaresBlackShareIcon") forState:UIControlStateNormal];
            [self.shareBtn setBackgroundImage:nil forState:UIControlStateNormal];
            self.shareBtn.alpha = self.backBtn.alpha = self.collectBtn.alpha = 1 / 0.5 * (alpha - 0.5);
        }
        
        //        NSLog(@"大 alpha = %f", self.leftBtn.alpha);
        
    }
    else //内容向下  alpha ====> 0
    {
        //alpha 1 ====> 0.5   btn 1 ==== > 0  select = YES
        // 1 / 0.5 * (alpha - 0.5)
        if (alpha >= 0.5)
        {
            [self.backBtn setImage:ImageWithName(@"PublicBackArrow") forState:UIControlStateNormal];
            [self.backBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.collectBtn setImage:ImageWithName(@"WaresBlackUnCollectIcon") forState:UIControlStateNormal];
            [self.collectBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [self.shareBtn setImage:ImageWithName(@"WaresBlackShareIcon") forState:UIControlStateNormal];
            [self.shareBtn setBackgroundImage:nil forState:UIControlStateNormal];
            self.shareBtn.alpha = self.backBtn.alpha = self.collectBtn.alpha =  1 / 0.5 * (alpha - 0.5);
        }
        else  //alpha 0.5 ====> 0   btn 0 ==== > 1 select = NO
        {     // 1 / 0.5 * (0.5 - alpha)
            
            [self.backBtn setImage:ImageWithName(@"WhiteArrow") forState:UIControlStateNormal];
            [self.backBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
            [self.collectBtn setImage:ImageWithName(@"WaresUnCollectIcon") forState:UIControlStateNormal];
            [self.collectBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
            [self.shareBtn setImage:ImageWithName(@"WaresShareIcon") forState:UIControlStateNormal];
            [self.shareBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
            self.shareBtn.alpha = self.backBtn.alpha = self.collectBtn.alpha = 1 / 0.5 * (0.5 - alpha);
        }
        //        NSLog(@"小 alpha = %f", self.leftBtn.alpha);
    }

}

#pragma mark - get
- (UIButton *)backBtn
{
    if (!_backBtn)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:ImageWithName(@"WhiteArrow") forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
        _backBtn.layer.cornerRadius = 15;
        _backBtn.layer.masksToBounds = YES;

    }
    return _backBtn;
}

- (UIButton *)collectBtn
{
    if (!_collectBtn)
    {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:ImageWithName(@"WaresCollectIcon") forState:UIControlStateSelected];
        [_collectBtn setImage:ImageWithName(@"WaresUnCollectIcon") forState:UIControlStateNormal];
        [_collectBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
        _collectBtn.layer.cornerRadius = 15;
        _collectBtn.layer.masksToBounds = YES;
    }
    return _collectBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn)
    {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:ImageWithName(@"WaresShareIcon") forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:ImageWithColor([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]) forState:UIControlStateNormal];
        _shareBtn.layer.cornerRadius = 15;
        _shareBtn.layer.masksToBounds = YES;
    }
    return _shareBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
