//
//  WaresSectionHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresSectionHeaderView.h"

@interface WaresSectionHeaderView()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) MASConstraint *lineViewCenterX;

@end

@implementation WaresSectionHeaderView

+ (CGFloat)showHeight
{
    return 44;
}

- (instancetype) init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        [self addSubview:self.detailBtn];
        [self addSubview:self.commentBtn];
        
        UIView *grayLine = [self grayLineView];
        [self addSubview:grayLine];
        [self addSubview:self.lineView];
        
        [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
            make.right.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(120);
        }];
        
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
            make.left.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(120);
        }];
        
        [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(1);
            self.lineViewCenterX = make.centerX.mas_equalTo(self).offset(-60);
        }];
        
    }
    return self;
}

#pragma mark - action
- (void)detailBtnAction
{
//    if (self.detailBtn.selected)
//    {
//        return;
//    }
//    self.commentBtn.selected = NO;
//    self.detailBtn.selected = YES;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.lineViewCenterX.offset = -60;
//        [self layoutIfNeeded];
//    }];
//
//    if (self.delegate)
//    {
//        [self.delegate sectionView:self actionType:SectionDetailActionType];
//    }
    
    if (self.delegate)
    {
        BOOL res = [self.delegate sectionView:self actionType:SectionDetailActionType];
        if (res) {
            if (self.detailBtn.selected)
            {
                return;
            }
            self.commentBtn.selected = NO;
            self.detailBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.lineViewCenterX.offset = -60;
                [self layoutIfNeeded];
            }];
        }
    }
}

- (void)commentBtnAction
{
//    if (self.commentBtn.selected)
//    {
//        return;
//    }
//    self.commentBtn.selected = YES;
//    self.detailBtn.selected = NO;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.lineViewCenterX.offset = 60;
//        [self layoutIfNeeded];
//    }];
//
//    if (self.delegate)
//    {
//        [self.delegate sectionView:self actionType:SectionCommentActionType];
//    }
//
    if (self.delegate)
    {
        BOOL res = [self.delegate sectionView:self actionType:SectionCommentActionType];
        if (res) {
            if (self.commentBtn.selected)
            {
                return;
            }
            self.commentBtn.selected = YES;
            self.detailBtn.selected = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.lineViewCenterX.offset = 60;
                [self layoutIfNeeded];
            }];
        }
    }
}

#pragma mark - get
- (UIButton *)detailBtn
{
    if (!_detailBtn)
    {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"商品详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        [_detailBtn setTitleColor:Color_Main_Dark forState:UIControlStateSelected];
        _detailBtn.titleLabel.font = Font_sys_14;
        [_detailBtn addTarget:self action:@selector(detailBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _detailBtn.selected = YES;
    }
    return _detailBtn;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn)
    {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitle:@"商品评价" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        [_commentBtn setTitleColor:Color_Main_Dark forState:UIControlStateSelected];
        _commentBtn.titleLabel.font = Font_sys_14;
        [_commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Color_Main_Dark;
    }
    return _lineView;
}

- (UIView *)grayLineView
{
    UIView *grayLineView = [[UIView alloc] init];
    grayLineView.backgroundColor = Color_Gray_Line;
    return grayLineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
