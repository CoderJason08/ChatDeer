//
//  XLKeyBoard.m
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLKeyBoard.h"

@implementation XLKeyBoard
+ (void)load {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerTrigger)];
    
    [notificationCenter addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        UIView *rootView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        [rootView addGestureRecognizer:tapGestureRecognizer];
    }];
    
    [notificationCenter addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        UIView *rootView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        [rootView removeGestureRecognizer:tapGestureRecognizer];
    }];
}

+ (void)tapGestureRecognizerTrigger {
    [[UIApplication sharedApplication].keyWindow.rootViewController.view endEditing:YES];
}
@end
