//
//  ShopListCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopListCell.h"

@implementation ShopListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.headerIconImageView.layer.cornerRadius = 30;
    self.headerIconImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setShopModel:(BMCShopModel *)shopModel
{
    _shopModel = shopModel;
    [self.headerIconImageView sd_setImageWithURL:[NSURL encodeURLWithString:shopModel.image] placeholderImage:ImagePlaceHolder];
    self.nameLabel.text = shopModel.name;
    self.levelLabel.text = shopModel.shopLevel;
    self.authImageView.hidden = ![shopModel.auditingStatus isEqualToString:@"00100002"];
    self.heartCountLabel.text = shopModel.careNum;
}

@end
