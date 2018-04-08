//
//  BMShareView.m
//  BoMuCai
//
//  Created by Lala on 2017/12/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMShareView.h"

@interface BMShareView ()
@property (nonatomic, assign) CGFloat pickHeight;
@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, copy) BMShareViewBlock block;

@property (nonatomic, strong) UIButton *wxSessionButton;
@property (nonatomic, strong) UILabel *wxSessionLabel;

@property (nonatomic, strong) UIButton *wxTimeLineButton;
@property (nonatomic, strong) UILabel *wxTimeLineLabel;

@end

@implementation BMShareView

- (instancetype _Nullable )initWithCompletionBlock:(BMShareViewBlock _Nullable )completionBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _pickHeight = 216.0;
        _barHeight = 44.0;
        CGRect contentFrame = self.contentView.frame;
        contentFrame.size.height = _pickHeight + _barHeight;
        
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelButton.layer.cornerRadius = 5;
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.layer.borderColor = [UIColor grayColor].CGColor;
        _cancelButton.clipsToBounds = YES;
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cancelButton];
        
        _wxSessionButton = [[UIButton alloc] init];
        [_wxSessionButton setImage:ImageWithName(@"微信好友") forState:UIControlStateNormal];
        [_wxSessionButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_wxSessionButton];
        
        _wxSessionLabel = [[UILabel alloc] init];
        _wxSessionLabel.text = @"微信";
        _wxSessionLabel.textAlignment = NSTextAlignmentCenter;
        _wxSessionLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_wxSessionLabel];

        _wxTimeLineButton = [[UIButton alloc] init];
        [_wxTimeLineButton setImage:ImageWithName(@"微信朋友圈") forState:UIControlStateNormal];
        [_wxTimeLineButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_wxTimeLineButton];
        
        _wxTimeLineLabel = [[UILabel alloc] init];
        _wxTimeLineLabel.text = @"朋友圈";
        _wxTimeLineLabel.textAlignment = NSTextAlignmentCenter;
        _wxTimeLineLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_wxTimeLineLabel];

        self.block = completionBlock;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGFloat h = _barHeight + _pickHeight;
    self.contentView.frame = CGRectMake(0, size.height - h, size.width, h);
    
    self.cancelButton.frame = CGRectMake(20, self.contentView.bounds.size.height-64, self.contentView.bounds.size.width-40, 44);
    
    self.wxSessionButton.frame = CGRectMake(DEF_SCREENWIDTH/2-60-30, 30, 60, 60);
    self.wxTimeLineButton.frame = CGRectMake(DEF_SCREENWIDTH/2+30, 30, 60, 60);

    self.wxSessionLabel.frame = CGRectMake(DEF_SCREENWIDTH/2-60-30, 30+60, 60, 20);
    self.wxTimeLineLabel.frame = CGRectMake(DEF_SCREENWIDTH/2+30, 30+60, 60, 20);
}

- (void)cancelButtonAction
{
    [super dismissWithCompletionBlock:^(BOOL finished) {
        if (self.block) {
//            self.block(BMShareTypeWXNone);
            self.block = nil;
        }
        [self removeFromSuperview];
    }];
}

- (void)shareButtonAction:(UIButton *)button
{
    if (self.block) {
        if (button == _wxSessionButton) {
            [super dismissWithCompletionBlock:^(BOOL finished) {
                self.block(BMShareTypeWXSession);
                self.block = nil;
                [self removeFromSuperview];
            }];
        }
        else {
            [super dismissWithCompletionBlock:^(BOOL finished) {
                self.block(BMShareTypeWXTimeline);
                self.block = nil;
                [self removeFromSuperview];
            }];
        }
    }
}

@end
