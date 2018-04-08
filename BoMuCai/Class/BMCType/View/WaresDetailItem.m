//
//  WaresDetailItem.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailItem.h"

@implementation WaresDetailItem

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = Color_White;
}

- (void)setWeakModel:(BMCWaresRecommendModel *)weakModel
{
    _weakModel = weakModel;
    [self.waresIconImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.waresNameLabel.text = weakModel.name;
    
    self.priceLabel.text = _StrFormate(@"￥%@", MoneyDeal(weakModel.price));
    self.commentCountLabel.text = _StrFormate(@"%@条评论",weakModel.assessCount);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
