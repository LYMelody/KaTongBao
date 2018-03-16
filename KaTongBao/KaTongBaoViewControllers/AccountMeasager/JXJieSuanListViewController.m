//
//  JXJieSuanListViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXJieSuanListViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "JieSuanCell.h"
#import "JieSuanModel.h"
#import <CommonCrypto/CommonDigest.h>
@interface JXJieSuanListViewController ()

@end

@implementation JXJieSuanListViewController {
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
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"结算记录";
    self.view.backgroundColor = [UIColor whiteColor];
    //修改返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    left.title = @"返回";
    self.navigationItem.backBarButtonItem = left;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    //测试结算记录
    //[self RequestForList:@"RB1" TS:@"20160101000000" TE:@"20160106595959"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = LightGrayColor;
    [self.view addSubview:BackImg];
    
    //datePicker.hidden = YES;
    
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Img];
    Img.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,78).widthIs(288).heightIs(34);
    
    BeginLab = [[UILabel alloc] initWithFrame:CGRectMake(61, 84.5, 100, 20)];
    BeginLab.text = @"2016-01-07";
    BeginLab.text = [self getToday];
    BeginLab.font = [UIFont systemFontOfSize:14];
    BeginLab.userInteractionEnabled = YES;
    [self.view addSubview:BeginLab];
    
    EndLab = [[UILabel alloc] init];
    EndLab.text = @"2016-01-08";
    EndLab.text = [self getToday];
    EndLab.font = [UIFont systemFontOfSize:14];
    EndLab.userInteractionEnabled = YES;
    [self.view addSubview:EndLab];
    EndLab.sd_layout.rightSpaceToView(self.view,61).topSpaceToView(self.view,84.5).widthIs(100).heightIs(20);
    BeginLab.userInteractionEnabled = YES;
    EndLab.userInteractionEnabled = YES;
    UIImageView *MidImg = [[UIImageView alloc] init];
    MidImg.backgroundColor = Color(144, 144, 144);
    [self.view addSubview:MidImg];
    MidImg.sd_layout.leftSpaceToView(BeginLab,5).topSpaceToView(self.view,94).rightSpaceToView(EndLab,5).heightIs(2);
    
    UIButton *BeginBtn = [[UIButton alloc] initWithFrame:CGRectMake(61, 84.5, 100 - 20, 20)];
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
    EndBtn.sd_layout.rightSpaceToView(self.view,61 + 20).topSpaceToView(self.view,84.5).widthIs(100 - 20).heightIs(20);
    
    //table
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 133, KscreenWidth, KscreenHeight - 133) style:UITableViewStylePlain];
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

    
    
}
- (void)changeDate:(id)sender {
    
    TimeBtn = (UIButton *)sender;
    //BeginLab.backgroundColor = [UIColor redColor];
    if (CurBtn == nil) {
        datePicker.hidden = NO;
        TimeBtn.backgroundColor = DateColor;
    } else {
        if (TimeBtn == CurBtn) {
            if (datePicker.hidden == NO) {
                datePicker.hidden = YES;
                CurBtn.backgroundColor = [UIColor clearColor];
            } else {
                datePicker.hidden = NO;
                //table.hidden = YES;
                CurBtn.backgroundColor = DateColor;
            }
            
        } else {
            datePicker.hidden = NO;
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
    //[self RequestForList:[BusiIntf curPayOrder].TypeOrder TS:StartTime TE:EndTime];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
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
        JieSuanCell *JiesuanCell = [[JieSuanCell alloc] init];
        JiesuanCell.TimeLable.text = model.settleReqTime;
        JiesuanCell.AmountLable.text = model.amount;
        JiesuanCell.TypeLable.text = model.settleStatusName;
        
        cell = JiesuanCell;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    JieSuanDetailVC *Detail = [[JieSuanDetailVC alloc] init];
//    Detail.model = [[JieSuanModel alloc] init];
//    Detail.model = Arrays[indexPath.row];
//    [self.navigationController pushViewController:Detail animated:YES];
    
    
}

- (void)RequestForList:(NSString *)type TS:(NSString *)startTime TE:(NSString *)endTime{
//    [SVProgressHUD show];
//    NSString *url = BaseUrl;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *status = @"9";
//    NSString *settleNo = @"";
//    NSString *ts = startTime;
//    NSString *te = endTime;
//    NSString *page = @"0";
//    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",type,status,settleNo,ts,te,page,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"type":type,
//                           @"status":status,
//                           @"settleNo":settleNo,
//                           @"ts":ts,
//                           @"te":te,
//                           @"page":page,
//                           @"token":token,
//                           @"sign":sign
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"SettleList",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    NSLog(@"参数：%@",params);
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        NSDictionary *dicc = [result JSONValue];
//        NSLog(@"订单列表：%@",dicc);
//        NSDictionary *content = dicc[@"content"];
//        array = [[NSMutableArray alloc] init];
//        array = content[@"result"];
//        if (array.count == 0) {
//            table.hidden = YES;
//            [self alert:@"暂无数据"];
//            [SVProgressHUD dismiss];
//            return ;
//        }
//        Arrays = [[NSMutableArray alloc] init];
//        for (NSDictionary *dic in array) {
//            
//            JieSuanModel *model = [[JieSuanModel alloc] init];
//            model.amount = dic[@"amount"];
//            model.free = dic[@"free"];
//            model.refound = dic[@"refund"];
//            model.settleNo = dic[@"settleNo"];
//            model.settleRate = dic[@"settleRate"];
//            model.settleRateFee = dic[@"settleRateFee"];
//            model.settleReqTime = dic[@"settleReqTime"];
//            model.settleStatus = dic[@"settleStatus"];
//            model.settleStatusName = dic[@"settleStatusName"];
//            model.settleType = dic[@"settleType"];
//            [Arrays addObject:model];
//        }
//        [table reloadData];
//        table.hidden = NO;
//        datePicker.hidden = YES;
//        //NSString *content = dicc[@"content"];
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        NSLog(@"网络申请失败:%@",error);
//        [SVProgressHUD dismiss];
//    }];
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
