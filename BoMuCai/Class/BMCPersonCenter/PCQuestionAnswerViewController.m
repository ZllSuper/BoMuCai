//
//  PCQuestionAnswerViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCQuestionAnswerViewController.h"
#import "PCQuestionAnswerRequest.h"

@interface PCQuestionAnswerViewController () <UITextViewDelegate>

@property (nonatomic, weak) PCQuestionModel *weakModel;

@property (nonatomic, strong) UITextView *answerTextView;

@end

@implementation PCQuestionAnswerViewController

- (instancetype)initWithQuestionModel:(PCQuestionModel *)questionModel
{
    if (self = [super init])
    {
        self.weakModel = questionModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"常见问题";
    
    [self.view addSubview:self.answerTextView];
    [self.answerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10);
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
    
    [self answerRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)answerRequest
{
    __weak typeof(self) weakSelf = self;
    PCQuestionAnswerRequest *item = [[PCQuestionAnswerRequest alloc] init];
    item.questionId = self.weakModel.questionId;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            self.answerTextView.text = request.response.data;
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

#pragma mark - delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark - get
- (UITextView *)answerTextView
{
    if (!_answerTextView)
    {
        _answerTextView = [[UITextView alloc] init];
        _answerTextView.delegate = self;
        _answerTextView.font = Font_sys_14;
        _answerTextView.textColor = Color_MainText;
        _answerTextView.backgroundColor = Color_Clear;
        
    }
    return _answerTextView;
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
