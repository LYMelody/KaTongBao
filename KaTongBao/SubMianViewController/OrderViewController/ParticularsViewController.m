//
//  ParticularsViewController.m
//  JingXuan
//
//  Created by wj on 16/5/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ParticularsViewController.h"
#import "macro.h"
#import "ParticularsView.h"
#import "OrderModel.h"

@interface ParticularsViewController ()
@property (nonatomic, strong) OrderModel *order;

@end

@implementation ParticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"订单详情" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    ParticularsView *particulars = [[ParticularsView alloc] initWithFrame:CGRectMake(0, 84, KscreenWidth, KscreenHeight)];
    
     particulars.resultLabel.text = _result;
    particulars.moneyLabel1.text = _money;
    particulars.timeLabel1.text = _time;
    [self.view addSubview:particulars];
    
}
- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
