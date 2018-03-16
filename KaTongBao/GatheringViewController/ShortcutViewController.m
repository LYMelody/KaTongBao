//
//  ShortcutViewController.m
//  JingXuan
//
//  Created by wj on 16/5/23.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ShortcutViewController.h"
#import "macro.h"
#import "ShortcutView.h"
#import "UIView+SDAutoLayout.h"
#import "NoCardView.h"
#import "TradeNameView.h"
#import "HttpRequest.h"
#import "NoCardViewController.h"
@interface ShortcutViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) NoCardViewController *noCardVC;
@end

@implementation ShortcutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBaseVCAttributes:@"确认订单" withLeftName:@"返回" withRightName:nil withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
//    _noCardModel = [[NoCardModel alloc] init];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = LightGrayColor;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setBackgroundColor:NavBack];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.sd_layout.bottomSpaceToView (self.view,100).leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).heightRatioToView(self.view,0.08);
    [_noCardVC setDataBlock:^(NSString *amount, NSString *orderNo, NSString *orderTime) {
        NSLog(@"----------%@",amount);
    }];
    NSLog(@"-----%@",_amount);
}
- (void)buttonClick:(UIButton *)sender {
//    [HttpRequest shortcutRequestOrderNo:<#(NSString *)#> orderType:<#(NSString *)#> 12amount:<#(NSString *)#> orderTime:<#(NSString *)#> goodsId:<#(NSString *)#> cardNo:<#(NSString *)#>];
    NSLog(@"---");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [NSArray arrayWithObjects:@"订单金额:",@"商品名称:",@"交易时间:",@"订单编号:", nil];
    
    
    if (indexPath.section == 0) {
        ShortcutView *shortcut = [[ShortcutView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [cell addSubview:shortcut];
        shortcut.label.text = array[indexPath.row];
        
    }
    
    if (indexPath.row == 2) {
        ShortcutView *shortcut = [[ShortcutView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [cell addSubview:shortcut];
        shortcut.label1.text = _dateStr;
    }
    if (indexPath.row == 1) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"arrow1"];
        [cell addSubview:imageView];
        imageView.sd_layout.centerYEqualToView(cell).rightSpaceToView(cell,15).widthIs(15).heightIs(20);
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"请输入银行卡号";
        [cell addSubview:textField];
        textField.sd_layout.centerYEqualToView(cell).leftSpaceToView(cell,20).widthIs(220).heightIs(40);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"arrow1"];
        [cell addSubview:imageView];
        imageView.sd_layout.centerYEqualToView(cell).rightSpaceToView(cell,15).widthIs(15).heightIs(20);
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 45)];
    view.backgroundColor = LightGrayColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KscreenWidth, 45)];
    if (section == 0) {
        label.text = @"订单信息";
    }else if (section == 1) {
        label.text = @"支付信息";
    }
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40.0f;
        
    }
    return 45.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.section == 0 && indexPath.row == 1) {
        TradeNameView *tradeName = [[TradeNameView alloc] init];
        [self.view addSubview:tradeName];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {

    }
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
