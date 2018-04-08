//
//  UITableView+BXHMyTableView.m
//  ECar
//
//  Created by 步晓虎 on 14-12-22.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "UITableView+BXHMyTableView.h"

@implementation UITableView (BXHMyTableView)

- (void)rsetBackGroundViewWithColor:(UIColor *)color
{
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = color;
    self.backgroundView = backGroundView;
}

@end
