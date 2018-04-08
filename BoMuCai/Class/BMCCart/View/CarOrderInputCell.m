//
//  CarOrderInputCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarOrderInputCell.h"

@implementation CarOrderInputCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconImageView.layer.borderColor = Color_Gray_Line.CGColor;
    self.iconImageView.layer.borderWidth = 1;
    // Initialization code
}

- (void)setWeakModel:(CarGoodModel *)weakModel
{
    _weakModel = weakModel;
    self.nameLabel.text = weakModel.mdseName;
    [self.iconImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(weakModel.unitPrice));
    self.numLabel.text = _StrFormate(@"编号：%@",weakModel.mdsePropertyId);
    self.sizeLabel.text = _StrFormate(@"型号：%@",[weakModel typeDtoToStr]);
//    self.sizeLabel.hidden = [weakModel.stock integerValue] > 0;
    self.countLabel.text = weakModel.amount;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
