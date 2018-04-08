//
//  CarCouponCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarCouponCell.h"

@implementation CarCouponCell

- (void)setWeakModel:(ShopCouponModel *)weakModel
{
    _weakModel = weakModel;
    self.backImageView.image = weakModel.enable ? ImageWithName(@"CarCouponEnableBack") : ImageWithName(@"CarCouponUnenableBack");
    self.selBtn.selected = weakModel.select;
    self.selBtn.hidden = !weakModel.enable;
    self.derateLabel.text = MoneyDeal(weakModel.denomination);
    self.nameLabel.text = weakModel.name;
    
    self.limitLabel.text = [NSString stringWithFormat:@"满%@可用", MoneyDeal(weakModel.quota)];
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[weakModel.useStart longLongValue]/1000];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[weakModel.useEnd longLongValue]/1000];
    self.timeLabel.text = [NSString stringWithFormat:@"期限：%@至%@",[startDate dateStrWithFormatStr:@"yyyy-MM-dd"],[endDate dateStrWithFormatStr:@"yyyy-MM-dd"]];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.backgroundColor = Color_Clear;
    self.backgroundColor = Color_Clear;
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
