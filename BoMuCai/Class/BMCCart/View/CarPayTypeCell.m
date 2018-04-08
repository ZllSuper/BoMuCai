//
//  CarPayTypeCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarPayTypeCell.h"

@implementation CarPayTypeCell

- (void)setWeakModel:(CarPayTypeModel *)weakModel
{
    _weakModel = weakModel;
    self.iconImageView.image = ImageWithName(weakModel.imageIcon);
    self.titleLabel.text = weakModel.title;
    self.selectImageView.image = [weakModel.select boolValue] ? ImageWithName(@"CarGoodSel") : ImageWithName(@"CarGoodUnSel");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
