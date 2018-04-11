//
//  PCAddressAddViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressAddViewController.h"
#import "BXHAddressViewController.h"

#import "PCAccountLabelCell.h"
#import "PCAddressAddTextFiledCell.h"

#import "PCAddressCreatRequest.h"
#import "PCAddressEditRequest.h"

@interface PCAddressAddViewController () <UITableViewDelegate, UITableViewDataSource,BXHAddressViewControllerDelegate,PCAddressAddTextFiledCellDelegate>

@property (nonatomic, assign) BOOL edit;

@property (nonatomic, copy) AddressAddCompelet compelet;

@property (nonatomic, strong) PCAddressModel *addressModel;

@property (nonatomic, weak) PCAddressModel *wekModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *bottomBtn;

@end

@implementation PCAddressAddViewController

- (void)dealloc
{
    self.addressModel = nil;
}

- (instancetype)initWithCompelet:(AddressAddCompelet)compelet
{
    if (self = [super init])
    {
        self.compelet = compelet;
        self.addressModel = [[PCAddressModel alloc] init];
        self.addressModel.isDefault = @"0";
        self.title = @"新建地址";
        [self.bottomBtn setTitle:@"新建地址" forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithEditAddressModel:(PCAddressModel *)addressModel addressCompelet:(AddressAddCompelet)compelet
{
    if (self = [super init])
    {
        self.compelet = compelet;
        self.wekModel = addressModel;
        self.addressModel = [addressModel copy];
        self.title = @"编辑地址";
        [self.bottomBtn setTitle:@"保存地址" forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addressAddCreat
{
    __weak typeof(self) weakSelf = self;
    PCAddressCreatRequest *request = [[PCAddressCreatRequest alloc] init];
    request.userId = KAccountInfo.userId;
    request.name = self.addressModel.name;
    request.phone = self.addressModel.phone;
    request.province = self.addressModel.provinceId;
    request.city = self.addressModel.cityId;
    request.area = self.addressModel.areaId;
    request.address = self.addressModel.address;
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.addressModel.addressId = request.response.data;
            weakSelf.compelet([weakSelf.addressModel copy]);
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
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

- (void)addressEditRequest
{
    __weak typeof(self) weakSelf = self;
    PCAddressEditRequest *request = [[PCAddressEditRequest alloc] init];
    request.userId = KAccountInfo.userId;
    request.name = self.addressModel.name;
    request.phone = self.addressModel.phone;
    request.province = self.addressModel.provinceId;
    request.city = self.addressModel.cityId;
    request.area = self.addressModel.areaId;
    request.address = self.addressModel.address;
    request.addressId = self.wekModel.addressId;
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
         
            weakSelf.wekModel.isDefault = weakSelf.addressModel.isDefault;
            weakSelf.wekModel.name = weakSelf.addressModel.name;
            weakSelf.wekModel.phone = weakSelf.addressModel.phone;
            weakSelf.wekModel.provinceId = weakSelf.addressModel.provinceId;
            weakSelf.wekModel.province = weakSelf.addressModel.province;
            weakSelf.wekModel.cityId = weakSelf.addressModel.cityId;
            weakSelf.wekModel.city = weakSelf.addressModel.city;
            weakSelf.wekModel.area = weakSelf.addressModel.area;
            weakSelf.wekModel.areaId = weakSelf.addressModel.areaId;
            weakSelf.wekModel.address = weakSelf.addressModel.address;
            weakSelf.compelet(nil);
            [weakSelf.navigationController popViewControllerAnimated:YES];
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

#pragma mark - action
- (void)bottomBtnAction
{
    if (StringIsEmpty(self.addressModel.name))
    {
        ToastShowCenter(@"收货人未填写");
        return;
    }
    
    if (StringIsEmpty(self.addressModel.phone) || ![TSRegularExpressionUtil validateMobile:self.addressModel.phone])
    {
        ToastShowCenter(@"联系电话未填写或联系电话格式错误");
        return;
    }

    if (StringIsEmpty(self.addressModel.province))
    {
        ToastShowCenter(@"所在地区未选择");
        return;
    }

    if (StringIsEmpty(self.addressModel.address))
    {
        ToastShowCenter(@"详细地址未填写");
        return;
    }
    
    if (self.wekModel)
    {
        [self addressEditRequest];
    }
    else
    {
        [self addressAddCreat];
    }
}


- (void)commentTableViewTouchInSide
{
    [self.view endEditing:YES];
}


#pragma mark - celldelegate
- (void)addressTextFiledCellEndEditing:(PCAddressAddTextFiledCell *)cell
{
    [self.addressModel setValue:cell.inputTextFiled.text forKey:cell.propertyName];
}

#pragma mark - addressDelegate
- (void)addressViewController:(BXHAddressViewController *)vc proModel:(BXHProModel *)proModel cityModel:(BXHCityModel *)cityModel areaModel:(BXHAreaModel *)areaModel
{
    self.addressModel.areaId = areaModel.areaId;
    self.addressModel.area = areaModel.areaName;
    self.addressModel.city = cityModel.cityName;
    self.addressModel.cityId = cityModel.cityId;
    self.addressModel.provinceId = proModel.provId;
    self.addressModel.province = proModel.provName;
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        PCAccountLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[PCAccountLabelCell className]];
        cell.titleLabel.text = @"所在地区";
        if (!StringIsEmpty(self.addressModel.province))
        {
            cell.sourceLabel.text = [NSString stringWithFormat:@"%@%@%@",self.addressModel.province,self.addressModel.city,self.addressModel.area];
        }
        return cell;
    }
    else
    {
        PCAddressAddTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:[PCAddressAddTextFiledCell className]];
        cell.delegate = self;
        if (indexPath.row == 0)
        {
            cell.propertyName = @"name";
            cell.titleLabel.text = @"收货人";
            cell.inputTextFiled.text = self.addressModel.name;
        }
        else if (indexPath.row == 1)
        {
            cell.propertyName = @"phone";
            cell.titleLabel.text = @"联系电话";
            cell.inputTextFiled.text = self.addressModel.phone;
            cell.inputTextFiled.keyboardType = UIKeyboardTypePhonePad;
        }
        else
        {
            cell.propertyName = @"address";
            cell.titleLabel.text = @"详细地址";
            cell.inputTextFiled.text = self.addressModel.address;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2)
    {
        BXHAddressViewController *vc = [[BXHAddressViewController alloc] init];
        vc.delegate = self;
        BXHAddressContainerController *container = [[BXHAddressContainerController alloc] initWithRootViewController:vc];
        [container showWithAnimate];
    }
}

#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:[PCAccountLabelCell className] bundle:nil] forCellReuseIdentifier:[PCAccountLabelCell className]];
        [_tableView registerNib:[UINib nibWithNibName:[PCAddressAddTextFiledCell className] bundle:nil] forCellReuseIdentifier:[PCAddressAddTextFiledCell className]];
        UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
        tableViewGesture.numberOfTapsRequired = 1;
        tableViewGesture.cancelsTouchesInView = NO;
        [self.tableView addGestureRecognizer:tableViewGesture];
    }
    return _tableView;
}

- (UIButton *)bottomBtn
{
    if (!_bottomBtn)
    {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_bottomBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = Font_sys_14;
        [_bottomBtn addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
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
