//
//  TwoDBarCodePayViewController.h
//  KaTongBao
//
//  Created by rongfeng on 16/7/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoDBarCodePayViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UIActionSheetDelegate,UIAlertViewDelegate>



@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *orderTime;
@property(nonatomic,strong)NSString *codeImgUrl;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,assign)NSInteger tag;
@end
