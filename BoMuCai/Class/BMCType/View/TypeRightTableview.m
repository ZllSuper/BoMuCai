//
//  TypeRightTableview.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TypeRightTableview.h"

@implementation TypeRightTableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.showsVerticalScrollIndicator = NO;
        
        self.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
        
        [self registerNib:[UINib nibWithNibName:[TypeRightCell className] bundle:nil] forCellReuseIdentifier:[TypeRightCell className]];
        [self registerClass:[TypeRightSectionHeaderView class] forHeaderFooterViewReuseIdentifier:[TypeRightSectionHeaderView className]];
        self.tableHeaderView = self.headerImageView;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BMCTypeModel *sectionModel = self.soureAry[section];
    NSArray *rowAry = sectionModel.mdseTypeDtoList;
    NSInteger count = rowAry.count / 2;
    if((rowAry.count % 2) != 0)
    {
        count ++;
    }
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TypeRightSectionHeaderView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[TypeRightSectionHeaderView className]];
    BMCTypeModel *model = self.soureAry[section];
    sectionView.titleLabel.text = model.name;
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TypeRightCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMCTypeModel *sectionModel = self.soureAry[indexPath.section];
    NSArray *rowAry = sectionModel.mdseTypeDtoList;
    TypeRightCell *cell = [tableView dequeueReusableCellWithIdentifier:[TypeRightCell className]];
    cell.delegate = self;
    
    NSInteger letfIndex = indexPath.row * 2;
    NSInteger rightIndex = letfIndex + 1;
    
    cell.leftModel = rowAry[letfIndex];
    if (rightIndex >= rowAry.count)
    {
        cell.rightModel = nil;
    }
    else
    {
        cell.rightModel = rowAry[rightIndex];
    }

    return cell;
}

#pragma mark - cellDelegate
- (void)cell:(TypeRightCell *)cell itemTouchAction:(BMCTypeModel *)model
{
    [self.actionDelegate tableView:self itemAction:model];
}

#pragma mark - get
- (UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        CGFloat width = DEF_SCREENWIDTH - DEF_SCREENWIDTH * (16/75.0) - 16;
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width * (24 / 53.0))];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.image = ImagePlaceHolder;
    }
    return _headerImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
