//
//  TenderHallCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallCell.h"

@implementation TenderHallCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageIcon.layer.borderColor = Color_Gray_Line.CGColor;
    self.imageIcon.layer.borderWidth = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeakModel:(TenderHallModel *)weakModel
{
    _weakModel = weakModel;
    
    [self.imageIcon sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.titleLabel.text = weakModel.name;
    self.addressLabel.text = weakModel.areaName;
    self.statueLabel.text = [weakModel switchTenderStatue];
    self.timeLabel.text = [NSDate stringFormTime:[weakModel.beginDate longLongValue] / 1000 withFormate:@"yyyy-MM-dd"];
}

@end
