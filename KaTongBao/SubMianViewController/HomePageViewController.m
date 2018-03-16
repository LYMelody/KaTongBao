//
//  HomePageViewController.m
//  JingXuan
//
//  Created by wj on 16/5/11.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "HomePageViewController.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "GatheringViewController.h"
@interface HomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)UICollectionView *collectionView;

@end

@implementation HomePageViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabBarController.tabBar.hidden = NO;
    //设置返回按钮字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBaseVCAttributes:@"JX1.png" withLeftName:nil withRightName:nil withColor:NavBack];
    //自定义返回按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
    right.title = @"返回";
    self.navigationItem.backBarButtonItem = right;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:imageView];
    imageView.sd_layout.topSpaceToView(self.view,64).widthIs(KscreenWidth).heightRatioToView(self.view,0.25);
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 220, KscreenWidth, 300) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
        self.collectionView.sd_layout.topSpaceToView(imageView,10).xIs(0).widthIs(KscreenWidth).heightIs(400);

    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
}
- (void)viewDidAppear:(BOOL)animated{
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
    NSArray *array = [NSArray arrayWithObjects:@"收款",@"查询",@"还款",@"转账",@"机票",@"火车票",@"生活",@"手机充值",@"休闲",@"罚款",@"银企联盟",@"更多", nil];
    
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
    if (indexPath.item == 0) {
        GatheringViewController *gatheringVC = [[GatheringViewController alloc] init];
        [self.navigationController pushViewController:gatheringVC animated:YES];
        
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
