//
//  XLTextField.m
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLTextField.h"

@interface XLTextField ()
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation XLTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bottomLine = ({
            UIView *bottomLine = [UIView new];
            [self addSubview:bottomLine];
            bottomLine.backgroundColor = BlackColor;
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self);
                make.height.mas_equalTo(1);
            }];
            bottomLine;
        });
    }
    return self;
}

@end
