//
//  PCFeedBackTextView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCFeedBackTextView.h"

#define MAXTextNum 500

@implementation PCFeedBackTextView
- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.textView];
        [self addSubview:self.textNumLabel];

        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self).offset(-10);
        }];
        
        [self.textNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-5);
            make.top.mas_equalTo(self.textView.mas_bottom);
            make.height.mas_equalTo(@30);
            make.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - TextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger lenth = textView.text.length;
    NSInteger num = MAXTextNum - lenth;
    if (num < 0)
    {
        self.textNumLabel.textColor = [UIColor redColor];
    }
    else
    {
        self.textNumLabel.textColor = Color_Text_LightGray;
    }
    self.textNumLabel.text = _StrFormate(@"余%ld",num);
}


#pragma mark - get
- (YMTextView *)textView
{
    if (!_textView)
    {
        _textView = [[YMTextView alloc] init];
        _textView.font = Font_sys_14;
        _textView.placeholder = @"请输入退款原因";
        _textView.textColor = Color_MainText;
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)textNumLabel
{
    if (!_textNumLabel)
    {
        _textNumLabel = [[UILabel alloc] init];
        _textNumLabel.font = Font_sys_12;
        _textNumLabel.textColor = Color_Text_LightGray;
        _textNumLabel.text = @"余500";
    }
    return _textNumLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
