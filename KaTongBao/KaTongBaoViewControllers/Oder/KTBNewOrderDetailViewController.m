//
//  KTBNewOrderDetailViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/30.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBNewOrderDetailViewController.h"
#import "macro.h"
#import "Common.h"

@interface KTBNewOrderDetailViewController ()

@end

@implementation KTBNewOrderDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backImg];
    
    //防止sorllview偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.userInteractionEnabled = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44  - 20)];
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    //    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UIView * BGView = [[UIView alloc]initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width-20, 0)];
    BGView.backgroundColor = [UIColor whiteColor];
    BGView.layer.cornerRadius = 4.0F;
    BGView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    BGView.layer.borderWidth = 0.5F;
    BGView.userInteractionEnabled = YES;
    [scrollView addSubview:BGView];
    
    UILabel * lastLabel = nil;
    for (int i = 0; i < 6; i++) {
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+50*i, 120, 30)];
        UILabel * Label = [[UILabel alloc]initWithFrame:CGRectMake(120, titleLabel.frame.origin.y, 170, 30)];
        [BGView addSubview:titleLabel];
        [BGView addSubview:Label];
//        titleLabel.text = _titleArray[i];
//        Label.text = _dataArray[i];
        if (i == 2) {
           // Label.text = [self rePlaceCerString:Label.text];
        }
        titleLabel.font = [UIFont systemFontOfSize:15.0F];
        Label.font = [UIFont systemFontOfSize:15.0F];
        Label.textAlignment = NSTextAlignmentRight;
        //        [titleLabel sizeToFit];
        
        if (i == 5) {
            lastLabel = titleLabel;
        }else{
            
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, BGView.frame.size.width, 0.5)];
            line.backgroundColor  =[UIColor lightGrayColor];
            [BGView addSubview:line];
            
        }
    }
    BGView.frame = CGRectMake(10, 50, self.view.bounds.size.width-20, CGRectGetMaxY(lastLabel.frame)+10);
    
    scrollView.contentSize = CGSizeMake(0,KscreenHeight );
    [scrollView addSubview:BGView];
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
