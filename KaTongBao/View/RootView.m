//
//  RootView.m
//  JingXuan
//
//  Created by wj on 16/5/11.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "RootView.h"
#import "HomePageViewController.h"
#import "ManageViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"
@implementation RootView
+ (void)rootView {
    
    HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
    [self middle:homePageVC Titte:@"首页" showImage:@"首页" selectImage:@"首页2"];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homePageVC];
    
    ManageViewController *managerVC = [[ManageViewController alloc] init];
    [self middle:managerVC Titte:@"卡管理" showImage:@"卡管理" selectImage:@"卡管理2"];
    UINavigationController *managerNav = [[UINavigationController alloc]initWithRootViewController:managerVC];
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    [self middle:orderVC Titte:@"订单" showImage:@"订单" selectImage:@"订单2"];
    UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:orderVC];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    [self middle:myVC Titte:@"我的" showImage:@"我的" selectImage:@"我的2"];
    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = @[homeNav,managerNav,orderNav,myNav];
    UIWindow *winder = [[[UIApplication sharedApplication]delegate]window];
    winder.rootViewController = tabBar;
    [winder makeKeyAndVisible];
    
    
}
//将文字图片和选中图片
+ (void)middle:(UIViewController*)name Titte:(NSString*)tittle showImage:(NSString*)image selectImage:(NSString*)selectImage{
    
    name.title = tittle;
    name.tabBarItem.title = tittle;
    name.tabBarItem.image = [UIImage imageNamed:image];
    name.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
