//
//  XLTabBarController.m
//  ChatDeer
//
//  Created by Jason on 16/3/22.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLTabBarController.h"
#import "XLNavigationController.h"

@interface XLTabBarController ()
<
UITabBarControllerDelegate
>

@end

@implementation XLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self initialLizeTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialLizeTabBarController {
    [self setupTabBarItemWithViewControllerClass:NSClassFromString(@"XLChatListTableViewController") normalImageName:@"chat" selectedImageName:@"chat_filled"];
    [self setupTabBarItemWithViewControllerClass:NSClassFromString(@"UIViewController") normalImageName:@"user_menu" selectedImageName:@"user_menu_filled"];
    [self setupTabBarItemWithViewControllerClass:NSClassFromString(@"XLUserCenterViewController") normalImageName:@"wild_animals_sign" selectedImageName:@"wild_animals_sign_filled"];
}

- (void)setupTabBarItemWithViewControllerClass:(Class)viewControllerClass
                               normalImageName:(NSString *)normalImageName
                             selectedImageName:(NSString *)selectedImageName {
    id viewController = [viewControllerClass new];
    XLNavigationController *navigationController = [[XLNavigationController alloc] initWithRootViewController:viewController];
    UIImage *normalImage = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:normalImage selectedImage:selectedImage];
    navigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self addChildViewController:navigationController];
    
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.25f;
    [self.view.window.layer addAnimation:transition forKey:@"fadeTransition"];
    return YES;
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
