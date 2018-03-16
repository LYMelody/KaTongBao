//
//  DataDef.h
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GoodsID_Pay @"1"
#define GoodsID_Buy @"2"
#define GoodsID_CASH @"10"

#define GoodsID_CASH1 @"100"

#define GoodsID_Credit  @"5"
#define GoodsID_Trans   @"4"
#define GoodsID_Phone   @"3"

#define GoodsID_Shopurl @"8"

#define GoodsID_YB  @"17"
#define GoodsID_SHOP @"18"
#define GoodsID_SER @"19"

@interface DataDef : NSObject

@end

@interface OrderInfo : NSObject
{
    NSString *OrderName, *OrderNo, *OrderDesc, *OrderTime, *OrderDetail, *OrderCode, *OrderID, *StateName,*TypeOrder,*OrderAmount,*OrderSettleBalance,*SettleNo,*Free,*rateFee,*content,*refund,*amount,*receive;
    NSString *BankCardNo, *BankCardType, *BankName, *BankVerify, *BankCvv,*BankIsSelf;
    NSString *UserName, *UserNbr, *UserPhone, *UserID;
    double OrderAmt, OrderFee, OrderAmtAll;
    NSInteger OrderStatus;
    NSInteger OrderType;
    NSString *OrderStatusName, *State;
    NSString *GoodsID;
    NSString *accountname, *accountnbr;
    NSString *merchantid, *params;

    NSString *CurType;
    NSString *CurStatus;
    NSString *StartTime;
    NSString *EndTime;
    NSString *CurPage;
    NSString *cityName;
    NSString *ProName;
    
    NSString *bankAccont,*bankName2,*bankNumber,*city,*httpPath1,*httpPath2,*httpPath3,*httpPath4,*isBank,*isBase,*isOrg,*prov,*selfStatus,*shopCard,*shopName,*shopStatus,*shortName,*isRealName,*orgCode;
    NSString *AddBankName,*AddBankNumber,*GoodsName,*showMsg,*cardPhone,*action,*Notice,*nocardOrderMin,*nocardOrderMax,*nocardOrderStart,*nocardOrderEnd,*nocardMcgMin,*nocardMcgMax,*nocardMcgStart,*nocardMcgEnd;
    
    
}

@property(copy) NSString *OrderName, *OrderNo, *OrderDesc, *OrderTime, *OrderDetail, *OrderCode, *OrderID, *StateName,*TypeOrder,*OrderAmount,*OrderSettleBalance,*SettleNo,*Free,*rateFee,*content,*refund,*amount,*receive;
@property(copy) NSString *BankCardNo, *BankCardType, *BankName, *BankVerify, *BankCvv,*BankIsSelf;
@property(copy) NSString *UserName, *UserNbr, *UserPhone, *UserID;
@property(assign) double OrderAmt, OrderFee, OrderAmtAll;
@property(assign) NSInteger OrderStatus, OrderType;
@property(copy) NSString *OrderStatusName, *State;
@property(copy) NSString *GoodsID;
@property(copy) NSString *accountname, *accountnbr;
@property(copy) NSString *merchantid, *params;
@property(copy) NSString *cityName;
@property(copy) NSString *Location;
@property(copy) NSString *ProName;
@property(copy) NSString *imgUrl;
@property(copy) NSString *imgUrlBack;
@property(copy) NSString *bankname;
@property(copy) NSString *CurType,*CurStatus,*StartTime,*EndTime,*CurPage;
@property(copy) NSString *bankAccont,*bankName2,*bankNumber,*city,*httpPath1,*httpPath2,*httpPath3,*httpPath4,*isBank,*isBase,*isOrg,*prov,*selfStatus,*shopCard,*shopName,*shopStatus,*shortName,*isRealName,*orgCode,*isEdit;
@property(copy) NSString *AddBankName,*AddBankNumber,*GoodsName,*showMsg,*cardPhone,*action,*Notice,*nocardOrderMin,*nocardOrderMax,*nocardOrderStart,*nocardOrderEnd,*nocardMcgMin,*nocardMcgMax,*nocardMcgStart,*nocardMcgEnd,*T0,*T0Mcg,*T0Tip,*T1,*T1Mcg,*T1Tip,*NoticeFlg;
@property(copy) NSString *SubBankName,*BankCode;
@property(copy) NSString *IsGetCardVip,*IsGetSafeVip,*CardVIPIcon,*SafeVIPIcon,*CardVIPTitle,*SafeVIPTitle,*CardVIPDetail,*SafeVIPDetail,*IsVip,*VipPrice;
@property(assign) BOOL IsAPPStore;
+ (void)copy:(OrderInfo*)from to:(OrderInfo*)to;
- (void)newOrder;

@end

@interface UserInfo : NSObject
{
    NSString *UserName, *Pwd, *StartDate, *State;
    NSString *ShopID, *ShopCode, *ShopName, *Mobile;
    BOOL RemPwd, IsError;
    
    NSString *UpdateFlag;
}

@property(copy) NSString *UserName, *Pwd, *StartDate, *State;
@property(copy) NSString *ShopID, *ShopCode, *ShopName, *Mobile;
@property(assign) BOOL RemPwd, IsError;

@property(copy) NSString *UpdateFlag;

@end

@interface UserDetailInfo : NSObject
{
    NSString *ShopID, *ShopName, *RegPhone;
    NSString *OrgId, *OrgName;
    NSString *OtherAmount, *Amount;
    
}

@property(copy) NSString *ShopID, *ShopName, *RegPhone;
@property(copy) NSString *OrgId, *OrgName;
@property(copy) NSString *OtherAmount, *Amount;

+ (void)copy:(UserDetailInfo*)from to:(UserDetailInfo*)to;
- (void)newUserDetail;

@end


