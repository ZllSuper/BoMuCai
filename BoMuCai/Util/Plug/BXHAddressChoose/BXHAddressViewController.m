//
//  BXHAddressViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHAddressViewController.h"
#import "BXHAddressToolBar.h"
#import "BXHAreaDBManager.h"

@interface BXHAddressViewController () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) BXHAddressToolBar *toolBar;

@property (nonatomic, strong) UIPickerView *addressPickView;

@property (nonatomic, strong) NSArray *proAry;

@property (nonatomic, strong) NSArray *cityAry;

@property (nonatomic, strong) NSArray *areaAry;

@property (nonatomic, weak) BXHAreaModel *selAreaModel;

@property (nonatomic, weak) BXHProModel *selProModel;

@property (nonatomic, weak) BXHCityModel *selCityModel;

@end

@implementation BXHAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray_bg;
    
    self.proAry = [[BXHAreaDBManager defaultManeger] getProList];
    
    self.selProModel = self.proAry[0];
    self.cityAry = [[BXHAreaDBManager defaultManeger] getCityListWithProId:self.selProModel.provId];
    self.selCityModel = self.cityAry[0];
    self.areaAry = [[BXHAreaDBManager defaultManeger] getAreaListWithCityId:self.selCityModel.cityId];
    self.selAreaModel = self.areaAry[0];
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.addressPickView];
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.addressPickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toolBar.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)cancelBtnAction
{
    [self.containerController hiddenWithAnimte];
}

- (void)confirmBtnAction
{
    [self.delegate addressViewController:self proModel:self.selProModel cityModel:self.selCityModel areaModel:self.selAreaModel];
    [self.containerController hiddenWithAnimte];
}

#pragma mark - pickerDelegate dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.proAry.count;
    }
    else if (component == 1)
    {
        return self.cityAry.count;
    }
    else
    {
        return self.areaAry.count;
    }
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = Font_sys_14;
    label.adjustsFontSizeToFitWidth = YES;
    if (component == 0)
    {
        BXHProModel *model = self.proAry[row];
        label.text = model.provName;
    }
    else if (component == 1)
    {
        BXHCityModel *model = self.cityAry[row];
        label.text = model.cityName;
    }
    else
    {
        BXHAreaModel *model = self.areaAry[row];
        label.text = model.areaName;
    }
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return DEF_SCREENWIDTH / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self calculateAddress:component row:row];//实时更新数据
}

- (void)calculateAddress:(NSInteger)component row:(NSInteger)row
{
    if (component == 0)
    {
        self.selProModel = self.proAry[row];
        self.cityAry = [[BXHAreaDBManager defaultManeger] getCityListWithProId:self.selProModel.provId];
        self.selCityModel = self.cityAry[0];
        self.areaAry = [[BXHAreaDBManager defaultManeger] getAreaListWithCityId:self.selCityModel.cityId];
        self.selAreaModel = self.areaAry[0];
        
        [self.addressPickView reloadComponent:1];
        [self.addressPickView selectRow:0 inComponent:1 animated:YES];
        [self.addressPickView reloadComponent:2];
        [self.addressPickView selectRow:0 inComponent:2 animated:YES];
        
    }
    else if (component == 1)
    {
        self.selCityModel = self.cityAry[row];
        self.areaAry = [[BXHAreaDBManager defaultManeger] getAreaListWithCityId:self.selCityModel.cityId];
        self.selAreaModel = self.areaAry[0];

        [self.addressPickView reloadComponent:2];
        [self.addressPickView selectRow:0 inComponent:2 animated:YES];
    }
    else
    {
        self.selAreaModel = self.areaAry[row];
    }
}


#pragma mark - get
- (BXHAddressToolBar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[BXHAddressToolBar alloc] init];
        [_toolBar.leftBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar.rightBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolBar;
}

- (UIPickerView *)addressPickView
{
    if (!_addressPickView)
    {
        _addressPickView = [[UIPickerView alloc] init];
        _addressPickView.dataSource = self;
        _addressPickView.delegate = self;
    }
    return _addressPickView;
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
