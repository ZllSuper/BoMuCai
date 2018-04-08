//
//  PCAccountRowSelViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAccountRowSelViewController.h"
#import "PCAccountSelModel.h"

#import "PCEditUserInfoRequest.h"

@interface PCAccountRowSelViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *propertyName;

@property (nonatomic, weak) PCAccountModel *weakModel;

@property (nonatomic, strong) NSArray *sourceAry;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PCAccountRowSelViewController

- (instancetype)initWithTitle:(NSString *)title accountModel:(PCAccountModel *)model propertyName:(NSString *)properTyName andSelectSourceAry:(NSArray *)sourceAry
{
    if (self = [super init])
    {
        self.title = title;
        self.weakModel = model;
        self.propertyName = properTyName;
        self.sourceAry = [PCAccountSelModel bxhObjectArrayWithKeyValuesArray:sourceAry];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *selId = [self.weakModel valueForKey:self.propertyName];
    if (!StringIsEmpty(selId))
    {
        for (PCAccountSelModel *model in self.sourceAry)
        {
            model.sel = [model.sourceId isEqualToString:selId];
        }
    }
    
    [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(rightBtnAction)];
    
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

#pragma mark - request
- (void)updateUserInfoRequest:(NSString *)selId
{
    __weak typeof(self) weakSelf = self;
    __block typeof(selId) blSelId = selId;
    PCEditUserInfoRequest *infoRequest = [[PCEditUserInfoRequest alloc] init];
    infoRequest.userId = KAccountInfo.userId;
    [infoRequest setValue:selId forKey:self.propertyName];
    ProgressShow(self.view);
    [infoRequest requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            [weakSelf.weakModel setValue:selId forKey:self.propertyName];
            [weakSelf.delegate accountInfoEditSuccess:self];
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
- (void)rightBtnAction
{
    PCAccountSelModel *selModel = nil;
    for (PCAccountSelModel *model in self.sourceAry)
    {
        if (model.sel)
        {
            selModel = model;
            break;
        }
    }
    
    if (selModel)
    {
        [self updateUserInfoRequest:selModel.sourceId];
    }
}

#pragma mark - tableViewDelegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountSelCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccountSelCell"];
        cell.textLabel.textColor = Color_MainText;
        cell.textLabel.font = Font_sys_14;
    }
    PCAccountSelModel *model = self.sourceAry[indexPath.row];
    cell.textLabel.text = model.title;
    cell.accessoryType = model.sel ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (PCAccountSelModel *model in self.sourceAry)
    {
        NSInteger index = [self.sourceAry indexOfObject:model];
        model.sel = index == indexPath.row;
    }
    [self.tableView reloadData];
}

#pragma mark = get
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
