//
//  ActivityListCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ActivityListCell.h"

@implementation ActivityListCell

- (void)setWeakModel:(BMCWaresModel *)weakModel
{
    _weakModel = weakModel;
    [self.imageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.nameLabel.text = weakModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",MoneyDeal(weakModel.unitPrice)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
