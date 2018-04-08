//
//  WaresTypeBuyCountCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresTypeBuyCountCell.h"

@implementation WaresTypeBuyCountCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (CGSize)sizeWithCell
{
    return CGSizeMake(104, 30);
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = Color_White;
        self.backgroundColor = Color_White;
        
        [self.contentView addSubview:self.buyView];
        [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.top.and.bottom.mas_equalTo(self);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFileTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textFileTextDidChange
{
    [self.delegate buyCountCell:self buyCountText:self.buyView.countTextFiled.text];
}

#pragma mark - get
- (BuyCountView *)buyView
{
    if (!_buyView)
    {
        _buyView = [[BuyCountView alloc] init];
    }
    return _buyView;
}

@end
