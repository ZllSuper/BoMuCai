//
//  BMCTypeViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCTypeViewController.h"
#import "BMCWaresViewController.h"

#import "TypeLeftTableView.h"
#import "TypeRightTableview.h"

#import "TypeLevelOneRequest.h"
#import "TypeOtherRequest.h"


@interface BMCTypeViewController () <TypeRightTableviewDelegate, TypeLeftTableViewProtcol>

@property (nonatomic, strong) TypeLeftTableView *leftView;

@property (nonatomic, strong) TypeRightTableview *rightView;

@end

@implementation BMCTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"分类";
    
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(16 / 75.0);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.leftView.mas_right).offset(8);
        make.right.mas_equalTo(self.view).offset(-8);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self typeLevelOneRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -request
- (void)typeLevelOneRequest
{
    __weak typeof(self) weakSelf = self;
    TypeLevelOneRequest *item = [[TypeLevelOneRequest alloc] init];
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.leftView.sourceAry = [BMCTypeModel bxhObjectArrayWithKeyValuesArray:request.response.data];
            [weakSelf.leftView reloadData];
            [weakSelf.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf typeOtherRequest:[weakSelf.leftView.sourceAry firstObject] first:YES];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

- (void)typeOtherRequest:(BMCTypeModel *)typeOneModel first:(BOOL)first
{
    if (!typeOneModel)
    {
        return;
    }
    __weak typeof(self) weakSelf = self;
    __weak typeof(typeOneModel) weakModel = typeOneModel;
    TypeOtherRequest *item = [[TypeOtherRequest alloc] init];
    item.type = typeOneModel.typeId;
    if (!first)
    {
        ProgressShow(self.view);
    }
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.rightView.headerImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
            weakSelf.rightView.soureAry = [BMCTypeModel bxhObjectArrayWithKeyValuesArray:request.response.data];
            [weakSelf.rightView reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
    ProgressHidden(weakSelf.view);

}

#pragma mark - rightTableViewDelegate
- (void)tableView:(TypeLeftTableView *)tableView selectIndexPath:(NSIndexPath *)indexPath
{
    [self typeOtherRequest:tableView.sourceAry[indexPath.row] first:NO];
}

- (void)tableView:(TypeRightTableview *)tableView itemAction:(BMCTypeModel *)model
{
    if (model)
    {
        BMCWaresViewController *vc = [[BMCWaresViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - get
- (TypeLeftTableView *)leftView
{
    if (!_leftView)
    {
        _leftView = [[TypeLeftTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftView.protcol = self;
    }
    return _leftView;
}

- (TypeRightTableview *)rightView
{
    if (!_rightView)
    {
        _rightView = [[TypeRightTableview alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rightView.actionDelegate = self;
    }
    return _rightView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
