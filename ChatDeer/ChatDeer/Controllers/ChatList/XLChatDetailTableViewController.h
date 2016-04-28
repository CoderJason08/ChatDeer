//
//  XLChatDetailTableViewController.h
//  ChatDeer
//
//  Created by Jason on 16/3/30.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface XLChatDetailTableViewController : UIViewController
@property (nonatomic, strong) AVIMConversation *currentConversation;
@property (nonatomic, strong) NSMutableArray *messages;
@end
