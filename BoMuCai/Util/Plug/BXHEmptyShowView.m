//
//  BXHEmptyShowView.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/11/17.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import "BXHEmptyShowView.h"

@interface BXHEmptyShowView ()


@end

@implementation BXHEmptyShowView

+ (BXHEmptyShowView *)creatWithSuperView:(UIView *)superView andShowType:(BXHEmptyShowType)showType
{
    BXHEmptyShowView *showView = [[BXHEmptyShowView alloc] initWithFrame:superView.frame andShowType:showType];
    [superView addSubview:showView];
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(superView);
        make.height.mas_equalTo(superView);
        make.left.mas_equalTo(superView);
        make.top.mas_equalTo(superView);
    }];

    return showView;
}

- (instancetype) initWithFrame:(CGRect)frame andShowType:(BXHEmptyShowType)showType
{
    if (self = [super initWithFrame:frame])
    {
    
        self.showType = showType;
        self.backgroundColor = Color_White;
        self.hidden = YES;
        
        switch (self.showType)
        {
            case BXHEmptyImageType:
            {
                [self addSubview:self.imageView];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(self);
                }];
            }
                break;
            case BXHEmptyBtnType:
            {
                [self addSubview:self.actionBtn];
                [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(150, 40));
                }];

            }
                break;
            case BXHEmptyImageAndBtnType:
            {
                [self addSubview:self.imageView];
                [self addSubview:self.actionBtn];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.bottom.mas_equalTo(self.mas_centerY).offset(20);
                }];
                
                [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(150, 50));
                    make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
                }];

            }
                break;
            case BXHEmptyTitleAndBtnType:
            {
                [self addSubview:self.tipLabel];
                [self addSubview:self.actionBtn];
                [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.mas_centerY).offset(-30);
                    make.left.mas_equalTo(self).offset(30);
                    make.right.mas_equalTo(self).offset(-30);
                }];
                
                [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(150, 50));
                    make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(20);
                }];
            }
                break;
            case BXHEmptyImageAndTitleType:
            {
                [self addSubview:self.imageView];
                [self addSubview:self.tipLabel];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.bottom.mas_equalTo(self.mas_centerY).offset(-50);
                }];
                
                [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
                    make.left.mas_equalTo(self).offset(30);
                    make.right.mas_equalTo(self).offset(-30);
                }];


            }
                break;
            case BXHEmptyTitleImageAndBtnType:
            {
                [self addSubview:self.imageView];
                [self addSubview:self.tipLabel];
                [self addSubview:self.actionBtn];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.bottom.mas_equalTo(self.mas_centerY).offset(20);
                }];
                
                [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
                    make.left.mas_equalTo(self).offset(30);
                    make.right.mas_equalTo(self).offset(-30);
                }];

                [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(150, 50));
                    make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(20);
                }];
            }
                break;

            default:
            {
                [self addSubview:self.tipLabel];
                [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self).offset(30);
                    make.right.mas_equalTo(self).offset(-30);
                    make.centerY.mas_equalTo(self).offset(-40);
                }];
            }
                break;
        }
    }
    return self;
}

#pragma mark - public
- (void)showEmpty
{
    if (self.hidden == YES)
    {
        [self.superview bringSubviewToFront:self];
        self.hidden = NO; 
    }
}

- (void)hiddenEmpty
{
    if (self.hidden == NO)
    {
        self.hidden = YES;
    }
}

#pragma mark - action
- (void)requestAgainAction
{
    if (self.delegate)
    {
        [self.delegate emptyShowViewBtnActionDelegate:self];
    }
}

#pragma mark get

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = Font_sys_16;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = Color_MainText;
    }
    return _tipLabel;
}

- (UIButton *)actionBtn
{
    if (!_actionBtn)
    {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn addTarget:self action:@selector(requestAgainAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
