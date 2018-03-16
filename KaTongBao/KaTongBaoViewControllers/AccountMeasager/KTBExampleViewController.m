//
//  KTBExampleViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/19.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBExampleViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "SJAvatarBrowser.h"
@interface KTBExampleViewController ()

@end

@implementation KTBExampleViewController {
    UIImageView *Img;
}

-(void)viewWillAppear:(BOOL)animated
{
    //不隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *Backimg = [[UIImageView alloc] init];
    Backimg.backgroundColor = [UIColor whiteColor];
    Backimg.userInteractionEnabled = YES;
    [self.view addSubview:Backimg];
    Backimg.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    
    UITapGestureRecognizer *Tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    Tap.numberOfTapsRequired = 1;
    
    
    
    
    Img = [[UIImageView alloc] init];
    Img.image = [UIImage imageNamed:@""];
    Img.layer.cornerRadius = 3;
    Img.layer.masksToBounds = YES;
    Img.userInteractionEnabled = YES;
    [Img addGestureRecognizer:Tap];
    [self.view addSubview:Img];
    
    if (self.tag == 101) {
        self.title = @"身份证正面照";
        Img.image = [UIImage imageNamed:@"身份证正面"];
        Img.sd_layout.leftSpaceToView(self.view,5).rightSpaceToView(self.view,5).centerYEqualToView(self.view).heightIs(200);
    }else if (self.tag == 102) {
        self.title = @"身份证背面照";
        Img.image = [UIImage imageNamed:@"身份证背面"];
        Img.sd_layout.leftSpaceToView(self.view,5).rightSpaceToView(self.view,5).centerYEqualToView(self.view).heightIs(200);
    }else if (self.tag == 103) {
        self.title = @"手持身份证照";
        Img.image = [UIImage imageNamed:@"手持身份证"];
        Img.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).centerYEqualToView(self.view).heightIs(300);
    }else if (self.tag == 104) {
        self.title = @"银行卡照片";
        Img.image = [UIImage imageNamed:@"银行卡照片"];
        Img.sd_layout.leftSpaceToView(self.view,5).rightSpaceToView(self.view,5).centerYEqualToView(self.view).heightIs(200);
        
    }else if (self.tag == 105) {
        self.title = @"微信交易限额";
        Img.image = [UIImage imageNamed:@"微信限额"];
        Img.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,0).heightIs(KscreenHeight - 66);
    }
    
}

- (void)tap {
    
    [SJAvatarBrowser showImage:Img];
    
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
