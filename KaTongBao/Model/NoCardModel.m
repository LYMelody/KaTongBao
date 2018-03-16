//
//  NoCardModel.m
//  JingXuan
//
//  Created by wj on 16/5/27.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "NoCardModel.h"

@implementation NoCardModel
- (void)initWithDic:(NSDictionary *)dic {
    if (self) {
        if (dic) {
            _array = [NSMutableArray arrayWithCapacity:0];
            NoCardModel *noCardModel = [[NoCardModel alloc] init];
//            for (int i = 0; i<[dic[@"cardList"] count]; i++) {
//                noCardModel.cardBank = dic[@"cardList"][i][@"cardBank"];
//                noCardModel.cardCert = dic[@"cardList"][i][@"cardCert"];
//                noCardModel.cardCvv = dic[@"cardList"][i][@"cardCvv"];
//                noCardModel.cardNo = dic[@"cardList"][i][@"cardNo"];
//                noCardModel.cardType = dic[@"cardList"][i][@"cardType"];
//                noCardModel.cardYxq = dic[@"cardList"][i][@"cardYxq"];
//                noCardModel.name = dic[@"cardList"][i][@"name"];
//                [_array addObject:noCardModel];
//            }
            
//            noCardModel.amount = dic[@"amount"];
//
//            noCardModel.orderTime = dic[@"orderTime"];
//            noCardModel.orderNo = dic[@"orderNo"];
//            [_array addObject:noCardModel];
            
//            ShortcutViewController *shortcutVC = [[ShortcutViewController alloc] init];
//            shortcutVC.dataArray = noCardModel.array;
//            
//            NSLog(@"+++%@",shortcutVC.dataArray);
        }
    }
    
}

@end