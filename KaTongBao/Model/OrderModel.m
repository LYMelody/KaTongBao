//
//  OrderModel.m
//  JingXuan
//
//  Created by wj on 16/5/26.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
- (void)initWithDic:(NSDictionary *)dic {
    if (self) {
        if (dic) {
           for (int i = 0; i < [dic[@"content"] count]; i++) {
                _amount = dic[@"content"][i][@"amount"];
                _orderNo = dic[@"content"][i][@"orderNo"];
                _orderReqTime = dic[@"content"][i][@"orderReqTime"];
                _orderStatus = dic[@"content"][i][@"orderStatus"];
                _orderType = dic[@"content"][i][@"orderType"];
                _payBankName = dic[@"content"][i][@"payBankName"];
                _payBankNo = dic[@"content"][i][@"payBankNo"];
            
               
//               NSDictionary *dataDic = dic[@"content"][i];
//               NSLog(@"%@",dic);
               
        }
        }
    }
    
}

@end
