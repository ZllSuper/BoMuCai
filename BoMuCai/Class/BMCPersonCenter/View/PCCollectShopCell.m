//
//  PCCollectShopCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCollectShopCell.h"

@implementation PCCollectShopCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.shopIconImageView.layer.cornerRadius = 30;
    self.shopIconImageView.layer.masksToBounds = YES;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Initialization code
}

- (void)setWeakModel:(BMCShopModel *)weakModel
{
    _weakModel = weakModel;
    [self.shopIconImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.nameLabel.text = weakModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
