//
//  MessageCenterTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "MessageCenterTableView.h"

@implementation MessageCenterTableView

- (void)dealloc
{
    [self unregisterNotifications];
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
        [self registerNotifications];
        self.tableHeaderView = self.headerView;
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
    }];
    
    
    
    [self.soureAry removeAllObjects];
    EaseConversationModel *systemModel = nil;
    for (EMConversation *converstion in sorted)
    {
        EaseConversationModel *model = nil;
        model = [[EaseConversationModel alloc] initWithConversation:converstion];
        
        if (model && ![model.conversation.conversationId isEqualToString:@"test"])
        {
            [self.soureAry addObject:model];
        }
        else
        {
            systemModel = model;
        }
    }
    self.headerView.subTitleLabel.text = [self _latestMessageTitleForConversationModel:systemModel];
    [self.mj_header endRefreshing];
    [self reloadData];
}

#pragma mark - registerNotifications
-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
}

- (void)groupListDidUpdate:(NSArray *)aGroupList
{
    [self requestViewSource:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soureAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterTalkCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageCenterTalkCell className]];
    if (!cell)
    {
        cell = [[MessageCenterTalkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MessageCenterTalkCell className]];
    }
    EaseConversationModel *chatModel = self.soureAry[indexPath.row];
    cell.badgeView.badgeText = (chatModel.conversation.unreadMessagesCount > 0 ?_StrFormate(@"%d",chatModel.conversation.unreadMessagesCount) : @"");
    cell.subTitleLabel.text = [self _latestMessageTitleForConversationModel:chatModel];
    [cell requestWithConversationModel:chatModel];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        EaseConversationModel *chatModel = self.soureAry[indexPath.row];
        __block EaseConversationModel *blockModel = chatModel;
        __weak typeof(self) weakSelf = self;
        [[EMClient sharedClient].chatManager deleteConversation:chatModel.conversation.conversationId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
            [weakSelf.soureAry removeObject:blockModel];
            [weakSelf reloadData];
        }];
    }
}

/*!
 @method
 @brief 获取会话最近一条消息内容提示
 @discussion
 @param conversationModel  会话model
 @result 返回传入会话model最近一条消息提示
 */
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSEaseLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSEaseLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSEaseLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSEaseLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSEaseLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}



#pragma mark - get
- (MessageCenterHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[MessageCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREENWIDTH, 90)];
    }
    return _headerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
