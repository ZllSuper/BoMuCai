//
//  TypeRightCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TypeRightCell.h"

@implementation TypeRightCell

+ (CGFloat)cellHeight
{
   CGFloat imageWidth = (DEF_SCREENWIDTH - DEF_SCREENWIDTH * (16 / 75.0) - 61) / 2;
    
    return imageWidth + 15 + 5 + 20;
}

- (IBAction)rightBtnAction:(id)sender
{
    [self.delegate cell:self itemTouchAction:self.rightModel];
}

- (IBAction)leftBtnAction:(id)sender
{
    [self.delegate cell:self itemTouchAction:self.leftModel];
}

- (void)setLeftModel:(BMCTypeModel *)leftModel
{
    _leftModel = leftModel;
    [self.imageViewOne sd_setImageWithURL:[NSURL encodeURLWithString:leftModel.image] placeholderImage:ImagePlaceHolder];
    self.titleLabelOne.text = leftModel.name;
}

- (void)setRightModel:(BMCTypeModel *)rightModel
{
    _rightModel = rightModel;
    BOOL hidden = rightModel == nil;
    if (!hidden)
    {
        self.imageViewTwo.hidden = NO;
        self.titleLabelTwo.hidden = NO;
        [self.imageViewTwo sd_setImageWithURL:[NSURL encodeURLWithString:rightModel.image] placeholderImage:ImagePlaceHolder];
        self.titleLabelTwo.text = rightModel.name;
    }
    else
    {
        self.imageViewTwo.hidden = YES;
        self.titleLabelTwo.hidden = YES;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imageViewOne.layer.borderColor = Color_Gray_Line.CGColor;
    self.imageViewOne.layer.borderWidth = 1;
    
    self.imageViewTwo.layer.borderColor = Color_Gray_Line.CGColor;
    self.imageViewTwo.layer.borderWidth = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
