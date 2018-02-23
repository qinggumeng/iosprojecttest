//
//  LXDViewController.m
//  iOSProject
//
//  Created by zheng zhang on 2018/2/13.
//  Copyright © 2018年 HuXuPeng. All rights reserved.
//

#import "LXDViewController.h"
#import "LXD1ViewController.h"
#import "LXD2ViewController.h"
#import "LXD3ViewController.h"
#import "LXD4ViewController.h"
#import "LMJNavigationController.h"

@interface LXDViewController ()

@end

@implementation LXDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTabarItems];
    [self addChildViewControllers];
}

- (void)addChildViewControllers
{
   
    
    LMJNavigationController *two = [[LMJNavigationController alloc]
        initWithRootViewController:[[LXD1ViewController alloc] init]];
    
    LMJNavigationController *three = [[LMJNavigationController alloc] initWithRootViewController:[[LXD2ViewController alloc] init]];
    
    LMJNavigationController *four = [[LMJNavigationController alloc] initWithRootViewController:[[LXD3ViewController alloc] init]];
    
    LMJNavigationController *five = [[LMJNavigationController alloc] initWithRootViewController:[[LXD4ViewController alloc] init]];
    
    self.viewControllers = @[two, three, four,five];
    
}

- (void)addTabarItems
{
    
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"新闻",
                                                  CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"信息",
                                                 CYLTabBarItemImage : @"tabBar_new_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"tabBar_me_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                                                  };
 
    self.tabBarItemsAttributes = @[
                                   firstTabBarItemsAttributes,
                                   secondTabBarItemsAttributes,
                                       
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
