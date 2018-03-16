//
//  SelectCityVC.h
//  wujieNew
//
//  Created by rongfeng on 16/1/12.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *CityArray;
@end
