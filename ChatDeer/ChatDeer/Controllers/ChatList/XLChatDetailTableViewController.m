//
//  XLChatDetailTableViewController.m
//  ChatDeer
//
//  Created by Jason on 16/3/30.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLChatDetailTableViewController.h"
#import "XLChatMessageCell.h"
#import "XLChatMessageToolBar.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface XLChatDetailTableViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
XLChatMessageToolBarDelegate,
AVIMClientDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XLChatMessageToolBar *bottomToolBar;
@property (nonatomic, strong) AVIMClient *client;
@end

@implementation XLChatDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.currentConversation.name;
    [self tableView];
    [self bottomToolBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotificationTrigger:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[XLIMClient sharedClient] setDelegate:self];
    if (!self.messages) {
        self.messages = @[].mutableCopy;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)keyboardWillChangeFrameNotificationTrigger:(NSNotification *)notification {
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGFloat endY = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y;
    CGFloat offset = -(SCREEN_HEIGHT - endY);
    [self.bottomToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(offset);
    }];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - AVIMClientDelegate

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message {
    [self.messages addObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - XLChatMessageToolBarDelegate

- (void)chatMessageToolBar:(XLChatMessageToolBar *)toolBar pressReturnKeyWithMessage:(AVIMMessage *)message {
    [self.currentConversation sendMessage:message callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.messages addObject:message];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLChatMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XLChatMessageCell class]) forIndexPath:indexPath];
    messageCell.imMessage = self.messages[indexPath.row];
    return messageCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([XLChatMessageCell class]) cacheByIndexPath:indexPath configuration:^(XLChatMessageCell *cell) {
//        cell.imMessage = self.messages[indexPath.row];
//    }];
    return 100;
}

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [UITableView new];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuide);
            make.bottom.equalTo(self.bottomToolBar.mas_top);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[XLChatMessageCell class] forCellReuseIdentifier:NSStringFromClass([XLChatMessageCell class])];
        _tableView.backgroundColor = LightGrayColor;
    }
    return _tableView;
}

- (XLChatMessageToolBar *)bottomToolBar {
    if (!_bottomToolBar) {
        self.bottomToolBar = [XLChatMessageToolBar new];
        [self.view addSubview:_bottomToolBar];
        [_bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.height.mas_equalTo(49);
        }];
        _bottomToolBar.actionDelegate = self;
    }
    return _bottomToolBar;
}

@end
