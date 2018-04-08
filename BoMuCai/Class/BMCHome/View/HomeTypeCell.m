//
//  HomeTypeCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "HomeTypeCell.h"

@implementation HomeTypeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.oneTypeLabel.adjustsFontSizeToFitWidth = YES;
    self.twoTypeLabel.adjustsFontSizeToFitWidth = YES;
    self.threeTypeLabel.adjustsFontSizeToFitWidth = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.moreBtn.titleLabel.numberOfLines = 2;
    [self.moreBtn setTitle:@"更\n多" forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)typeBtnTouchAction:(UIButton *)sender
{
    if (self.delegate)
    {
        [self.delegate typeCellBtnAction:self actionAtIndex:sender.tag - 1];
    }
}

- (void)setTypeAry:(NSArray *)typeAry
{
    _typeAry = typeAry;
    for (int i = 0; i < typeAry.count; i ++)
    {
        BMCTypeModel *typeModel = typeAry[i];
        if (i == 0)
        {
            self.oneTypeLabel.text = typeModel.name;
            [self.oneTypeImage sd_setImageWithURL:[NSURL encodeURLWithString:typeModel.image] placeholderImage:ImagePlaceHolder];
        }
        else if (i == 1)
        {
            self.twoTypeLabel.text = typeModel.name;
            [self.twoTypeImage sd_setImageWithURL:[NSURL encodeURLWithString:typeModel.image] placeholderImage:ImagePlaceHolder];
        }
        else if (i == 2)
        {
            self.threeTypeLabel.text = typeModel.name;
            [self.threeTypeImage sd_setImageWithURL:[NSURL encodeURLWithString:typeModel.image] placeholderImage:ImagePlaceHolder];
        }
    }
}

@end
