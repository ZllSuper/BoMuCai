//
//  WaresDetailTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailTableView.h"

@interface WaresDetailTableView ()

@property (nonatomic, assign) CGFloat webContentHeight;

@property (nonatomic, assign) SectionActionType actionType;

@end

@implementation WaresDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.webContentHeight = 0;
        self.actionType = SectionDetailActionType;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self creatHeader];
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    WaresDetailRequest *request = [[WaresDetailRequest alloc] init];
    request.userId = StringIsEmpty(KAccountInfo.userId) ? @"" : KAccountInfo.userId;
    request.waresId = self.detailId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.detailModel = [BMCWaresDetailModel bxhObjectWithKeyValues:request.response.data];
            
            NSMutableArray *imageAry = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in weakSelf.detailModel.mdseImageDto)
            {
                [imageAry addObject:dict[@"url"]];
            }
            weakSelf.adCell.adView.adDataArray = imageAry;
            [weakSelf.adCell.adView loadAdDataThenStart];
            
            NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\""
            " content=\"width=device-width, initial-scale=1.0\">"
            "<style type=\"text/css\">body { font-family: Arial,\"microsoft yahei\","
            "Verdana; word-wrap:break-word; padding:0; margin:0; font-size:14px; "
            "color:#000; background: #fff; "
            "overflow-x:hidden; }img {padding:0; margin:0; vertical-align:top; border: "
            "none}li,ul {list-style: none outside none; padding: 0; margin: "
            "0}input[type=text],select {-webkit-appearance:none; -moz-appearance: none; "
            "margin:0; padding:0; background:none; border:none; font-size:14px; "
            "text-indent:3px; font-family: Arial,\"microsoft yahei\",Verdana;}.wrapper { "
            "width:100%%; padding-right:10px;padding-top:10px;padding-bottom:10px;"
            "padding-left:10px; box-sizing:border-box;}p { color:#666; line-height:1.0em;}"
            ".wrapper img { display:block; max-width:100%%; height:auto !important; "
            "margin-bottom:10px;} p {margin:0; margin-bottom:1px;}</style></head><body><div "
            "class=\"wrapper\">"
            "%@"
            "</div></body></html>", weakSelf.detailModel.remark];
            
            [weakSelf reloadData];
            
            weakSelf.refreshCallBack(weakSelf,YES);
            [weakSelf.webCell.webView loadHTMLString:html baseURL:nil];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.webCell.webView setNeedsLayout];
            });
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
    }];

//    self.adCell.adView.adDataArray = @[@"http://xxxxxx",@"http://xxxxxx",@"http://xxxxxx",@"http://xxxxxx"];
//    [self.adCell.adView loadAdDataThenStart];
//    
//    [self.webCell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL encodeURLWithString:@"https://www.baidu.com"]]];
//    
//    [self endRefresh];
}

#pragma mark - cellDelegate
- (void)webCell:(WaresDetailWebCell *)cell contentSizeChange:(CGFloat)contentSize
{
    self.webContentHeight = contentSize;
    NSIndexPath *indexPath = [self indexPathForCell:self.webCell];
    if (self.actionType == SectionDetailActionType && indexPath)
    {
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

//- (void)sectionView:(WaresSectionHeaderView *)sectionView actionType:(SectionActionType)actionType
//{
//    self.actionType = actionType;
//    [self reloadData];
//}

- (BOOL)sectionView:(WaresSectionHeaderView *)sectionView actionType:(SectionActionType)actionType
{
    if (actionType == SectionDetailActionType) {
        self.actionType = actionType;
        [self reloadData];
        return YES;
    }
    else if (actionType == SectionCommentActionType) {
        if (self.detailModel.assessDto.count>0) {
            self.actionType = actionType;
            [self reloadData];
            return YES;
        }
        else {
            ToastShowCenter(@"暂无评价");
            return NO;
        }
    }
    
    return YES;
}

#pragma mark tableDelegate / dataSOurce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.detailModel)
    {
        return 5;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            if (self.actionType == SectionDetailActionType)
            {
                return 1;
            }
            else
            {
                return self.detailModel.assessDto.count;
            }
        }
            break;
   
        default:
        {
            NSInteger line = self.detailModel.mdseTuijianDtos.count / 2 + self.detailModel.mdseTuijianDtos.count % 2;
            return line;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 0.1;
        }
            break;
        case 1:
        {
            return 8;
        }
            break;
        case 2:
        {
            return 8;
        }
            break;
        case 3:
        {
            return [WaresSectionHeaderView showHeight];
        }
            break;
            
        default:
        {
            return [WaresCommendSectionHeader showHeight];
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 0.1;
        }
            break;
        case 1:
        {
            return 0.1;
        }
            break;
        case 2:
        {
            return 8;
        }
            break;
        case 3:
        {
            if (self.actionType == SectionDetailActionType || [self.detailModel.assessCount integerValue] <= 3)
            {
                return 0.1;
            }
            else
            {
                return [WaresCommentFooterView showHeight];
            }
        }
            break;
            
        default:
        {
            return 0.1;
        }
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0)
            {
                return [WaresDetailAdCell showHeight];
            }
            else
            {
                return [WaresInfoCell showHeight];
            }
        }
            break;
        case 1:
        {
            return [WaresShopCell showHeight];
        }
            break;
        case 2:
        {
            return [WaresTypeCell showHeight];
        }
            break;
        case 3:
        {
            if (self.actionType == SectionDetailActionType)
            {
                return self.webContentHeight;
            }
            else
            {
                BMCWaresCommentModel *model = self.detailModel.assessDto[indexPath.row];
                return [WaresCommentCell showHeight:model.introduce];
            }
        }
            break;
            
        default:
        {
            return [WaresDetailItemCell showHeight];
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return nil;
        }
            break;
        case 1:
        {
            return nil;
        }
            break;
        case 2:
        {
            return nil;
        }
            break;
        case 3:
        {
            return self.selSectionHeader;
        }
            break;
            
        default:
        {
            return self.commendHeaderView;
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3 && self.actionType == SectionCommentActionType && [self.detailModel.assessCount integerValue] > 3)
    {
        return self.moreFooterView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0)
            {
                return self.adCell;
            }
            else
            {
                self.infoCell.nameLabel.text = self.detailModel.mdseName;
                self.infoCell.numLabel.text = _StrFormate(@"编号：%@",self.detailModel.mdseId);
                self.infoCell.priceLabel.text = _StrFormate(@"￥%@",MoneyDeal(self.detailModel.price));
                self.infoCell.stockLabel.text = _StrFormate(@"库存：%@",self.detailModel.repertory);
                self.infoCell.freightLabel.text = _StrFormate(@"运费：%@",MoneyDeal(self.detailModel.yunfei));
                return self.infoCell;
            }
        }
            break;
        case 1:
        {
            [self.shopCell.shopIconImageView sd_setImageWithURL:[NSURL encodeURLWithString:self.detailModel.shopLogo] placeholderImage:ImagePlaceHolder];
            self.shopCell.shopNameLabel.text = self.detailModel.shopName;
            return self.shopCell;
        }
            break;
        case 2:
        {
            if ([self.detailModel.morenfenlei rangeOfString:EMPTY_SEL].location == NSNotFound)
             {
                 NSString *selTypeStr = @"";
                 NSArray *typeIds = [self.detailModel.morenfenlei componentsSeparatedByString:@","];
                 for (NSString *typeId in typeIds)
                 {
                     NSInteger index = [typeIds indexOfObject:typeId];
                     WaresTypeSectionModel * typeModel = self.detailModel.mdseTypePropertyDtos[index];
                     selTypeStr = _StrFormate(@"%@ %@",selTypeStr,typeModel.name);
                     for (WaresTypeModel * subModel in typeModel.models)
                     {
                         if ([typeId isEqualToString:subModel.typeId])
                         {
                             subModel.statue = WaresTypeSelect;
                             selTypeStr = _StrFormate(@"%@-%@",selTypeStr,subModel.name);
                         }
                     }
                 }
                 self.typeChooseCell.rightLabel.text = selTypeStr;
            }
            else
            {
                self.typeChooseCell.rightLabel.text = @"";
            }
           
            return self.typeChooseCell;
        }
            break;
        case 3:
        {
            if (self.actionType == SectionDetailActionType)
            {
//                [self.webCell setNeedsLayout];
                return self.webCell;
            }
            else
            {
                WaresCommentCell *cell = [WaresCommentCell ct_cellWithTableViewFromXIB:tableView indentifier:[WaresCommentCell className]];
                cell.weakModel = self.detailModel.assessDto[indexPath.row];
                return cell;
            }
        }
            break;
            
        default:
        {
            WaresDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[WaresDetailItemCell className]];
            if (!cell)
            {
                cell = [[WaresDetailItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WaresDetailItemCell className]];
                cell.delegate = self;
            }
            NSInteger leftIndex = indexPath.row * 2;
            NSInteger rightIndex = leftIndex + 1;
            
            cell.rightItem.hidden = YES;
            cell.leftItem.weakModel = self.detailModel.mdseTuijianDtos[leftIndex];
            cell.leftItem.shopNameLabel.text = self.detailModel.shopName;
            if (rightIndex < self.detailModel.mdseTuijianDtos.count)
            {
                cell.rightItem.hidden = NO;
                cell.rightItem.weakModel = self.detailModel.mdseTuijianDtos[rightIndex];
                cell.rightItem.shopNameLabel.text = self.detailModel.shopName;
            }
            return cell;
        }
            break;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate;

{
//    if([UIDevice currentDevice].systemVersion.floatValue>=10)
//    {
//        [self.webCell.webView setNeedsLayout];
//    }
}

#pragma mark -cellDelegate
- (void)itemCell:(WaresDetailItemCell *)cell actionItem:(WaresDetailItem *)item
{
    [self.protcol tableView:self itemAction:item];
}

- (void)adView:(DTAdView *)adView didSelectAdAtNum:(NSInteger)num
{
    [self.protcol tableView:self AdViewActionIndex:num];
}

#pragma mark - get
- (WaresDetailAdCell *)adCell
{
    if (!_adCell)
    {
        _adCell = [[WaresDetailAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WaresDetailAdCell className]];
        _adCell.adView.size = CGSizeMake(DEF_SCREENWIDTH, [WaresDetailAdCell showHeight]);
        _adCell.adView.delegate = self;
    }
    return _adCell;
}

- (WaresInfoCell *)infoCell
{
    if (!_infoCell)
    {
        _infoCell = [WaresInfoCell viewFromXIB];
    }
    return _infoCell;
}

- (WaresShopCell *)shopCell
{
    if (!_shopCell)
    {
        _shopCell = [[WaresShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WaresShopCell className]];
    }
    return _shopCell;
}

- (WaresTypeCell *)typeChooseCell
{
    if (!_typeChooseCell)
    {
        _typeChooseCell = [[WaresTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WaresTypeCell className]];
    }
    return _typeChooseCell;
}

- (WaresSectionHeaderView *)selSectionHeader
{
    if (!_selSectionHeader)
    {
        _selSectionHeader = [[WaresSectionHeaderView alloc] init];
        _selSectionHeader.delegate = self;
    }
    return _selSectionHeader;
}

- (WaresDetailWebCell *)webCell
{
    if (!_webCell)
    {
        _webCell = [[WaresDetailWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WaresDetailWebCell className]];
        _webCell.delegate = self;
    }
    return _webCell;
}

- (WaresCommentFooterView *)moreFooterView
{
    if (!_moreFooterView)
    {
        _moreFooterView = [[WaresCommentFooterView alloc] init];
    }
    return _moreFooterView;
}

- (WaresCommendSectionHeader *)commendHeaderView
{
    if (!_commendHeaderView)
    {
        _commendHeaderView = [[WaresCommendSectionHeader alloc] init];
    }
    return _commendHeaderView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
