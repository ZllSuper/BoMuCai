//
//  ShopTypeViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopTypeViewController.h"
#import "PopContainerController.h"

#import "TypeLevelOneRequest.h"
#import "TypeOtherRequest.h"

@interface ShopTypeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic) ShopTypeChooseCallBack chooseCallBack;

@property (nonatomic, strong) NSArray *sourceAry;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, weak) BMCTypeModel *weakModel;

@end

@implementation ShopTypeViewController

- (instancetype)initWithShopType:(ShopType)shopType andLevelModel:(BMCTypeModel *)model andShopChooseCallBack:(ShopTypeChooseCallBack)callBack
{
    if (self = [super init])
    {
        _shopType = shopType;
        _chooseCallBack = callBack;
        if (shopType == ShopTypeLevelTwo)
        {
            self.weakModel = model;
        }
        else if (shopType == ShopTypeLevelThree)
        {
            self.sourceAry = model.mdseTypeDtoList;
        }
        
    }
    return self;
}

- (instancetype)initWithShopType:(ShopType)shopType andShopId:(NSString *)shopId andShopChooseCallBack:(ShopTypeChooseCallBack)callBack
{
    if (self = [super init])
    {
        self.shopId = shopId;
        _shopType = shopType;
        _chooseCallBack = callBack;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.shopType == ShopTypeLevelOne)
    {
        self.title = @"商品分类";
        [self initLeftNavigationItemWithTitle:@"取消" target:self action:@selector(leftCancelBtnAction)];
        
        [self typeLevelOneRequest];
    }
    else if (self.shopType == ShopTypeLevelTwo)
    {
        self.title = @"二级分类";
        [self typeOtherRequest];
    }
    else if (self.shopType == ShopTypeLevelThree)
    {
        self.title = @"三级分类";
        [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(sureBtnAction)];
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
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
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.sourceAry = [BMCTypeModel bxhObjectArrayWithKeyValuesArray:request.response.data];
            [weakSelf.tableView reloadData];
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

- (void)typeOtherRequest
{
    __weak typeof(self) weakSelf = self;
    TypeOtherRequest *item = [[TypeOtherRequest alloc] init];
    item.type = self.weakModel.typeId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.sourceAry = [BMCTypeModel bxhObjectArrayWithKeyValuesArray:request.response.data];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView reloadData];
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

#pragma mark - action
- (void)leftCancelBtnAction
{
    [self.navigationController.containerController dismissAnimate];
}

- (void)sureBtnAction
{
    if(self.weakModel)
    {
        self.chooseCallBack(self.weakModel);
        [self.navigationController.containerController dismissAnimate];
    }
}

#pragma mark =- tableViewDelegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopTypeCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopTypeCell"];
        cell.textLabel.textColor = Color_MainText;
        cell.textLabel.font = Font_sys_14;
        if(self.shopType != ShopTypeLevelThree)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    BMCTypeModel *typeModel = self.sourceAry[indexPath.row];
    cell.textLabel.text = typeModel.name;
    
    if (self.shopType == ShopTypeLevelThree)
    {
        if ([typeModel.typeId isEqualToString:self.weakModel.typeId])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.shopType == ShopTypeLevelThree)
    {
        self.weakModel = self.sourceAry[indexPath.row];
        [tableView reloadData];
       //选中
    }
    else if (self.shopType == ShopTypeLevelTwo)
    {
        ShopTypeViewController *vc = [[ShopTypeViewController alloc] initWithShopType:ShopTypeLevelThree andLevelModel:self.sourceAry[indexPath.row] andShopChooseCallBack:self.chooseCallBack];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (self.shopType ==ShopTypeLevelOne)
    {
        ShopTypeViewController *vc = [[ShopTypeViewController alloc] initWithShopType:ShopTypeLevelTwo andLevelModel:self.sourceAry[indexPath.row] andShopChooseCallBack:self.chooseCallBack];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
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
