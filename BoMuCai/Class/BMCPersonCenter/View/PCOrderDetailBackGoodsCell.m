//
//  PCOrderDetailBackGoodsCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailBackGoodsCell.h"

@implementation PCOrderDetailBackGoodsCell

+ (CGFloat)cellHeight
{
    return 100;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.layer.borderColor = Color_Gray_Line.CGColor;
    self.iconImageView.layer.borderWidth = 1;
    self.backGoodsBtn.layer.borderWidth = 1;
    self.backGoodsBtn.layer.borderColor = Color_Gray_Line.CGColor;
    self.backGoodsBtn.layer.cornerRadius = 2;
    self.backGoodsBtn.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)backGoodsBtnAction:(id)sender
{
    [self.delegate backGoodsActionCell:self];
}
@end
