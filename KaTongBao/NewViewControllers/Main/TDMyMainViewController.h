//
//  TDMyMainViewController.h
//  POS
//
//  Created by rongfeng on 15/12/10.
//  Copyright © 2015年 TangDi. All rights reserved.
//

//#import "CJBaseViewController.h"
#import "SDCycleScrollView.h"
#import <UIKit/UIKit.h>
#import "CNPPopupController.h"
@interface TDMyMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SDCycleScrollViewDelegate,CNPPopupControllerDelegate>

@property (strong, nonatomic) UIScrollView   *imageScrollview;
@property (strong, nonatomic) UIPageControl  *imagePage;
@property (nonatomic, strong) CNPPopupController *popupController;
@end
