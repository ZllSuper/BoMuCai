//
//  HomeTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "HomeTableView.h"

static NSString *spaceCellID = @"HomeTableViewSpaceCell";

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
        [self creatFooter];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    self.refreshCallBack(self, refresh);
}

#pragma mark - activityItemDelegate
- (void)activityCell:(HomeActivityCell *)cell cellItemAction:(BMCActivityModel *)model
{
    [self.actionDelegate tableView:self activityAction:cell itemModel:model];
}

#pragma mark - typeCellDelegate
- (void)typeCellBtnAction:(HomeTypeCell *)typeCell actionAtIndex:(NSInteger)index
{
    [self.actionDelegate tableView:self typeCellAction:index];
}

#pragma mark - adViewDelegate
- (void)adView:(DTAdView *)adView didSelectAdAtNum:(NSInteger)num
{
    if ([self.topAdCell.adView isEqual:adView])
    {
        [self.actionDelegate tableView:self topAdCellActionIndex:num];
//        BXHLog(@"Top选择了%ld",num);
    }
    else
    {
        [self.actionDelegate tableView:self midAdCellActionIndex:num];
//        BXHLog(@"Mid选择了%ld",num);
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4 * 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    float sec = section / 2.0;
    
    if (sec == 0) {
        return 1;
    }
    else if (sec == 1) {
        return 1;
    }
    else if (sec == 2) {
        return 1;
    }
    else if (sec == 3)
    {
        NSInteger count = self.soureAry.count / 2;
        if((self.soureAry.count % 2) != 0)
        {
            count ++;
        }
        return count;
    }
    else {
        return 1;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
////    if (section == 0)
////    {
////        return 0.1;
////    }
////    else
////    {
////        return 8;
////    }
//
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
////    return 0.1;
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float sec = indexPath.section / 2.0;

    if (sec == 0)
    {
        return DEF_SCREENWIDTH * (36 / 75.0);
    }
    else if (sec == 1)
    {
        return DEF_SCREENWIDTH * (12 / 75.0);
    }
    else if (sec == 2)
    {
        return (DEF_SCREENWIDTH - 87) / 3 + 60;
    }
    else if (sec == 3)
    {
        return 108;
    }
    else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float sec = indexPath.section / 2.0;
    NSInteger row = indexPath.row;

    if (sec == 0) {
        return self.topAdCell;
    }
    else if (sec == 1) {
        return self.midAdCell;
    }
    else if (sec == 2) {
        return self.typeCell;
    }
    else if (sec == 3) {
        HomeActivityCell *cell = [HomeActivityCell ct_cellWithTableViewFromXIB:tableView indentifier:[HomeActivityCell className]];
        cell.delegate = self;
        
        NSInteger letfIndex = indexPath.row * 2;
        NSInteger rightIndex = letfIndex + 1;
        
        cell.leftModel = self.soureAry[letfIndex];
        if (rightIndex >= self.soureAry.count)
        {
            cell.rightModel = nil;
        }
        else
        {
            cell.rightModel = self.soureAry[rightIndex];
        }
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:spaceCellID];
        cell.contentView.backgroundColor = Color_Gray_bg;
        return cell;
    }
}

#pragma mark - get
- (HomeTopAdCell *)topAdCell
{
    if (!_topAdCell)
    {
        _topAdCell = [[HomeTopAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HomeTopAdCell className]];
        _topAdCell.adView.delegate = self;
    }
    return _topAdCell;
}

- (HomeMidAdCell *)midAdCell
{
    if (!_midAdCell)
    {
        _midAdCell = [[HomeMidAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HomeMidAdCell className]];
        _midAdCell.adView.delegate = self;
    }
    return _midAdCell;
}

- (HomeTypeCell *)typeCell
{
    if (!_typeCell)
    {
        _typeCell = [HomeTypeCell viewFromXIB];
        _typeCell.delegate = self;
    }
    return _typeCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
