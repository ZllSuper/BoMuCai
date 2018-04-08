//
//  PCFeedbackGoodsNumView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCFeedbackGoodsNumView.h"

@implementation PCFeedbackGoodsNumView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.goodsNumTextFiled];
        [self.goodsNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 16, 0, 16));
        }];
    }
    return self;
}

#pragma mark - get
- (UITextField *)goodsNumTextFiled
{
    if (!_goodsNumTextFiled)
    {
        _goodsNumTextFiled = [[UITextField alloc] init];
        _goodsNumTextFiled.textColor = Color_MainText;
        _goodsNumTextFiled.font = Font_sys_14;
        _goodsNumTextFiled.placeholder = @"请输入商品编号";
    }
    return _goodsNumTextFiled;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
