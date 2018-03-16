//
//  JXMainViewController.h
//  JingXuan
//
//  Created by rongfeng on 16/6/1.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXMainViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)UICollectionView *collectionView;

@end
