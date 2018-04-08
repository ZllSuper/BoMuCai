//
//  PCAccountInfoTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAccountInfoTableView.h"

@implementation PCAccountInfoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
        
        [self registerNib:[UINib nibWithNibName:[PCAccountLabelCell className] bundle:nil] forCellReuseIdentifier:[PCAccountLabelCell className]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PCAccountInfoList" ofType:@"plist"];
        self.soureAry = [NSArray arrayWithContentsOfFile:path];
        
        self.accountModel = [[PCAccountModel alloc] init];
        
    }
    return self;
}

#pragma mark - request
- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    PCAccountInfoRequest *request = [[PCAccountInfoRequest alloc] init];
    request.userId = KAccountInfo.userId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.accountModel bxhObjectWithKeyValues:request.response.data];
            [weakSelf.imageCell.headerImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakSelf.accountModel.photo] placeholderImage:ImagePlaceHolder];
            KAccountInfo.nickName = weakSelf.accountModel.nickName;
            KAccountInfo.email = weakSelf.accountModel.email;
            KAccountInfo.companyName = weakSelf.accountModel.companyName;
            KAccountInfo.sex = weakSelf.accountModel.sex;
            KAccountInfo.address = weakSelf.accountModel.address;
            KAccountInfo.qq = weakSelf.accountModel.qq;
            KAccountInfo.phone = weakSelf.accountModel.phone;
            KAccountInfo.photo = weakSelf.accountModel.photo;
            [KAccountInfo saveToDisk];
            [weakSelf reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionAry = self.soureAry[section];
    return sectionAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionAry = self.soureAry[indexPath.section];
    NSDictionary *rowDict = sectionAry[indexPath.row];
    return [rowDict[@"height"] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionAry = self.soureAry[indexPath.section];
    NSDictionary *rowDict = sectionAry[indexPath.row];
    
    if([rowDict[@"type"] isEqualToString:@"1"])
    {
        return self.imageCell;
    }
    else
    {
       PCAccountLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[PCAccountLabelCell className]];
        cell.titleLabel.text = rowDict[@"title"];
        cell.sourceLabel.textColor = Color_Text_Gray;
        if (indexPath.section == 0)
        {
            switch (indexPath.row)
            {
                case 1:
                {
                    cell.sourceLabel.text = self.accountModel.nickName;
                }
                    break;
                case 2:
                {
                    cell.sourceLabel.text = self.accountModel.email;
                }

                    break;
                case 3:
                {
                    cell.sourceLabel.text = self.accountModel.companyName;
                }

                    break;
                case 4:
                {
                    cell.sourceLabel.text = [self.accountModel sexToHanZi];
                }
                    
                    break;
                case 5:
                {
                    cell.sourceLabel.text = self.accountModel.address;
                }

                    break;
                case 6:
                {
                    cell.sourceLabel.text = self.accountModel.qq;
                }

                    break;
                default:
                {
                    cell.sourceLabel.textColor = Color_Main_Dark;
                    cell.sourceLabel.text = @"修改";
                }
                    break;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                cell.sourceLabel.text = self.accountModel.phone;
            }
            else
            {
                cell.sourceLabel.textColor = Color_Main_Dark;
                cell.sourceLabel.text = @"修改";
            }
        }
        
        return cell;
    }
}

#pragma mark - get
- (PCAccountImageCell *)imageCell
{
    if (!_imageCell)
    {
        _imageCell = [PCAccountImageCell viewFromXIB];
    }
    return _imageCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
