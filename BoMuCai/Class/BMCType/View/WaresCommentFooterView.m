//
//  WaresCommentFooterView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresCommentFooterView.h"

@implementation WaresCommentFooterView

+ (CGFloat)showHeight
{
    return 44;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        [self addSubview:self.moreBtn];
        [self addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(1);
            make.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - get
- (UIButton *)moreBtn
{
    if (!_moreBtn)
    {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = Font_sys_14;
    }
    return _moreBtn;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Color_Gray_Line;
    }
    return _lineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
