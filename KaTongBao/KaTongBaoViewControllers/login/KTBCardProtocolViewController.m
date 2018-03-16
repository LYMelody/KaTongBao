//
//  KTBCardProtocolViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/9/13.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBCardProtocolViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"

#define ServiceProtocol @"             信用卡申请补充服务条款 \r\
1.该信用卡办理业务只向本APP注册会员用户开放，仅限本人使用\r\
2.该申请仅限于办理兴业银行联名信用卡，不包括兴业银行其他信用卡种;\r\
3.该信用卡申请为本APP注册会员增值服务，不收取任何其他费用;\r\
4.本APP只负责用户申请资料的提交及跟踪，对资料的真实性及有效性不予核对，所有责任由申请人自行承担;\r\
5.本APP只负责用户申请资料的提交及跟踪，最终由银行相关部门进行审核，本APP不对审核结果及其相关附属权益进行担保;\r\
6.本APP将严格保守用户的个人隐私，承诺未经过您的同意不将您的个人信息任意披露;\r\
7.其余相关服务条款请参见《卡捷通APP服务条款》;\r\
8.申请人使用本服务前请详细阅读以上条款，继续使用视为申请人充分理解并接受上述所有条款;\r\
9.由于申请人的疏忽，理解偏差而导致的损失，本公司不承担任何责任。"
//10：申请人如未成功申请信用卡或申请的信用卡额度小于8000元，本APP会于第30日将缴纳的VIP会员费自动退款至您的结算银行卡；"


@implementation KTBCardProtocolViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    if (self.tag == 1) {
        self.title = @"权益详情";
    }else {
        self.title = @"服务条款声明";
    }
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
    
    //[self RequestForCustomerInfo];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:12],
                                   NSForegroundColorAttributeName:[UIColor blackColor],
                                   NSKernAttributeName:@2,
                                   NSParagraphStyleAttributeName:paragraph
                                   };
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"JX摄影" ofType:@"txt"];
    NSString * pathString = [NSString stringWithContentsOfFile:path encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:nil];
    if (nil ==  pathString ||pathString.length <= 0) {
        pathString = [NSString stringWithContentsOfFile:path encoding:4 error:nil];
    }
    
    CGSize contentSize = [ServiceProtocol boundingRectWithSize:CGSizeMake(KscreenWidth - 40, KscreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:ServiceProtocol attributes:attributeDic];
    //[attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(385, 65)];
    
    UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    ScrollView.contentSize = CGSizeMake(KscreenWidth, KscreenHeight + 50 + 50);
    [self.view addSubview:ScrollView];
    
    if (self.tag == 1) {
        ScrollView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
        contentSize = [pathString boundingRectWithSize:CGSizeMake(KscreenWidth - 40, KscreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size;
        
        attributeStr = [[NSMutableAttributedString alloc] initWithString:pathString attributes:attributeDic];
        
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(10, 12)];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(23, 7)];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(107, 5)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(148, 29)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(288, 10)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(410, 11)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(605, 9)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(619, 9)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(719, 9)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(792, 9)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(850, 7)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(898, 7)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(992, 7)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(1359, 8)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(1435, 11)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(1501, 9)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(1586, 11)];
//        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(1634, 10)];
        ScrollView.contentSize = CGSizeMake(KscreenWidth, contentSize.height + 100);
    }else {
        
    }
    
    UILabel *TextLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 15, KscreenWidth - 32, 0)];
    TextLab.numberOfLines = 0;
    TextLab.userInteractionEnabled = YES;
    TextLab.attributedText = attributeStr;
    TextLab.lineBreakMode = NSLineBreakByWordWrapping;
    [TextLab sizeToFit];
    [ScrollView addSubview:TextLab];
    
    NSLog(@"高度:%f",contentSize.height);
    //TextLab.sd_layout.leftSpaceToView(ScrollView,16).rightSpaceToView(ScrollView,16).topSpaceToView(ScrollView,15).heightIs(contentSize.height + 10);
    //[TextLab sizeToFit];
    ScrollView.contentSize = CGSizeMake(KscreenWidth, TextLab.bounds.size.height + 64);
}




@end
