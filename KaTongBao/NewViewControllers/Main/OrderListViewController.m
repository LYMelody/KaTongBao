//
//  OrderListViewController.m
//  wujieNew
//
//  Created by rongfeng on 15/12/17.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "OrderListViewController.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "BusiIntf.h"
#import "OrderListCell.h"
#import "OrderModel.h"
//#import "FCXRefreshBaseView.h"
#import "FCXRefreshFooterView.h"
#import "FCXRefreshHeaderView.h"
#import "UIScrollView+FCXRefresh.h"
@implementation OrderListViewController {
    
    UIImageView *StartView;
    UIImageView *StatusStartView;
    UIImageView *TimeStartView;
    UIImageView *TotalStartView;
    UIImageView *OrderListView;
    NSInteger _index;
    UIImageView *AllTypeImg;
    UIImageView *AllStatusImg;
    UIImageView *TimeImg;
    UILabel *AllTypeLab;
    UILabel *AllStatusLab;
    UILabel *TimeLab;
    UILabel *OrderLab;
    NSString *CurType;
    NSString *CurStatus;
    NSString *StartTime;
    NSString *EndTime;
    NSString *CurPage;
    NSMutableArray *ModelArray;
    UITableView *table;
    FCXRefreshHeaderView *headerView;
    FCXRefreshFooterView *footView;
    NSInteger pageIndex;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    //设置导航栏背景色和字体
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor clearColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = DrackBlue;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
//    CurType = @"RB0";
//    CurStatus = @"9";
//    StartTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"000000"];
//    EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
//    CurPage = @"0";
    //快捷订单记录
    if (CurPage == nil  && CurStatus ==nil && StartTime ==nil && EndTime == nil && CurPage == nil) {
            CurType = @"RB0";
            CurStatus = @"9";
            StartTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"000000"];
            EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
            CurPage = @"0";
    }
    [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"订单";
    self.view.backgroundColor = LightGrayColor;
    UITapGestureRecognizer *TapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TypeSelect)];
    TapOne.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StatusSelect)];
    TapTwo.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapThird = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TimeSelect)];
    TapThird.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OrderSelect)];
    TapFour.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapYiBao = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(YiBaoSelect)];
    TapYiBao.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TapWuJie = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WuJieSelect)];
    TapWuJie.numberOfTapsRequired = 1;
    /*帅选类型
     */
    //全部订单
    UIImageView *TotalOrderImg = [[UIImageView alloc] initWithFrame:CGRectMake(126, 12 , 83, 23)];
    CGFloat CenterX = self.view.centerX;
    TotalOrderImg.centerX = CenterX;
    TotalOrderImg.userInteractionEnabled = YES;
    [TotalOrderImg addGestureRecognizer:TapFour];
    [self.navigationController.navigationBar addSubview:TotalOrderImg];
    //TotalOrderImg.sd_layout.leftSpaceToView(self.view,126).topSpaceToView(self.view,31).widthIs(82).heightIs(23);
    OrderLab = [[UILabel alloc] init];
    OrderLab.text = @"无界支付";
    OrderLab.textColor = Color(232, 232, 232);
    OrderLab.font = [UIFont systemFontOfSize:17];
    [TotalOrderImg addSubview:OrderLab];
    OrderLab.sd_layout.leftSpaceToView(TotalOrderImg,3.5).topSpaceToView(TotalOrderImg,5).widthIs(73).heightIs(15.5);
    TotalStartView  = [[UIImageView alloc] init];
    TotalStartView.image = [UIImage imageNamed:@"白灰下.png"];
    [TotalOrderImg addSubview:TotalStartView];
    TotalStartView.sd_layout.leftSpaceToView(OrderLab,3).bottomEqualToView(OrderLab).widthIs(10).heightIs(6);
    
    //
    
    //全部类型
    AllTypeImg = [[UIImageView alloc] init];
    AllTypeImg.userInteractionEnabled = YES;
    [AllTypeImg addGestureRecognizer:TapOne];
    [self.view addSubview:AllTypeImg];
    AllTypeImg.sd_layout.leftSpaceToView(self.view,30).topSpaceToView(self.view,14.5 + 60 - 60).widthIs(75).heightIs(20.5);
    AllTypeLab = [[UILabel alloc] init];
    AllTypeLab.text = @"快捷收款";
    AllTypeLab.font = [UIFont systemFontOfSize:15];
    AllTypeLab.textColor = Gray100;
    [AllTypeImg addSubview:AllTypeLab];
    AllTypeLab.sd_layout.leftSpaceToView(AllTypeImg,3.5).topSpaceToView(AllTypeImg,5).widthIs(60).heightIs(15.5);
    StartView  = [[UIImageView alloc] init];
    StartView.image = [UIImage imageNamed:@"xiala.png"];
    [AllTypeImg addSubview:StartView];
    StartView.sd_layout.leftSpaceToView(AllTypeImg,67).bottomEqualToView(AllTypeLab).widthIs(10).heightIs(6);
    
    //全部状态
    AllStatusImg = [[UIImageView alloc] init];
    AllStatusImg.userInteractionEnabled = YES;
    [AllStatusImg addGestureRecognizer:TapTwo];
    [self.view addSubview:AllStatusImg];
    AllStatusImg.sd_layout.leftSpaceToView(self.view,126).topSpaceToView(self.view,74.5 - 60).widthIs(75).heightIs(20.5);
    AllStatusLab = [[UILabel alloc] init];
    AllStatusLab.text = @"全部状态";
    AllStatusLab.textColor = Gray100;
    AllStatusLab.font = [UIFont systemFontOfSize:15];
    [AllStatusImg addSubview:AllStatusLab];
    AllStatusLab.sd_layout.leftSpaceToView(AllStatusImg,3.5).topSpaceToView(AllStatusImg,5).widthIs(60).heightIs(15.5);
    StatusStartView = [[UIImageView alloc] init];
    StatusStartView.image = [UIImage imageNamed:@"xiala.png"];
    [AllStatusImg addSubview:StatusStartView];
    StatusStartView.sd_layout.leftSpaceToView(AllStatusImg,67).bottomEqualToView(AllStatusLab).widthIs(10).heightIs(6);

    //时间
    TimeImg = [[UIImageView alloc] init];
    TimeImg.userInteractionEnabled = YES;
    [TimeImg addGestureRecognizer:TapThird];
    [self.view addSubview:TimeImg];
    TimeImg.sd_layout.leftSpaceToView(self.view,210).topSpaceToView(self.view,74.5 - 60).widthIs(75).heightIs(20.5);
    TimeLab = [[UILabel alloc] init];
    TimeLab.text = @"今天";
    TimeLab.textColor = Gray100;
    TimeLab.font = [UIFont systemFontOfSize:15];
    [TimeImg addSubview:TimeLab];
    TimeLab.sd_layout.leftSpaceToView(TimeImg,3.5).topSpaceToView(TimeImg,5).widthIs(80).heightIs(15.5);
    TimeStartView = [[UIImageView alloc] init];
    TimeStartView.image = [UIImage imageNamed:@"xiala.png"];
    [TimeImg addSubview:TimeStartView];
    TimeStartView.sd_layout.leftSpaceToView(TimeImg,78).bottomEqualToView(TimeLab).widthIs(10).heightIs(6);
    //横线
    UIImageView *LineView = [[UIImageView alloc] init];
    LineView.backgroundColor = Color(216, 216, 216);
    [self.view addSubview:LineView];
    LineView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,103 - 60).heightIs(2);
    //
    OrderListView = [[UIImageView alloc] init];
    OrderListView.userInteractionEnabled = YES;
    OrderListView.backgroundColor = Color(52, 46, 65);
    OrderListView.layer.cornerRadius = 3;
    OrderListView.layer.masksToBounds = YES;
    [self.view addSubview:OrderListView];
    OrderListView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,63 - 60).widthIs(180).heightIs(80);
    OrderListView.hidden = YES;
    //易宝
    UIImageView *YiBaoBackImg = [[UIImageView alloc] init];
    YiBaoBackImg.backgroundColor = [UIColor clearColor];
    YiBaoBackImg.userInteractionEnabled = YES;
    [YiBaoBackImg addGestureRecognizer:TapYiBao];
    [OrderListView addSubview:YiBaoBackImg];
    YiBaoBackImg.sd_layout.leftSpaceToView(OrderListView,0).topSpaceToView(OrderListView,0).widthIs(180).heightIs(40);
    UIImageView *YiBaoImg = [[UIImageView alloc] init];
    YiBaoImg.image = [UIImage imageNamed:@"易宝2.png"];
    [YiBaoBackImg addSubview:YiBaoImg];
    YiBaoImg.sd_layout.leftSpaceToView(YiBaoBackImg,20).topSpaceToView(YiBaoBackImg,5).widthIs(30).heightIs(30);
    UILabel *YiBaoLab = [[UILabel alloc] init];
    YiBaoLab.text = @"易宝";
    YiBaoLab.textColor = [UIColor whiteColor];
    YiBaoLab.font = [UIFont systemFontOfSize:15];
    YiBaoLab.textAlignment = NSTextAlignmentLeft;
    [YiBaoBackImg addSubview:YiBaoLab];
    YiBaoLab.sd_layout.leftSpaceToView(YiBaoBackImg,68).topSpaceToView(YiBaoBackImg,8).widthIs(80).heightIs(25);
    //line
    UIImageView *LineViewImg = [[UIImageView alloc] init];
    LineViewImg.backgroundColor = Color(145, 136, 136);
    [OrderListView addSubview:LineViewImg];
    LineViewImg.sd_layout.leftSpaceToView(OrderListView,9.5).topSpaceToView(OrderListView,40).widthIs(157).heightIs(0.3);
    //无界
    UIImageView *WuJieBackImg = [[UIImageView alloc] init];
    WuJieBackImg.backgroundColor = [UIColor clearColor];
    WuJieBackImg.userInteractionEnabled = YES;
    [WuJieBackImg addGestureRecognizer:TapWuJie];
    [OrderListView addSubview:WuJieBackImg];
    WuJieBackImg.sd_layout.leftSpaceToView(OrderListView,0).topSpaceToView(OrderListView,40).widthIs(180).heightIs(30);
    UIImageView *WuJieImg = [[UIImageView alloc] init];
    WuJieImg.image = [UIImage imageNamed:@"无界2.png"];
    [WuJieBackImg addSubview:WuJieImg];
    WuJieImg.sd_layout.leftSpaceToView(WuJieBackImg,20).topSpaceToView(WuJieBackImg,5).widthIs(30).heightIs(30);
    UILabel *WuJieLab = [[UILabel alloc] init];
    WuJieLab.text = @"无界支付";
    WuJieLab.textColor = [UIColor whiteColor];
    WuJieLab.font = [UIFont systemFontOfSize:15];
    WuJieLab.textAlignment = NSTextAlignmentLeft;
    [WuJieBackImg addSubview:WuJieLab];
    WuJieLab.sd_layout.leftSpaceToView(WuJieBackImg,68).topSpaceToView(WuJieBackImg,8).widthIs(80).heightIs(25);
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 105 - 60, KscreenWidth, KscreenHeight - 155) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:table];
    
//    CurType = @"RB0";
//    CurStatus = @"9";
//    StartTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"000000"];
//    EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
//    CurPage = @"0";
    //快捷订单记录
    //[self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
    //列表数组
    ModelArray = [[NSMutableArray alloc] init];
    __weak OrderListViewController *weakSelf = self;
    headerView = [table addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        [weakSelf refresh];
    }];
    footView = [table addFooterWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        [weakSelf loadMore];
    }];
 
}
//刷新
- (void)refresh {
    
    [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
    pageIndex = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [headerView endRefresh];
        [table reloadData];
    });//主线程更新UI
}
//加载更多
- (void)loadMore {
    pageIndex += 1;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)pageIndex];
    [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:page];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [footView endRefresh];
    });
}
//无界
- (void)WuJieSelect {
    
    NSLog(@"无界支付");
    [self HideAndAppear:TotalStartView];
    
}

//易宝
- (void)YiBaoSelect {
    NSLog(@"易宝支付");
    [self HideAndAppear:TotalStartView];
}

//订单选择
- (void)OrderSelect {
  
    //[self HideAndAppear:TotalStartView];
    TotalStartView.image = [UIImage imageNamed:@"白灰上.png"];
    UIActionSheet *Action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"卡刷支付",@"无界支付", nil];
    Action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    Action.tag = 104;
    [Action showInView:self.view];
    
}

- (void)HideAndAppear:(UIImageView *)Img {
    
    _index++;
    if (_index%2 == 1) {
        [UIView animateWithDuration:1 animations:^{
            OrderListView.hidden = NO;
            AllTypeImg.userInteractionEnabled = NO;
            AllStatusImg.userInteractionEnabled = NO;
            TimeImg.userInteractionEnabled = NO;
            Img.image = [UIImage imageNamed:@"白灰上.png"];
        } completion:^(BOOL finished) {
           
        }];
        
    }else {
        [UIView animateWithDuration:1 animations:^{
            OrderListView.hidden = YES;
            AllTypeImg.userInteractionEnabled = YES;
            AllStatusImg.userInteractionEnabled = YES;
            TimeImg.userInteractionEnabled = YES;
            Img.image = [UIImage imageNamed:@"白灰下.png"];
        } completion:^(BOOL finished) {
            
        }];
    }
}
//选择类型
- (void)TypeSelect {
    StartView.image = [UIImage imageNamed:@"shouhui.png"];
    UIActionSheet *Action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"快捷收款",@"普通收款", nil];
    Action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    Action.tag = 101;
    [Action showInView:self.view];
}
//选择状态
- (void)StatusSelect {
    
    StatusStartView.image = [UIImage imageNamed:@"shouhui.png"];
    UIActionSheet *Action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部状态",@"已完成",@"审核中",@"交易失败", nil];
    Action.tag = 102;
    [Action showInView:self.view];
}
//时间选择
- (void)TimeSelect {
    
    TimeStartView.image = [UIImage imageNamed:@"shouhui.png"];
    UIActionSheet *Action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"今天",@"昨天",@"最近一周",@"最近一个月",@"最近三个月", nil];
    Action.tag = 103;
    [Action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 101) {
        StartView.image = [UIImage imageNamed:@"xiala.png"];
        if ( buttonIndex == 0) {
            AllTypeLab.text = @"快捷收款";
            if ([OrderLab.text isEqualToString:@"卡刷支付"]) {
                CurType = @"HST0";
            }else {
                CurType = @"RB0";
            }
        }
        else {
            AllTypeLab.text = @"普通收款";
            if ([OrderLab.text isEqualToString:@"卡刷支付"]) {
                CurType = @"AN1";
            }else {
                CurType = @"RB1";
            }
        }
        [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
    }
    if (actionSheet.tag == 102) {
        StatusStartView.image = [UIImage imageNamed:@"xiala.png"];
        if ( buttonIndex == 0) {
            AllStatusLab.text = @"全部状态";
            CurStatus = @"9";
        }
        else if (buttonIndex == 1) {
            AllStatusLab.text = @"已完成";
            CurStatus = @"1";
        }else if (buttonIndex == 2) {
            AllStatusLab.text = @"审核中";
            CurStatus = @"3";
        } else if (buttonIndex == 3){
            AllStatusLab.text = @"交易失败";
            CurStatus = @"2";
        }
        
        [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
    }
    if (actionSheet.tag == 103) {
        TimeStartView.image = [UIImage imageNamed:@"xiala.png"];
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval time;
        NSDate *CurDate;
        NSString *CurTime;
        NSString *CurDay;
        if ( buttonIndex == 0) {
            TimeLab.text = @"今天";
            StartTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"000000"];
            EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
        }
        else if (buttonIndex == 1) {
            TimeLab.text = @"昨天";
            time = 24*60*60;
            CurDate = [date dateByAddingTimeInterval:-time];
            CurTime = [dateFormatter stringFromDate:CurDate];
            CurDay = [CurTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            StartTime = [NSString stringWithFormat:@"%@%@",CurDay,@"000000"];
            EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
            
        }else if (buttonIndex == 2) {
            TimeLab.text = @"最近一周";
            time = 7*24*60*60;
            CurDate = [date dateByAddingTimeInterval:-time];
            CurTime = [dateFormatter stringFromDate:CurDate];
            CurDay = [CurTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            StartTime = [NSString stringWithFormat:@"%@%@",CurDay,@"000000"];
            EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
        } else if (buttonIndex == 3){
            TimeLab.text = @"最近一个月";
            time = 30*24*60*60;
            CurDate = [date dateByAddingTimeInterval:-time];
            CurTime = [dateFormatter stringFromDate:CurDate];
            CurDay = [CurTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            StartTime = [NSString stringWithFormat:@"%@%@",CurDay,@"000000"];
            EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
        } else if (buttonIndex == 4){
            TimeLab.text = @"最近三个月";
            time = 3*30*24*60*60;
            CurDate = [date dateByAddingTimeInterval:-time];
            CurTime = [dateFormatter stringFromDate:CurDate];
            CurDay = [CurTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            StartTime = [NSString stringWithFormat:@"%@%@",CurDay,@"000000"];
            EndTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
        }
    
        [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
        
    }
    if (actionSheet.tag == 104) {
        TotalStartView.image = [UIImage imageNamed:@"白灰下.png"];
        if (buttonIndex == 0) {
            OrderLab.text = @"卡刷支付";
             //CurType = @"UP0";
            
            if ([AllTypeLab.text isEqualToString:@"普通收款"]) {
                CurType = @"AN1";
            }else {
                CurType = @"HST0";
            }
        }
        if (buttonIndex == 1) {
            OrderLab.text = @"无界支付";
            if ([AllTypeLab.text isEqualToString:@"普通收款"]) {
                CurType = @"RB1";
            }else {
                CurType = @"RB0";
            }
        }
        //TotalStartView.image = [UIImage imageNamed:@"xiala.png"];
        [self RequestForOrderList:CurType Status:CurStatus orderNo:@"" ts:StartTime te:EndTime page:CurPage];
    }
}
//
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSLog(@"消失******");
}

- (void)RequestForOrderList:(NSString *)Type Status:(NSString *)status orderNo:(NSString *)orderNo ts:(NSString *)ts te:(NSString *)te page:(NSString *)page {
    
    //[SVProgressHUD show];
//    NSString *url = BaseUrl;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    NSString *key = [user objectForKey:@"key"];
//    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",Type,status,orderNo,ts,te,page,key];
//    NSString *sign = [self md5HexDigest:md5];
//    NSDictionary *dic1 = @{
//                           @"type":Type,
//                           @"status":status,
//                           @"orderNo":orderNo,
//                           @"ts":ts,
//                           @"te":te,
//                           @"page":page,
//                           @"token":token,
//                           @"sign":sign
//                           };
//    NSDictionary *dicc = @{
//                           @"action":@"OrderList",
//                           @"data":dic1
//                           };
//    NSString *params = [dicc JSONFragment];
//    NSLog(@"参数：%@",params);
//    [IBHttpTool postWithURL:url params:params success:^(id result) {
//        NSDictionary *dicc = [result JSONValue];
//        NSLog(@"订单列表：%@",dicc);
//        NSDictionary *content = dicc[@"content"];
//        
//        NSArray *ListArray = [[NSArray alloc] init];
//        ListArray = content[@"result"];
//        if ([page isEqualToString:@"0"]) {
//            if (ListArray.count == 0) {
//                [self alert:@"暂无数据!"];
//                table.hidden = YES;
//                [SVProgressHUD dismiss];
//                return ;
//            } else {
//                table.hidden = NO;
//            }
//            //先移除所有数据
//            [ModelArray removeAllObjects];
//        }
//        for (NSDictionary *dic in ListArray) {
//            OrderModel *model = [[OrderModel alloc] init];
//            model.orderNo = dic[@"orderNo"];
//            model.orderReqTime = dic[@"orderReqTime"];
//            model.orderStatus = dic[@"orderStatusName"];
//            model.amount = dic[@"amount"];
//            model.orderType = dic[@"orderType"];
//            model.channelType = dic[@"channelType"];
//            [ModelArray addObject:model];
//        }
//        [table reloadData];
//        //[SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        NSLog(@"网络申请失败:%@",error);
//        //[SVProgressHUD dismiss];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 63;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[OrderListCell alloc] init];
        self.model = ModelArray[indexPath.row];
        //cell.TypeLab.text = self.model.orderType;
        cell.TypeLab.text = self.model.channelType;
        cell.KindLab.text = self.model.orderType;
        cell.TimeLab.text = self.model.orderReqTime;
        cell.MoneyLab.text = self.model.amount;
        cell.StatusLab.text = self.model.orderStatus;
    }
    return cell;
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
    NSString *dateStr = [dateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateStr;
}

@end
