//
//  BXHCornerRadiusImageView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHCornerRadiusImageView.h"

@implementation BXHCornerRadiusImageView

- (void)setImage:(UIImage *)image
{
    if (image)
    {
       image = [image drawRectWithRoundedCorner:self.cornerRadius size:CGSizeMake(self.cornerRadius * 2, self.cornerRadius * 2)];
        [super setImage:image];
        
    }
    else
    {
        [super setImage:image];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
