//
//  XLNavigationController.m
//  ChatDeer
//
//  Created by Jason on 16/3/22.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLNavigationController.h"

@interface XLNavigationController ()

@end

@implementation XLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:BlackColor];
//    [navBar setBarTintColor:WhiteColor];
//    navBar.barStyle = UIStatusBarStyleLightContent;
    
    NSMutableDictionary *attDict = @{}.mutableCopy;
    [attDict setObject:BlackColor forKey:NSForegroundColorAttributeName];
    [attDict setObject:BoldFont(18) forKey:NSFontAttributeName];
    [navBar setTitleTextAttributes:attDict];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationController.navigationBar.hidden = NO;
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        backItem.imageInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    return viewController;
}

- (void)backAction {
    [self popViewControllerAnimated:YES];
}

@end
