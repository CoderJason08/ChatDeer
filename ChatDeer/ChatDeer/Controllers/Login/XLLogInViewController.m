//
//  XLLandingViewController.m
//  ChatDeer
//
//  Created by Jason on 16/4/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLLogInViewController.h"
#import "XLLoginMainView.h"
#import <AVOSCloud/AVUser.h>

@interface XLLogInViewController ()
<
XLLoginMainViewDelegate
>
@property (nonatomic, strong) XLLoginMainView *mainView;
@end

@implementation XLLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainView = [XLLoginMainView new];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.mainView.delegate = self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification

/** 收到键盘弹出通知 */
- (void)receiveKeyboardWillShowNotification:(NSNotification *)notice {
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-150, 0, 0, 0));
    }];
    CGFloat duration = [notice.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

- (void)receiveKeyboardWillHideNotification:(NSNotification *)notice {
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    CGFloat duration = [notice.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - XLLoginMainViewDelegate

- (void)loginMainViewDidClickLoginButton:(XLLoginMainView *)loginMainView {
    NSString *account = loginMainView.account;
    [XLIMClient confirmIMClientWithClientId:account openCallBack:^(BOOL isSucceed, NSError *error) {
        
    }];
}

- (void)loginMainView:(XLLoginMainView *)loginMainView didClickActionButtonWithType:(XLLoginMainViewType)type {
    if (type == XLLoginMainViewTypeLogin) {
        [AVUser logInWithUsernameInBackground:loginMainView.account password:loginMainView.password block:^(AVUser *user, NSError *error) {
            if (user && !error) {
                NSLog(@"登录成功");
                /** 注册会话Client */
                [XLIMClient confirmIMClientWithClientId:user.username openCallBack:^(BOOL isSucceed, NSError *error) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }
        }];
    }else {
        /** 注册 */
        AVUser *user = [AVUser user];
        user.username = loginMainView.account;
        user.password = loginMainView.password;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded && !error) {
                NSLog(@"注册成功");
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
