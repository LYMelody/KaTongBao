//
//  GuidViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/4.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "GuidViewController.h"
#import "Common.h"
#import "LoginViewController.h"
#import "UIView+SDAutoLayout.h"
@interface GuidViewController ()

@end

@implementation GuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self InitGuid];
    
    
}

- (void)InitGuid {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [scroll setContentSize:CGSizeMake(KscreenWidth *3, 0)];
    [scroll setPagingEnabled:YES];
    scroll.userInteractionEnabled = YES;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    imageView1.image = [UIImage imageNamed:@"进入页One.png"];
    [scroll addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(KscreenWidth, 0, KscreenWidth, KscreenHeight)];
    imageView2.image = [UIImage imageNamed:@"进入页Two.png"];
    [scroll addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(KscreenWidth * 2, 0, KscreenWidth, KscreenHeight)];
    imageView3.image = [UIImage imageNamed:@"进入页3.png"];
    [scroll addSubview:imageView3];
    imageView3.userInteractionEnabled = YES;

    
    UIButton *LoginBtn = [[UIButton alloc] init];
    [LoginBtn setBackgroundImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(ToLoginIn) forControlEvents:UIControlEventTouchUpInside];
    [imageView3 addSubview:LoginBtn];
    LoginBtn.sd_layout.centerXEqualToView(imageView3).bottomSpaceToView(imageView3,65).heightIs(45).widthIs(140);
    
    
    [self.view addSubview:scroll];
    
}
//登录
- (void)ToLoginIn {
    
    LoginViewController *Login = [[LoginViewController alloc] init];
    Login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Login animated:YES];
    Login.hidesBottomBarWhenPushed =  NO;
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
