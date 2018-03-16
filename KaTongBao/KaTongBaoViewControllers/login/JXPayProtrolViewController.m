//
//  JXPayProtrolViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXPayProtrolViewController.h"
#import "Common.h"
@interface JXPayProtrolViewController ()

@end

@implementation JXPayProtrolViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务协议";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backImg];

    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString * path = [[NSBundle mainBundle]pathForResource:@"JXPay" ofType:@"txt"];
    NSString * pathString = [NSString stringWithContentsOfFile:path encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:nil];
    if (nil ==  pathString ||pathString.length <= 0) {
        pathString = [NSString stringWithContentsOfFile:path encoding:4 error:nil];
    }
    
    UIScrollView * SC  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
    //    SC.backgroundColor = [UIColor redColor];
    [self.view addSubview:SC];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 320 - 32, 0)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //label.backgroundColor = [UIColor clearColor];
    label.text = pathString;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    [SC addSubview:label];
    SC.contentSize = CGSizeMake(0, label.bounds.size.height+64);
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
