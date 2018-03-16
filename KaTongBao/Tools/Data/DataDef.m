//
//  DataDef.m
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import "DataDef.h"

@implementation DataDef

@end

@implementation OrderInfo

@synthesize OrderName, OrderNo, OrderDesc, OrderTime, OrderDetail, OrderCode, OrderID, StateName;
@synthesize BankCardNo, BankCardType, BankName, BankVerify, BankCvv;
@synthesize UserName, UserNbr, UserPhone, UserID;
@synthesize OrderAmt, OrderFee, OrderAmtAll;
@synthesize OrderStatus, OrderStatusName, OrderType, State;
@synthesize GoodsID;

@synthesize accountname, accountnbr;
@synthesize merchantid, params;

- (id)init
{
    self = [super init];
    if (self)
    {
        OrderName = @"";
        OrderNo = @"";
        OrderDesc = @"";
        OrderTime = @"";
        OrderDetail = @"";
        OrderCode = @"";
        OrderID = @"";
        StateName = @"";
        BankCardNo = @"";
        BankCardType = @"";
        BankName = @"";
        BankVerify = @"";
        BankCvv = @"";
        UserName = @"";
        UserNbr = @"";
        UserPhone = @"";
        UserID = @"";
        OrderStatusName = @"";
        State = @"";
        GoodsID = @"";
        
        accountname = @"";
        accountnbr  = @"";
        
        merchantid = @"";
        params = @"";

    }
    return self;
}

- (void)dealloc
{
    [OrderName release];
    [OrderNo release];
    [OrderDesc release];
    [OrderTime release];
    [OrderDetail release];
    [OrderCode release];
    [OrderID release];
    [StateName release];
    [BankCardNo release];
    [BankCardType release];
    [BankName release];
    [BankVerify release];
    [BankCvv release];
    [UserName release];
    [UserNbr release];
    [UserPhone release];
    [UserID release];
    [GoodsID release];
    
    [accountname release];
    [accountnbr release];
    
    [merchantid release];
    [params release];
    
    self.OrderStatusName = nil;
    self.State = nil;
    [super dealloc];
    
}

+ (void)copy:(OrderInfo*)from to:(OrderInfo*)to
{
    to.OrderName = from.OrderName;
    to.OrderNo = from.OrderNo;
    to.OrderDesc = from.OrderDesc;
    to.OrderTime = from.OrderTime;
    to.OrderDetail = from.OrderDetail;
    to.OrderCode = from.OrderCode;
    to.OrderID = from.OrderID;
    to.StateName = from.StateName;
    to.BankCardNo = from.BankCardNo;
    to.BankCardType = from.BankCardType;
    to.BankName = from.BankName;
    to.BankVerify = from.BankVerify;
    to.BankCvv = from.BankCvv;
    to.UserName = from.UserName;
    to.UserNbr = from.UserNbr;
    to.UserPhone = from.UserPhone;
    to.UserID = from.UserID;
    to.OrderAmt = from.OrderAmt;
    to.OrderFee = from.OrderFee;
    to.OrderAmtAll = from.OrderAmtAll;
    to.OrderStatus = from.OrderStatus;
    to.OrderStatusName = from.OrderStatusName;
    to.OrderType = from.OrderType;
    to.State = from.State;
    to.GoodsID = from.GoodsID;
    
    to.accountname = from.accountname;
    to.accountnbr = from.accountnbr;
    
    to.merchantid = from.merchantid;
    to.params = from.params;
}

- (void)newOrder
{    
    self.OrderName = @"";
    self.OrderNo = @"";
    self.OrderDesc = @"";
    self.OrderTime = @"";
    self.OrderDetail = @"";
    self.OrderCode = @"";
    self.OrderID = @"";
    self.StateName = @"";
    self.BankCardNo = @"";
    self.BankCardType = @"";
    self.BankName = @"";
    self.BankVerify = @"";
    self.BankCvv = @"";
    self.UserName = @"";
    self.UserNbr = @"";
    self.UserPhone = @"";
    self.UserID = @"";
    self.OrderStatusName = @"";
    self.State = @"";
    self.GoodsID = @"";
    
    self.accountnbr = @"";
    self.accountname = @"";
    
    self.merchantid = @"";
    self.params = @"";
    
}
@end

@implementation UserInfo

@synthesize UserName, Pwd, Mobile, StartDate, State;
@synthesize RemPwd, IsError;
@synthesize ShopID, ShopCode, ShopName;
@synthesize UpdateFlag;

- (id)init
{
    self = [super init];
    if (self)
    {
        UserName = @"";
        Pwd = @"";
        Mobile = @"";
        StartDate = @"";
        ShopID = @"";
        ShopCode = @"";
        ShopName = @"";
        State = @"";
        IsError = NO;
        UpdateFlag=@"";
    }
    return self;
}

- (void)dealloc
{
    [UserName release];
    [Pwd release];
    [Mobile release];
    [StartDate release];
    [ShopID release];
    [ShopCode release];
    [ShopName release];
    [State release];
    [UpdateFlag release];
    [super dealloc];
    
}

@end

@implementation UserDetailInfo

@synthesize ShopID, ShopName, RegPhone;
@synthesize OrgId, OrgName;
@synthesize OtherAmount, Amount;

- (id)init
{
    self = [super init];
    if (self)
    {
        
        RegPhone = @"";
        ShopID = @"";
        ShopName = @"";
        
        OrgId = @"";
        OrgName = @"";
        
        OtherAmount = @"";
        Amount = @"";
        
    }
    return self;
}

- (void)dealloc
{
    [RegPhone release];
    [ShopID release];
    [ShopName release];
    [OrgId release];
    [OrgName release];
    [OtherAmount release];
    [Amount release];
    
    [super dealloc];
    
}

+ (void)copy:(UserDetailInfo*)from to:(UserDetailInfo*)to {
    
    to.RegPhone = from.RegPhone;
    to.ShopID = from.ShopID;
    to.ShopName = from.ShopName;
    to.OrgId = from.OrgId;
    to.OrgName = from.OrgName;
    to.Amount = from.Amount;
    to.OtherAmount = from.OtherAmount;
    
}

- (void)newUserDetail {
    
    self.RegPhone = @"";
    self.ShopID = @"";
    self.ShopName = @"";
    self.OrgId = @"";
    self.OrgName = @"";
    self.OtherAmount = @"";
    self.Amount = @"";
    
}

@end