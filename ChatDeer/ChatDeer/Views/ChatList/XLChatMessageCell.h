//
//  XLChatMessageCell.h
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XLChatMessageCellType) {
    XLChatMessageCellTypeMine,
    XLChatMessageCellTypeOthers,
};

@interface XLChatMessageCell : UITableViewCell
@property (nonatomic, strong) AVIMMessage *imMessage;
@end
