//
//  XLButton.h
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLButton : UIButton

+ (XLButton *)buttonWithTitle:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector;

+ (XLButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                       target:(id)target
                     selector:(SEL)selector;

@end
