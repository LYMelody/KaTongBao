//
//  OrderViewController.m
//  JingXuan
//
//  Created by wj on 16/5/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "OrderViewController.h"
#import "macro.h"
#import "OrderView.h"
#import "ParticularsViewController.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "OrderModel.h"
#import "SZCalendarPicker.h"
@interface OrderViewController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderView *orderCell;
@property (nonatomic, strong) OrderModel *order;
@property (nonatomic, strong) SZCalendarPicker *calendarPicker;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBaseVCAttributes:@"订单" withLeftName:nil withRightName:@"筛选" withColor:NavBack];
    self.view.backgroundColor = LightGrayColor;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, KscreenWidth, KscreenHeight)];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.backgroundColor = LightGrayColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dic[@"content"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[cell viewWithTag:ORDERVIEWTAGE] removeFromSuperview];
    _orderCell = [[OrderView alloc] initWithFrame:self.view.frame];
    _orderCell.moneyLabel.text = [NSString stringWithFormat:@"金额：%@",_order.amount];
    _orderCell.timeLabel.text = _order.orderReqTime;
    _orderCell.statutLabel.text = [NSString stringWithFormat:@"状态：%@",_order.orderStatus];;
    [cell addSubview:_orderCell];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        ParticularsViewController *particularsVC = [[ParticularsViewController alloc] init];
        particularsVC.result = _orderCell.statutLabel.text;
        particularsVC.money = _orderCell.moneyLabel.text;
        particularsVC.time = _orderCell.timeLabel.text;
    
    
        [self.navigationController pushViewController:particularsVC animated:YES];
}
- (void)leftEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButton:(UIButton *)sender {
    
    if(!self.actionSheet){
        self.actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"全部" otherButtonTitles:@"收款",@"结算",@"选择交易日期", nil];
    }
    [self.actionSheet showInView:self.view];
    
}
/*actionSheet的代理*/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"全部");
            [self orderType:@"2" ts:@"" te:@""];
            
            break;
        case 1:
            NSLog(@"收款");
            [self orderType:@"0" ts:@"" te:@""];
            break;
        case 2:
            NSLog(@"结算");
            [self orderType:@"1" ts:@"" te:@""];
            break;
  
        default:
            NSLog(@"选择日期");
            _calendarPicker = [SZCalendarPicker showOnView:self.view];
            _calendarPicker.today = [NSDate date];
            _calendarPicker.date = _calendarPicker.today;
            _calendarPicker.frame = CGRectMake(0, 100, self.view.frame.size.width, 352);
            _calendarPicker.calendarBlock = ^(NSArray *dataArray){
                NSLog(@"%@", dataArray);
                
                if (dataArray.count == 2) {
                    [self orderType:@"2" ts:dataArray[0] te:dataArray[1]];
                    NSLog(@"%@",dataArray[1]);
                }
            };

            
            break;
    }
}
-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}	
- (void)orderType:(NSString *)orderType ts:(NSString *)ts te:(NSString *)te {

    _user = [NSUserDefaults standardUserDefaults];
    NSString *auth = [_user objectForKey:@"auth"];
    NSString *key = [_user objectForKey:@"key"];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",orderType,ts,te,@"0",key];
    NSLog(@"%@",sign);
    NSString *SIGN = [self md5:sign];
    
    NSDictionary *dic1 = @{@"orderType":orderType,
                                       @"ts":ts,
                                       @"te":te,
                                       @"page":@"0",
                                       @"token":auth,
                                       @"sign":SIGN,
                                       };
    NSDictionary *dicc = @{@"action":@"OrderRecordQuery",
                                       @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSLog(@"数据:%@",result);
       _dic = [result JSONValue];
        
        _order = [[OrderModel alloc] init];
        [_order initWithDic:_dic];

        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
    
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
