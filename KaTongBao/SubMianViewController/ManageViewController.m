//
//  ManageViewController.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ManageViewController.h"
#import "macro.h"
@interface ManageViewController ()

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"卡管理" withLeftName:nil withRightName:nil withColor:NavBack];
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
