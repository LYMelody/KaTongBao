//
//  AboutTextViewController.m
//  wujieNew
//
//  Created by rongfeng on 16/5/10.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "AboutTextViewController.h"

@interface AboutTextViewController ()

@end

@implementation AboutTextViewController
- (void)viewWillAppear:(BOOL)animated {
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷支付服务协议";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Pay" ofType:@"txt"];
    NSString * pathString = [NSString stringWithContentsOfFile:path encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:nil];
    if (nil ==  pathString ||pathString.length <= 0) {
        pathString = [NSString stringWithContentsOfFile:path encoding:4 error:nil];
        
    }
    
    UIScrollView * SC  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50 + 15, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    //    SC.backgroundColor = [UIColor redColor];
    [self.view addSubview:SC];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    label.backgroundColor = [UIColor clearColor];
    label.text = pathString;
    label.textColor = [UIColor grayColor];
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
