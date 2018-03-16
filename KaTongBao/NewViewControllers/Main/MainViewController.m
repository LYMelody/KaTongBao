//
//  MainViewController.m
//  wujieNew
//
//  Created by rongfeng on 15/12/17.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+SDAutoLayout.h"

@implementation MainViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *logiBtn = [[UIButton alloc] init];
    [logiBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 8 + 登录.png"] forState:UIControlStateNormal];
    [logiBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logiBtn];
    logiBtn.sd_layout.leftSpaceToView(self.view,30).topSpaceToView(self.view,420).widthIs(260).heightIs(40);

}

- (void)back {
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
   
}
@end
