//
//  XLChatMessageToolBar.h
//  ChatDeer
//
//  Created by Jason on 16/4/4.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLChatMessageToolBar;

@protocol XLChatMessageToolBarDelegate <NSObject>
@optional
- (void)chatMessageToolBar:(XLChatMessageToolBar *)toolBar pressReturnKeyWithMessage:(AVIMMessage *)message;
@end

@interface XLChatMessageToolBar : UIToolbar
@property (nonatomic, weak) id<XLChatMessageToolBarDelegate> actionDelegate;
@end
