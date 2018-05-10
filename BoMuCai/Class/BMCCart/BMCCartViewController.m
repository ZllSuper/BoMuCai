//
//  BMCCartViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCCartViewController.h"
#import "CarOrderInputViewController.h"
#import "BMCShopViewController.h"
#import "BMCWaresDetailViewController.h"

#import "CarGoodsTableView.h"
#import "CarGoodsBottomView.h"
#import "CarGoodsCell.h"

#import "CartPayModel.h"

@interface BMCCartViewController () <CarGoodsTableViewDelegate>

@property (nonatomic, strong) CarGoodsTableView *tableView;

@property (nonatomic, strong) CarGoodsBottomView *bottomView;

@property (nonatomic, strong) MASConstraint *bottomViewHeight;

@property (nonatomic, strong) CartPayModel *payModel;

@end

@implementation BMCCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"购物车";
    
    UIButton *rightNarButton = [[UIButton alloc] init];
    [rightNarButton setTitle:@"编辑" forState:UIControlStateNormal];
    rightNarButton.titleLabel.font = Font_sys_14;
    [rightNarButton setTitleColor:Color_MainText forState:UIControlStateNormal];
    [rightNarButton addTarget:self action:@selector(rightNavAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightNarButton];

    self.emptyView = [BXHEmptyShowView creatWithSuperView:self.tableView andShowType:BXHEmptyImageAndTitleType];
    self.emptyView.imageView.image = ImageWithName(@"CarEmptyIcon");
    self.emptyView.tipLabel.text = @"购物车内无宝贝";
    
    self.payModel = [[CartPayModel alloc] init];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self.view);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        self.bottomViewHeight = make.height.mas_equalTo(44);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        CarShopModel *shopModel = tableView.soureAry[indexPath.section];
        CarGoodModel *goodsModel = shopModel.cartMdseDto[indexPath.row];
        BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:goodsModel.mdsePropertyId];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.tableView tableViewRefreshCallBack:^(BaseTableView *tableView, BOOL success) {
        if (tableView.soureAry.count <= 0)
        {
            if (weakSelf.emptyView.hidden == YES)
            {
                weakSelf.bottomView.hidden = YES;
                weakSelf.bottomViewHeight.offset = 0;
                [weakSelf.view layoutIfNeeded];
            }
            [weakSelf.emptyView showEmpty];
        }
        else
        {
            if (weakSelf.emptyView.hidden == NO)
            {
                weakSelf.bottomViewHeight.offset = 44;
                weakSelf.bottomView.hidden = NO;
                [weakSelf.view layoutIfNeeded];
            }
            [weakSelf.emptyView hiddenEmpty];
        }
        weakSelf.bottomView.allSelectBtn.selected = NO;
        weakSelf.payModel.payMoney = @"0";
        weakSelf.payModel.buyNum = 0;
        [weakSelf.payModel.shopModels removeAllObjects];
        weakSelf.bottomView.moneyLabel.text = @"￥0.00";
        [weakSelf.bottomView.payBtn setTitle:@"结算(0)"forState:UIControlStateNormal];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.tableView registerAsDodgeViewForMLInputDodger];
    self.tableView.shiftHeightAsDodgeViewForMLInputDodger = 40;
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tableView unregisterAsDodgeViewForMLInputDodger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)goodsChangeStatueWith:(BOOL)select
{
    for (CarShopModel *shopModel in self.tableView.soureAry)
    {
        for (CarGoodModel *model in shopModel.cartMdseDto)
        {
            if ([model.stock integerValue] > 0)
            {
                model.select = select;
            }
        }
    }
    [self.tableView reloadData];
}

- (BOOL)checkAllSelect
{
    for (CarShopModel *shopModel in self.tableView.soureAry)
    {
        for (CarGoodModel *model in shopModel.cartMdseDto)
        {
            if ([model.stock integerValue] != 0 && !model.select)
            {
                return NO;
            }
        }
    }
    return YES;
}

- (void)checkHaveSelect
{
    NSInteger payMoney = 0;
    self.payModel.buyNum = 0;
    [self.payModel.shopModels removeAllObjects];
    for (CarShopModel *shopModel in self.tableView.soureAry)
    {
        CarShopModel *addShopModel = [[CarShopModel alloc] init];
        addShopModel.shopId = shopModel.shopId;
        addShopModel.shopName = shopModel.shopName;
        addShopModel.cartMdseDto = [NSMutableArray array];
        for (CarGoodModel *model in shopModel.cartMdseDto)
        {
            if (model.select && [model.stock integerValue] > 0)
            {
                [addShopModel.cartMdseDto addObject:[CarGoodModel copyWith:model]];

                NSInteger modTotalPrice = ([model.unitPrice integerValue] * [model.amount integerValue]);
                NSInteger modTotalYunFei = ([model.yunfei integerValue] * [model.amount integerValue]);
                
                NSLog(@"商品 单价:%@ ==== 运费:%@ ==== 数量:%@ 总价:%ld ==== 运费:%ld ==== 合计:%ld",model.unitPrice,model.yunfei, model.amount, modTotalPrice, modTotalYunFei, modTotalPrice+modTotalYunFei);
                
                addShopModel.buyNum += [model.amount integerValue];
                // 总运费
                addShopModel.totalYunFei += ([model.yunfei integerValue] * [model.amount integerValue]);
                // 总价格
                addShopModel.totalPrice += ([model.unitPrice integerValue] * [model.amount integerValue]);
                
                self.payModel.buyNum += 1;
            }
        }
        
        NSLog(@"--->店铺 总价:%ld ==== 运费:%ld ====  合计:%ld",addShopModel.totalPrice, addShopModel.totalYunFei, (addShopModel.totalPrice+addShopModel.totalYunFei));
        payMoney += (addShopModel.totalYunFei + addShopModel.totalPrice);

        if (addShopModel.cartMdseDto.count > 0)
        {
            [self.payModel.shopModels addObject:addShopModel];
        }
    }
    NSLog(@"---> 总合计:%ld <---", payMoney);
    self.payModel.payMoney = _StrFormate(@"%ld",payMoney);
}

#pragma mark - action
- (void)rightNavAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CarGoodsCellEidtNotification object:nil];
        [button setTitle:@"完成" forState:UIControlStateNormal];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:CarGoodsCellDoneNotification object:nil];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

- (void)allSelectBtnAction
{
    self.bottomView.allSelectBtn.selected = !self.bottomView.allSelectBtn.selected;
    [self goodsChangeStatueWith:self.bottomView.allSelectBtn.selected];
    [self checkHaveSelect];
    self.bottomView.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(self.payModel.payMoney));
    [self.bottomView.payBtn setTitle:_StrFormate(@"结算(%ld)",self.payModel.buyNum) forState:UIControlStateNormal];
}

- (void)payBtnAction
{
    if ([self.payModel.payMoney floatValue] > 0) {
        CarOrderInputViewController *vc = [[CarOrderInputViewController alloc] initWithPayModel:self.payModel];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        ToastShowCenter(@"您没有选择商品哦");
    }
}

#pragma mark - tableDelegate
- (void)tableViewGoodsSelect:(CarGoodsTableView *)tableView
{
    self.bottomView.allSelectBtn.selected = [self checkAllSelect];
    [self checkHaveSelect];
    self.bottomView.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(self.payModel.payMoney));
    [self.bottomView.payBtn setTitle:_StrFormate(@"结算(%ld)",self.payModel.buyNum) forState:UIControlStateNormal];
}

- (void)tableView:(CarGoodsTableView *)tableView sectionHeaderAction:(CarShopModel *)model
{
    BMCShopModel *shopModel = [[BMCShopModel alloc] init];
    shopModel.shopId = model.shopId;
    BMCShopViewController *vc = [[BMCShopViewController alloc] initWithShopModel:shopModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableViewGoodsNumChange:(CarGoodsTableView *)tableView
{
    [self checkHaveSelect];
    self.bottomView.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(self.payModel.payMoney));
    [self.bottomView.payBtn setTitle:_StrFormate(@"结算(%ld)",self.payModel.buyNum) forState:UIControlStateNormal];
}

#pragma mark - get
- (CarGoodsTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CarGoodsTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.selectDelegate = self;
    }
    
    return _tableView;
}

- (CarGoodsBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[CarGoodsBottomView alloc] init];
        [_bottomView.allSelectBtn addTarget:self action:@selector(allSelectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
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
