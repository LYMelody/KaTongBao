//
//  JXMainViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/1.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXMainViewController.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "JXCashMeathodViewController.h"
#import "BusiIntf.h"
#import "Common.h"
#import "KTBWalletViewController.h"
//#import <GFDPlugin/GFDPlugin.h>
@interface JXMainViewController ()

@end

@implementation JXMainViewController {
    UILabel *label;
    UIAlertView *alertView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置返回按钮字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    if (label!= nil) {
        [self moveLable:label];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 64)];
    //bgView.backgroundColor = kCustomColor(240, 240, 240);
    bgView.backgroundColor = NavBack;
    [self.view addSubview:bgView];
    [bgView bringSubviewToFront:self.view];
    
    //中间
    UILabel *lableText = [[UILabel alloc]initWithFrame:CGRectZero];
    lableText.text = @"";
    
    UIImageView *HeadimageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    HeadimageView.image = [UIImage imageNamed:@"登录页-logo.png"];
    HeadimageView.bounds = CGRectMake(0, 0, 100, 35);
    HeadimageView.center = CGPointMake(bgView.center.x, bgView.center.y + 10);

    [bgView addSubview:lableText];
    [bgView addSubview:HeadimageView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:imageView];
    imageView.sd_layout.topSpaceToView(self.view,64).widthIs(KscreenWidth).heightRatioToView(self.view,0.25);
    
    if (![[BusiIntf curPayOrder].Notice isEqualToString:@""]) {
        
        alertView = [[UIAlertView alloc] initWithTitle:nil message:[BusiIntf curPayOrder].Notice delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        UIImageView *NoticeImg = [[UIImageView alloc] init];
        NoticeImg.backgroundColor = [UIColor clearColor];
        NoticeImg.userInteractionEnabled = YES;
        [self.view addSubview:NoticeImg];
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMsg)];
        Tap.numberOfTapsRequired = 1;
        [NoticeImg addGestureRecognizer:Tap];
        
        NoticeImg.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(imageView,0).widthIs(KscreenWidth).heightIs(20);
        label = [[UILabel alloc] init];
        label.text = [BusiIntf curPayOrder].Notice;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = LightBlue;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [NoticeImg addSubview:label];
        label.sd_layout.leftSpaceToView(NoticeImg,0).topSpaceToView(NoticeImg,1).widthIs(800).heightIs(20);
        [self moveLable:label];
        
    }else {
        
    }

    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 220 , KscreenWidth, 300) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.sd_layout.topSpaceToView(imageView,30).xIs(0).widthIs(KscreenWidth).heightIs(400);
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
}
//滚动文字
- (void) moveLable : (UILabel *)lb {
    CGRect lbFrame = lb.frame;
    lbFrame.origin.x = 320;
    lb.frame = lbFrame;
    
    [UIView beginAnimations:@"test" context:NULL];
    [UIView setAnimationDuration:20.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    lbFrame.origin.x = -800 - 300;
    lb.frame = lbFrame;
    [UIView commitAnimations];
    
}
- (void)showMsg {
    [alertView show];
}
#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *array = [NSArray arrayWithObjects:@"收款",@"余额查询",@"还款",@"转账",@"机票",@"火车票",@"生活缴费",@"手机充值",@"休闲",@"罚款",@"银企联名卡",@"更多", nil];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Item, Item)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",array[indexPath.row]]];
    
    [cell addSubview:imageView];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(Item, Item);
}
//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) { //收款
        JXCashMeathodViewController *gatheringVC = [[JXCashMeathodViewController alloc] init];
        [self.navigationController pushViewController:gatheringVC animated:YES];
        
    }else if (indexPath.row == 1) {  //钱包
        KTBWalletViewController *KTBWalletVc = [[KTBWalletViewController alloc] init];
        [self.navigationController pushViewController:KTBWalletVc animated:YES];
    }
    else if(indexPath.row == 2){ //功夫贷
        //[[GFDPlugin sharedInstance] showOnNavigateController:self.navigationController phone:[BusiIntf getUserInfo].UserName];
    }else {
        [AlertView(@"正在建设...", @"确认") show];
    }
    
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
