//
//  XLButton.m
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLButton.h"

@implementation XLButton

+ (XLButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target selector:(SEL)selector {
    XLButton *button = [self new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button addObserver:button forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = BlackColor.CGColor;
    button.layer.borderWidth = 1.0f;
    return button;
}

+ (XLButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector {
    return [self buttonWithTitle:title titleColor:BlackColor backgroundColor:WhiteColor target:target selector:selector];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"enabled"]) {
        BOOL isEnabled = [change[@"new"] boolValue];
        self.backgroundColor = isEnabled ? WhiteColor : GrayColor;
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"enabled"];
}

@end
