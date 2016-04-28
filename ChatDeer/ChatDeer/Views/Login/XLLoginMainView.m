//
//  XLLoginMainView.m
//  ChatDeer
//
//  Created by Jason on 16/4/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLLoginMainView.h"
#import "XLTextField.h"
#import "XLButton.h"

@interface XLLoginMainView ()
<
UITextFieldDelegate
>
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) XLTextField *accountTextField;
@property (nonatomic, strong) XLTextField *passwordTextField;
@property (nonatomic, strong) XLButton *actionButton;
@property (nonatomic, strong) UIButton *exchangeLoginButton;
@property (nonatomic, strong) UIButton *exchangeRegistButton;
@property (nonatomic, strong) UIImageView *selectedFlag;

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) XLLoginMainViewType type;
@end

@implementation XLLoginMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViewsConstraints];
        self.type = XLLoginMainViewTypeLogin;
        [self addObserver:self forKeyPath:@"type" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"type"];
}

#pragma mark - Private Func

- (void)loginAction:(XLButton *)button {
//    button.enabled = !button.isEnabled;
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginMainView:didClickActionButtonWithType:)]) {
        [self.delegate loginMainView:self didClickActionButtonWithType:self.type];
    }
}

- (void)exchangeButtonAction:(UIButton *)button {
    self.type = (XLLoginMainViewType)button.tag;
    [self.selectedFlag mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bannerImageView);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerX.equalTo(button);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    XLLoginMainViewType type = (XLLoginMainViewType)[change[@"new"] integerValue];
    BOOL isLoginType = type == XLLoginMainViewTypeLogin;
    self.accountTextField.placeholder = isLoginType ? @"用户名" : @"用户名(5-20个字符，由字母和数字组成)";
    self.passwordTextField.placeholder = isLoginType ? @"密码" : @"密码(5-20位)";
    NSString *buttonTitle = isLoginType ? @"登录" : @"注册";
    [UIView animateWithDuration:0.2 animations:^{
        [self.actionButton setTitle:buttonTitle forState:UIControlStateNormal];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.accountTextField) {
        self.account = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }else if (textField == self.passwordTextField) {
        self.password = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    return YES;
}


- (void)setupSubViewsConstraints {
    [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.4);
    }];
    
    CGFloat buttonWidth = SCREEN_WIDTH / 2.0f;
    [self.exchangeLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bannerImageView);
        make.bottom.equalTo(self.bannerImageView.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 35));
    }];
    
    [self.exchangeRegistButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bannerImageView);
        make.bottom.equalTo(self.bannerImageView.mas_bottom).offset(-10);
        make.size.equalTo(self.exchangeLoginButton);
    }];
    
    [self.selectedFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bannerImageView);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerX.equalTo(self.exchangeLoginButton);
    }];
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerImageView.mas_bottom).offset(20);
        make.left.offset(40);
        make.right.offset(-40);
        make.height.mas_equalTo(30);
    }];

    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTextField.mas_bottom).offset(20);
        make.left.equalTo(self.accountTextField);
        make.size.equalTo(self.accountTextField);
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.passwordTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(30);
        make.height.mas_equalTo(35);
    }];

}


#pragma mark - getter & setter

- (UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        self.bannerImageView = [UIImageView new];
        [self addSubview:_bannerImageView];
        _bannerImageView.backgroundColor = GrayColor;
        _bannerImageView.image = [UIImage imageNamed:@"116.pic.jpg"];
    }
    return _bannerImageView;
}

- (XLTextField *)accountTextField {
    if (!_accountTextField) {
        self.accountTextField = [XLTextField new];
        [self addSubview:_accountTextField];
        _accountTextField.font = BoldFont(14);
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTextField.placeholder = @"用户名";
        _accountTextField.delegate = self;
    }
    return _accountTextField;
}

- (XLTextField *)passwordTextField {
    if (!_passwordTextField) {
        self.passwordTextField = [XLTextField new];
        [self addSubview:_passwordTextField];
        _passwordTextField.font = BoldFont(14);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearsOnBeginEditing = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.placeholder = @"密码";
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (XLButton *)actionButton {
    if (!_actionButton) {
        self.actionButton = [XLButton buttonWithTitle:@"登录" titleColor:BlackColor backgroundColor:WhiteColor target:self selector:@selector(loginAction:)];
        [self addSubview:_actionButton];
    }
    return _actionButton;
}

- (UIButton *)exchangeLoginButton {
    if (!_exchangeLoginButton) {
        _exchangeLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeLoginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_exchangeLoginButton setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_exchangeLoginButton setBackgroundColor:[UIColor clearColor]];
        [_exchangeLoginButton addTarget:self action:@selector(exchangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _exchangeLoginButton.tag = 0;
        [self addSubview:_exchangeLoginButton];
    }
    return _exchangeLoginButton;
}

- (UIButton *)exchangeRegistButton {
    if (!_exchangeRegistButton) {
        _exchangeRegistButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeRegistButton setTitle:@"注册" forState:UIControlStateNormal];
        [_exchangeRegistButton setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_exchangeRegistButton setBackgroundColor:[UIColor clearColor]];
        [_exchangeRegistButton addTarget:self action:@selector(exchangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _exchangeRegistButton.tag = 1;
        [self addSubview:_exchangeRegistButton];
    }
    return _exchangeRegistButton;
}

- (UIImageView *)selectedFlag {
    if (!_selectedFlag) {
        _selectedFlag = [UIImageView new];
//        _selectedFlag.image = [UIImage imageNamed:@"triangle"];
//        _selectedFlag.contentMode = UIViewContentModeScaleAspectFit;
        _selectedFlag.backgroundColor = [UIColor whiteColor];
        [self addSubview:_selectedFlag];
    }
    return _selectedFlag;
}

@end
