//
//  HomeActivityCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "HomeActivityCell.h"

@implementation HomeActivityCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    self.contentView.backgroundColor = Color_Gray_Line;
//    self.backgroundColor = Color_Gray_Line;
    // Initialization code
}

- (IBAction)leftBtnAction:(id)sender
{
    [self.delegate activityCell:self cellItemAction:self.leftModel];
}

- (IBAction)rightBtnAction:(id)sender
{
    [self.delegate activityCell:self cellItemAction:self.rightModel];
}

- (void)setLeftModel:(BMCActivityModel *)leftModel
{
    _leftModel = leftModel;
    [self.leftBtn sd_setBackgroundImageWithURL:[NSURL encodeURLWithString:leftModel.imageApp] forState:UIControlStateNormal placeholderImage:ImagePlaceHolder];
}

- (void)setRightModel:(BMCActivityModel *)rightModel
{
    _rightModel = rightModel;
    self.rightBtn.hidden = (rightModel == nil);
    if (!self.rightBtn.hidden)
    {
        [self.rightBtn sd_setBackgroundImageWithURL:[NSURL encodeURLWithString:rightModel.imageApp] forState:UIControlStateNormal placeholderImage:ImagePlaceHolder];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
