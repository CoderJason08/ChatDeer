//
//  XLLoginMainView.h
//  ChatDeer
//
//  Created by Jason on 16/4/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLLoginMainView;

typedef NS_ENUM(NSUInteger, XLLoginMainViewType) {
    XLLoginMainViewTypeLogin = 0,
    XLLoginMainViewTypeRegist = 1,
};

@protocol XLLoginMainViewDelegate <NSObject>
@optional
- (void)loginMainView:(XLLoginMainView *)loginMainView didClickActionButtonWithType:(XLLoginMainViewType)type;
@end

@interface XLLoginMainView : UIView
@property (nonatomic, weak) id<XLLoginMainViewDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *account;
@property (nonatomic, copy, readonly) NSString *password;
@end
