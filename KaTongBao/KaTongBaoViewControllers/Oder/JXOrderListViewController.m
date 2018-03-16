//
//  JXOrderListViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/1.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXOrderListViewController.h"
#import "Common.h"
#import "JieSuanCell.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "BusiIntf.h"
#import "SVProgressHUD.h"
#import "JieSuanModel.h"
#import "UIView+SDAutoLayout.h"
#import "JieSuanDetailVC.h"
#import "macro.h"
#import "KTBOrderDetailViewController.h"
#import "KTBNewOrderDetailViewController.h"
#import "GiFHUD.h"
@interface JXOrderListViewController ()

@end

@implementation JXOrderListViewController {
    NSMutableArray *array;
    UITableView *table;
    NSMutableArray *Arrays;
    UIDatePicker *datePicker;
    UIDatePicker *DatePickerTwo;
    UILabel *BeginLab;
    UILabel *EndLab;
    UIButton *TimeBtn;
    UIButton *CurBtn;
    NSString *StartTime;
    NSString *EndTime;
    UIButton *CancleBtn;

}

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
    self.tabBarController.tabBar.hidden = NO;
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    self.title = @"订单";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    [self.view addSubview:BackImg];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(ToJieSuan)];

    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold"size:16.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil]  forState:UIControlStateNormal];
    datePicker.hidden = YES;

    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    Img.layer.cornerRadius = 3;
    [self.view addSubview:Img];
    Img.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,78 - 64).widthIs(288).heightIs(45);
    
    BeginLab = [[UILabel alloc] initWithFrame:CGRectMake(41, 86.5 - 64, 120, 28)];
    BeginLab.text = @"2016-01-07";
    BeginLab.text = [self getToday];
    BeginLab.font = [UIFont systemFontOfSize:14];
    BeginLab.userInteractionEnabled = YES;
    //BeginLab.centerX = Img.centerX;
    //BeginLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:BeginLab];
    
    EndLab = [[UILabel alloc] init];
    EndLab.text = @"2016-01-08";
    EndLab.text = [self getToday];
    EndLab.font = [UIFont systemFontOfSize:14];
    EndLab.userInteractionEnabled = YES;
    EndLab.textAlignment = NSTextAlignmentCenter;
    //EndLab.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:EndLab];
    EndLab.sd_layout.rightSpaceToView(self.view,41).topSpaceToView(self.view,86.5 - 64).widthIs(110).heightIs(28);
    //EndLab.centerX = Img.centerX;
    
    BeginLab.userInteractionEnabled = YES;
    EndLab.userInteractionEnabled = YES;
    
    UIImageView *MidImg = [[UIImageView alloc] init];
    MidImg.backgroundColor = Color(144, 144, 144);
    [self.view addSubview:MidImg];
    MidImg.sd_layout.leftSpaceToView(BeginLab,14).topSpaceToView(self.view,99 - 64).rightSpaceToView(EndLab,8).heightIs(2);
    //MidImg.centerX = Img.centerX;
    
    UIButton *BeginBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 86.5 - 64, 100 , 28)];
    BeginBtn.tag = 0;
    BeginBtn.userInteractionEnabled = YES;
    BeginBtn.alpha = 0.3;
    BeginBtn.layer.cornerRadius = 3;
    [BeginBtn addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BeginBtn];
    
    UIButton *EndBtn = [[UIButton alloc] init];
    EndBtn.tag = 1;
    EndBtn.userInteractionEnabled = YES;
    EndBtn.alpha = 0.3;
    EndBtn.layer.cornerRadius = 3;
    [EndBtn addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:EndBtn];
    EndBtn.sd_layout.rightSpaceToView(self.view,50).topSpaceToView(self.view,86.5 - 64).widthIs(100 ).heightIs(28);
    
    //table
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 133 - 64, KscreenWidth, KscreenHeight - 133 - 49) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    //设置是否显示横线
    table.separatorStyle = UITableViewCellSelectionStyleNone;
    table.hidden = YES;
    [self.view addSubview:table];
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.layer.cornerRadius = 3;
    datePicker.layer.masksToBounds = YES;
    datePicker.layer.borderWidth = 0.5;
    datePicker.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [datePicker addTarget:self action:@selector(PickerValueChange:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = locale;
    [self.view addSubview:datePicker];
    datePicker.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).bottomSpaceToView(self.view,50).heightIs(200);
    //初始数据
    StartTime = [BeginLab.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    EndTime = [EndLab.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    StartTime = [NSString stringWithFormat:@"%@%@",StartTime,@"000000"];
    EndTime = [NSString stringWithFormat:@"%@%@",EndTime,@"235959"];
    datePicker.hidden = YES;
    //完成按钮
    CancleBtn = [[UIButton alloc] init];
    [CancleBtn setTitle:@"完成" forState:UIControlStateNormal];
    CancleBtn.backgroundColor = [UIColor whiteColor];
    CancleBtn.layer.borderWidth = 0.5;
    CancleBtn.layer.cornerRadius = 3;
    CancleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [CancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [CancleBtn addTarget:self action:@selector(DisAppearDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancleBtn];
    CancleBtn.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(datePicker,0).heightIs(40).widthIs((KscreenWidth - 32));
    CancleBtn.hidden = YES;
    
    //刷新数据
    [BusiIntf curPayOrder].action = @"nocardOrderListState";
    [self RequestForList:[BusiIntf curPayOrder].action TS:StartTime TE:EndTime];
}

- (void)DisAppearDatePicker {
    NSLog(@"*************");
    [self RequestForList:[BusiIntf curPayOrder].action TS:StartTime TE:EndTime];
}

//点击筛选
- (void)ToJieSuan {
    
    UIActionSheet *ActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收款", @"提现",nil];
    [ActionSheet showInView:self.view];
    
}

//
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        NSLog(@"收款!");
        [BusiIntf curPayOrder].action = @"nocardOrderListState";
        [self RequestForList:[BusiIntf curPayOrder].action TS:StartTime TE:EndTime];
        
    }else if (buttonIndex == 1) {
        NSLog(@"提现!");
        [BusiIntf curPayOrder].action = @"nocardSettleListState";
        [self RequestForList:[BusiIntf curPayOrder].action TS:StartTime TE:EndTime];
    }
}

- (void)changeDate:(id)sender {
    
    TimeBtn = (UIButton *)sender;
    //BeginLab.backgroundColor = [UIColor redColor];
    if (CurBtn == nil) {
        datePicker.hidden = NO;
        CancleBtn.hidden = NO;
        TimeBtn.backgroundColor = DateColor;
    } else {
        if (TimeBtn == CurBtn) {
            if (datePicker.hidden == NO) {
                datePicker.hidden = YES;
                CancleBtn.hidden = YES;
                CurBtn.backgroundColor = [UIColor clearColor];
            } else {
                datePicker.hidden = NO;
                CancleBtn.hidden = NO;
                //table.hidden = YES;
                CurBtn.backgroundColor = DateColor;
            }
            
        } else {
            datePicker.hidden = NO;
            CancleBtn.hidden = NO;
            CurBtn.backgroundColor = [UIColor clearColor];
            TimeBtn.backgroundColor = DateColor;
        }
    }
    CurBtn = TimeBtn;
}

//时间选择
- (void)PickerValueChange:(id)sender {
    
    if (TimeBtn.tag == 0) {
        //开始时间
        NSDate *curDate =[datePicker date];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateFormat:@"yyyy-MM-dd"];
        //[formate setTimeStyle:NSDateFormatterLongStyle];
        NSString *formateDateString = [formate stringFromDate:curDate];
        NSLog(@"string is %@" ,formateDateString);
        BeginLab.text = [NSString stringWithFormat:
                         @"%@", formateDateString];
    } else {
        //结束时间
        NSDate *curDate =[datePicker date];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateFormat:@"yyyy-MM-dd"];
        //[formate setTimeStyle:NSDateFormatterLongStyle];
        
        NSString *formateDateString = [formate stringFromDate:curDate];
        NSLog(@"string is %@" ,formateDateString);
        EndLab.text = [NSString stringWithFormat:
                       @"%@", formateDateString];
    }
    StartTime = [BeginLab.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    EndTime = [EndLab.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    StartTime = [NSString stringWithFormat:@"%@%@",StartTime,@"000000"];
    EndTime = [NSString stringWithFormat:@"%@%@",EndTime,@"235959"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 63;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        JieSuanModel *model = [[JieSuanModel alloc] init];
        model = Arrays[indexPath.row];
        JieSuanCell *jieSuanCell = [[JieSuanCell alloc] init];
        if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardOrderListState"]) {
            jieSuanCell.Typelab.text = @"收款";
            jieSuanCell.TimeLab.text = model.orderReqTime;
            jieSuanCell.MoneyLab.text = [NSString stringWithFormat:@"%@元",model.amount];
            jieSuanCell.StatusDetailLab.text = model.orderStatusName;
            if ([model.orderStatusName isEqualToString:@"支付成功"]) {
                jieSuanCell.StatusDetailLab.textColor  = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
            }else if ([model.orderStatusName isEqualToString:@"支付失败"]) {
                jieSuanCell.StatusDetailLab.textColor  = [UIColor colorWithRed:243/255.0 green:12/255.0 blue:12/255.0 alpha:1];
            }else {
                jieSuanCell.StatusDetailLab.textColor  = [UIColor orangeColor];
            }
        }else if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardSettleListState"]) {
            jieSuanCell.Typelab.text = @"提现";
            jieSuanCell.TimeLab.text = model.settleReqTime;
            jieSuanCell.MoneyLab.text = [NSString stringWithFormat:@"%@元",model.amount];
            jieSuanCell.StatusDetailLab.text = model.settleStatusName;
            if ([model.settleStatusName isEqualToString:@"支付成功"]) {
                jieSuanCell.StatusDetailLab.textColor  = [UIColor colorWithRed:58/255.0 green:142/255.0 blue:12/255.0 alpha:1];
            }else if ([model.settleStatusName isEqualToString:@"支付失败"]) {
                jieSuanCell.StatusDetailLab.textColor  = [UIColor colorWithRed:243/255.0 green:12/255.0 blue:12/255.0 alpha:1];
            }else {
                jieSuanCell.StatusDetailLab.textColor  = [UIColor orangeColor];
            }
        }
        
        cell = jieSuanCell;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KTBOrderDetailViewController *Detail = [[KTBOrderDetailViewController alloc] init];
    Detail.model = [[JieSuanModel alloc] init];
    Detail.model = Arrays[indexPath.row];
    [self.navigationController pushViewController:Detail animated:YES];
    
    
//    KTBNewOrderDetailViewController *NewDetail = [[KTBNewOrderDetailViewController alloc] init];
//    [self.navigationController pushViewController:NewDetail animated:YES];
}

- (void)RequestForList:(NSString *)type TS:(NSString *)startTime TE:(NSString *)endTime{
    //[SVProgressHUD show];
    [GiFHUD showWithOverlay];
    self.view.window.userInteractionEnabled = NO;
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    //NSString *status = @"9";
    //NSString *settleNo = @"";
    NSString *ts = startTime;
    NSString *te = endTime;
    NSString *page = @"0";
//    //时间戳
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
//    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timezone];
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",page,te,ts,key];
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           //@"processType":type,
                           //@"linkId":timeSp,
                           @"ts":ts,
                           @"te":te,
                           @"page":page,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":type,
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    NSLog(@"参数：%@",params);
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSDictionary *dicc = [result JSONValue];
        NSLog(@"订单列表：%@",dicc);
        NSDictionary *content = dicc[@"content"];
        array = [[NSMutableArray alloc] init];
        array = content[@"result"];
        if (array.count == 0) {
            table.hidden = YES;
            [self alert:@"暂无数据"];
            //[SVProgressHUD dismiss];
            [GiFHUD dismiss];
            self.view.window.userInteractionEnabled = YES;
            return ;
        }
        Arrays = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            
            JieSuanModel *model = [[JieSuanModel alloc] init];
            
            model.amount = dic[@"amount"];
            model.bankName = dic[@"bankName"];
            model.bankNo = dic[@"bankNo"];
            model.free = dic[@"free"];
            //结算数据
            if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardSettleListState"]) {
                model.settleType = dic[@"settleType"];
                model.settleNo = dic[@"settleNo"];
                model.settleReqTime = dic[@"settleReqTime"];
                model.settleStatusName = dic[@"settleStatusName"];
                model.protect = dic[@"protect"];
                model.rate = dic[@"rate"];
                model.real = dic[@"real"];
            }else if ([[BusiIntf curPayOrder].action isEqualToString:@"nocardOrderListState"]) { //收款数据
                model.goodsName = dic[@"goodsName"];
                model.orderNo = dic[@"orderNo"];
                model.orderReqTime = dic[@"orderReqTime"];
                model.orderStatus = dic[@"orderStatus"];
                model.orderStatusName = dic[@"orderStatusName"];
                model.orderType = dic[@"orderType"];
                model.refound = dic[@"refund"];

            }
            
//            model.settleType = dic[@"settleType"];
//            model.settleNo = dic[@"settleNo"];
//            model.settleReqTime = dic[@"settleReqTime"];
//            model.settleStatusName = dic[@"settleStatusName"];
            
            [Arrays addObject:model];
        }
        [table reloadData];
        table.hidden = NO;
        datePicker.hidden = YES;
        CancleBtn.hidden = YES;
        //NSString *content = dicc[@"content"];
        self.view.window.userInteractionEnabled = YES;
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"网络申请失败:%@",error);
        //[SVProgressHUD dismiss];
        [GiFHUD dismiss];
        self.view.window.userInteractionEnabled = YES;
    }];
}

//MD5加密
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

//获取当时日期
- (NSString*)getToday
{
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [df stringFromDate:today];
    
    return dateString;
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
