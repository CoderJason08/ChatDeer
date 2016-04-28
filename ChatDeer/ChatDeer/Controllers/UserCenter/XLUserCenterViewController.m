//
//  XLUserCenterViewController.m
//  ChatDeer
//
//  Created by jhwy on 4/28/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "XLUserCenterViewController.h"
#import <AVOSCloud/AVUser.h>

@interface XLUserCenterViewController ()

@end

@implementation XLUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(logoff)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Func

- (void)logoff {
    [AVUser logOut];
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
