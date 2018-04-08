//
//  TypeLeftTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TypeLeftTableView.h"

@implementation TypeLeftTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = Color_Clear;
        
        self.tableFooterView = [UIView new];
        
        [self registerClass:[TypeLeftViewCell class] forCellReuseIdentifier:[TypeLeftViewCell className]];
        
        self.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TypeLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TypeLeftViewCell className]];
    
    BMCTypeModel *model = self.sourceAry[indexPath.row];
    cell.titleLabel.text = model.name;
//    [cell setSelected:NO animated:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.protcol tableView:self selectIndexPath:indexPath];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
