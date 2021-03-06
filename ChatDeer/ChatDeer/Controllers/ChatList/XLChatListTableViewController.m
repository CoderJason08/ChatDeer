//
//  XLChatListTableViewController.m
//  ChatDeer
//
//  Created by Jason on 16/3/23.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLChatListTableViewController.h"
#import "XLChatListCell.h"
#import "XLChatDetailTableViewController.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
#import <AVOSCloud/AVOSCloud.h>

static NSInteger kPageSize = 10;

@interface XLChatListTableViewController ()

@end

@implementation XLChatListTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    self.tableView.backgroundColor = LightGrayColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[XLChatListCell class] forCellReuseIdentifier:NSStringFromClass([XLChatListCell class])];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUpdateConversationsNotification:) name:XLIMClientUpdateConversationsNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NotificationCenter

- (void)receiveUpdateConversationsNotification:(NSNotification *)notice {
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [XLIMClient sharedClient].conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLChatListCell *chatListCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XLChatListCell class]) forIndexPath:indexPath];
    chatListCell.conversation = [XLIMClient sharedClient].conversations[indexPath.row];
    return chatListCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    AVIMConversationQuery *query = [[AVIMClient defaultClient] conversationQuery];
//    [query whereKey:@"m" containsAllObjectsInArray:@[[XLIMClient sharedClient].clientId, clientId]];
//    [query whereKey:@"m" sizeEqualTo:2];
//    [query whereKey:AVIMAttr(@"customConversationType")  equalTo:@(1)];
//    query.cachePolicy = kAVIMCachePolicyNetworkOnly;
//    [AVOSCloud setAllLogsEnabled:YES];
    
//    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
//        if (objects.count == 0) {
//            [[XLIMClient sharedClient] createConversationWithName:@"xxx" clientIds:@[clientId] callback:^(AVIMConversation *conversation, NSError *error) {
//                [conversation queryMessagesWithLimit:kPageSize callback:^(NSArray *objects, NSError *error) {
//                    XLChatDetailTableViewController *chatDetail = [XLChatDetailTableViewController new];
//                    if (objects.count > 0) {
//                        chatDetail.messages = [objects mutableCopy];
//                    }
//                    chatDetail.currentConversation = conversation;
//                    [self.navigationController pushViewController:chatDetail animated:YES];
//                }];
//            }];
//        }else {
//            XLChatDetailTableViewController *chatDetail = [XLChatDetailTableViewController new];
//            chatDetail.currentConversation = objects[0];
//            [self.navigationController pushViewController:chatDetail animated:YES];
//        }
//    }];
    XLChatDetailTableViewController *chatDetail = [XLChatDetailTableViewController new];
    AVIMConversation *conversation = [XLIMClient sharedClient].conversations[indexPath.row];
    chatDetail.currentConversation = conversation;
    [conversation queryMessagesWithLimit:kPageSize callback:^(NSArray *objects, NSError *error) {
        chatDetail.messages = [objects mutableCopy];
        [self.navigationController pushViewController:chatDetail animated:YES];
    }];
    
}

@end
