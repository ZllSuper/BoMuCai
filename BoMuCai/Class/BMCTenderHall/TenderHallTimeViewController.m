//
//  TenderHallTimeViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallTimeViewController.h"
#import "TenderHallSortCell.h"
#import "UIMyDatePicker.h"

@interface TenderHallTimeViewController ()<UITableViewDelegate, UITableViewDataSource, UIMyDatePickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TenderHallSortCell *startCell;

@property (nonatomic, strong) TenderHallSortCell *endCell;

@property (nonatomic, assign) NSInteger dateIndex;

@end

@implementation TenderHallTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"起始时间";
    [self initRightNavigationItemWithTitle:@"确定" target:self action:@selector(confirmAction)];

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

#pragma mark - action
- (void)confirmAction
{
    if ([self.startCell.rightLabel.text isEqualToString:@"请选择"])
    {
        ToastShowBottom(@"请选择开始时间");
        return;
    }
    if ([self.endCell.rightLabel.text isEqualToString:@"请选择"])
    {
        ToastShowBottom(@"请选择结束时间");
        return;
    }
    
    [self.delegate timeChoose:self startTime:self.startCell.rightLabel.text endTime:self.endCell.rightLabel.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - datepickerDelegate
- (void)myDatePicker:(UIMyDatePicker *)picker tapedCancel:(BOOL)cancel
{
    [picker cancelDatePickerView];
    if (!cancel)
    {
        if (self.dateIndex == 0)
        {
            self.startCell.rightLabel.text = [picker.datePicker.date dateStrWithFormatStr:@"yyyy-MM-dd"];
        }
        else
        {
            self.endCell.rightLabel.text = [picker.datePicker.date dateStrWithFormatStr:@"yyyy-MM-dd"];
        }
    }
}

#pragma mark - tableViewDelegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return self.startCell;
    }
    else
    {
        return self.endCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.dateIndex = indexPath.row;
    
    UIMyDatePicker *datePicker = [[UIMyDatePicker alloc] initWithDelegate:self andType:BXHMyPickerViewBottomType];
    [datePicker showDatePickerView];
    
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

- (TenderHallSortCell *)startCell
{
    if (!_startCell)
    {
        _startCell = [[TenderHallSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TenderSortTime"];
        _startCell.titleLabel.text = @"开始时间";
    }
    return _startCell;
}

- (TenderHallSortCell *)endCell
{
    if (!_endCell)
    {
        _endCell = [[TenderHallSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TenderSortTime"];
        _endCell.titleLabel.text = @"结束时间";
    }
    return _endCell;
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
