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
@end

@implementation XLLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XLLoginMainView *mainView = [XLLoginMainView new];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    mainView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XLLoginMainViewDelegate

- (void)loginMainViewDidClickLoginButton:(XLLoginMainView *)loginMainView {
    NSString *account = loginMainView.account;
//    NSString *password = loginMainView.password;
    [XLIMClient confirmIMClientWithClientId:account openCallBack:^(BOOL isSucceed, NSError *error) {
        
    }];
}

- (void)loginMainView:(XLLoginMainView *)loginMainView didClickActionButtonWithType:(XLLoginMainViewType)type {
    if (type == XLLoginMainViewTypeLogin) {
        [AVUser logInWithUsernameInBackground:loginMainView.account password:loginMainView.password block:^(AVUser *user, NSError *error) {
            if (user && !error) {
                NSLog(@"登录成功");
                [XLIMClient confirmIMClientWithClientId:user.username openCallBack:^(BOOL isSucceed, NSError *error) {
                    
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
