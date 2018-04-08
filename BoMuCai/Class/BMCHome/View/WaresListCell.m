//
//  WaresListCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresListCell.h"

@implementation WaresListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.headerImageView.layer.borderColor = Color_Gray_Line.CGColor;
    self.headerImageView.layer.borderWidth = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeakModel:(BMCWaresModel *)weakModel
{
    _weakModel = weakModel;
    [self.headerImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.titleLabel.text = weakModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(weakModel.unitPrice)];
    self.shopNameLabel.text = weakModel.shopName;
    self.commentLabel.text = [NSString stringWithFormat:@"%@条评论",weakModel.assessNum];
}

@end
