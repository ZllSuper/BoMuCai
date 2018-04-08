//
//  UITableViewCell+Extend.m
//  Category
//
//  Created by Evan.Cheng on 15/12/26.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "UITableViewCell+Extend.h"
#import "UIView+BXHMyView.h"

@implementation UITableViewCell (Extend)



+ (instancetype)ct_cellWithTableViewFromXIB:(UITableView *)tableView indentifier:(NSString *)indentifier
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if(cell == nil){
        cell = [self viewFromXIB];
    }
    return cell;
}

+ (instancetype)ct_cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style indentifier:(NSString *)indentifier
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:indentifier];
    }
    return cell;
}

+ (instancetype)ct_cellDefaultWithTableView:(UITableView *)tableView indentifier:(NSString *)indentifier
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}
@end
