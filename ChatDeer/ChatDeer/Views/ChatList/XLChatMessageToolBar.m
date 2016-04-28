//
//  XLChatMessageToolBar.m
//  ChatDeer
//
//  Created by Jason on 16/4/4.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLChatMessageToolBar.h"

@interface XLChatMessageToolBar ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UIBarButtonItem *voiceButtonItem;
@property (nonatomic, strong) UIBarButtonItem *inputTextField;
@property (nonatomic, strong) UIBarButtonItem *faceButtonItem;
@property (nonatomic, strong) UIBarButtonItem *addButtonItem;
@end

@implementation XLChatMessageToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setItems:@[self.voiceButtonItem,self.inputTextField,self.faceButtonItem,self.addButtonItem] animated:YES];
    }
    return self;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(chatMessageToolBar:pressReturnKeyWithMessage:)]) {
        [self.actionDelegate chatMessageToolBar:self pressReturnKeyWithMessage:[AVIMMessage messageWithContent:textField.text]];
        textField.text = nil;
        return YES;
    }
    return NO;
}

#pragma mark - Getter & Setter

- (UIBarButtonItem *)voiceButtonItem {
    if (!_voiceButtonItem) {
        self.voiceButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"keyboard"] style:UIBarButtonItemStyleDone target:self action:nil];
        self.voiceButtonItem.tintColor = BlackColor;
    }
    return _voiceButtonItem;
}

- (UIBarButtonItem *)inputTextField {
    if (!_inputTextField) {
        UITextField *inputTextField = [UITextField new];
        inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        inputTextField.frame = CGRectMake(0, 0, 220, 35);
        inputTextField.returnKeyType = UIReturnKeySend;
        inputTextField.enablesReturnKeyAutomatically = YES;
        inputTextField.delegate = self;
        self.inputTextField = [[UIBarButtonItem alloc] initWithCustomView:inputTextField];
    }
    return _inputTextField;
}

-(UIBarButtonItem *)faceButtonItem {
    if (!_faceButtonItem) {
        self.faceButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wink"] style:UIBarButtonItemStyleDone target:self action:nil];
        self.faceButtonItem.tintColor = BlackColor;
    }
    return _faceButtonItem;
}

- (UIBarButtonItem *)addButtonItem {
    if (!_addButtonItem) {
        self.addButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStyleDone target:self action:nil];
        self.addButtonItem.tintColor = BlackColor;
    }
    return _addButtonItem;
}

@end
