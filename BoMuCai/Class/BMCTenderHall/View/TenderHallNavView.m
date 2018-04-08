//
//  TenderHallNavView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallNavView.h"

@implementation TenderHallNavView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.searchTextFiled];
        [self addSubview:self.siftBtn];
        [self addSubview:self.shiftLabel];
        
        [self.siftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.top.mas_equalTo(self).offset(27);
        }];
        
        [self.searchTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.top.mas_equalTo(self).offset(27);
            make.right.mas_equalTo(self.siftBtn.mas_left);
            make.height.mas_equalTo(30);
        }];
        
        [self.shiftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.top.mas_equalTo(self.searchTextFiled.mas_bottom).offset(15);
            make.right.mas_equalTo(self.mas_right);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = Color_Gray_Line;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

#pragma mark - get
- (UITextField *)searchTextFiled
{
    if (!_searchTextFiled)
    {
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        leftView.userInteractionEnabled = NO;
        [leftView setImage:ImageWithName(@"TenderHallSearchIcon") forState:UIControlStateNormal];
        leftView.frame = CGRectMake(0, 0, 40, 40);
        _searchTextFiled = [[UITextField alloc] init];
        _searchTextFiled.font = Font_sys_14;
        _searchTextFiled.textColor = Color_MainText;
        [_searchTextFiled setBackground:ImageWithResizableImage(@"TenderHallSearchBack", UIEdgeInsetsMake(10, 15, 10, 15))];
        _searchTextFiled.placeholder = @"请输入关键字";
        _searchTextFiled.leftView = leftView;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchTextFiled;
}

- (UIButton *)siftBtn
{
    if (!_siftBtn)
    {
        _siftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_siftBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_siftBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _siftBtn.titleLabel.font = Font_sys_14;
    }
    return _siftBtn;
}

- (UILabel *)shiftLabel
{
    if (!_shiftLabel)
    {
        _shiftLabel = [[UILabel alloc] init];
        _shiftLabel.textColor = Color_MainText;
        _shiftLabel.numberOfLines = 0;
        _shiftLabel.text = @"已选择:";
        _shiftLabel.font = Font_sys_14;
    }
    return _shiftLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
