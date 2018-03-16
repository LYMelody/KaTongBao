//
//  BusiIntf+NetInfo.m
//  Kuaifu
//
//  Created by yangmx on 13-1-12.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#import "BusiIntf.h"
#import "DataDef.h"
#import "NetIntf.h"

@implementation BusiIntf(NetInfo)

+ (BOOL)getErrorMsg:(NSInteger)code errmsg:(NSString**)errmsg defmsg:(NSString*)defmsg
{
    BOOL isSucc = NO;
    if ([*errmsg isEqualToString:@""])
        *errmsg = defmsg;
    switch (code) {
        case 2:
            *errmsg = @"请求超时";
            break;
        case 502:
            *errmsg = @"由于目标机器积极拒绝，无法连接。";
            break;
            
            //业务码
        case 3001:
            *errmsg = @"请持卡人与发卡银行联系";
            break;
        case 3003:
            *errmsg = @"无效商户";
            break;
        case 3004:
            *errmsg = @"此卡被没收";
            break;
        case 3005:
            *errmsg = @"持卡人认证失败";
            break;
        case 3010:
            *errmsg = @"显示部分批准金额，提示操作员";
            break;
        case 3011:            
            *errmsg = @"成功，VIP客户";
            isSucc = YES;
            break;
        case 3012:
            *errmsg = @"无效交易";
            break;
        case 3013:
            *errmsg = @"无效金额";
            break;
        case 3014:
            *errmsg = @"无效卡号";
            break;
        case 3015:
            *errmsg = @"此卡无对应发卡方";
            break;
        case 3021:
            *errmsg = @"该卡未初始化或睡眠卡";
            break;
        case 3022:
            *errmsg = @"操作有误，或超出交易允许天数";
            break;
        case 3025:
            *errmsg = @"没有原始交易，请联系发卡方";
            break;
        case 3030:
            *errmsg = @"请重试";
            break;
        case 3034:
            *errmsg = @"作弊卡,呑卡";
            break;
        case 3038:
            *errmsg = @"密码错误次数超限，请与发卡方联系";
            break;
        case 3040:
            *errmsg = @"发卡方不支持的交易类型";
            break;
        case 3041:
            *errmsg = @"挂失卡，请没收（POS";
            break;
        case 3043:
            *errmsg = @"被窃卡，请没收";
            break;
        case 3051:
            *errmsg = @"可用余额不足";
            break;
        case 3054:
            *errmsg = @"该卡已过期";
            break;
        case 3055:
            *errmsg = @"密码错";
            break;
        case 3057:
            *errmsg = @"不允许此卡交易";
            break;
        case 3058:
            *errmsg = @"发卡方不允许该卡在本终端进行此交易";
            break;
        case 3059:
            *errmsg = @"卡片校验错";
            break;
        case 3061:
            *errmsg = @"交易金额超限";
            break;
        case 3062:
            *errmsg = @"受限制的卡";
            break;
        case 3064:
            *errmsg = @"交易金额与原交易不匹配";
            break;
        case 3065:
            *errmsg = @"超出消费次数限制";
            break;
        case 3068:
            *errmsg = @"交易超时，请重试";
            break;
        case 3075:
            *errmsg = @"密码错误次数超限";
            break;
        case 3090:
            *errmsg = @"系统日切，请稍后重试";
            break;
        case 3091:
            *errmsg = @"发卡方状态不正常，请稍后重试";
            break;
        case 3092:
            *errmsg = @"发卡方线路异常，请稍后重试";
            break;
        case 3094:
            *errmsg = @"拒绝，重复交易，请稍后重试";
            break;
        case 3096:
            *errmsg = @"拒绝，交换中心异常，请稍后重试";
            break;
        case 3097:
            *errmsg = @"终端未登记";
            break;
        case 3098:
            *errmsg = @"发卡方超时";
            break;
        case 3099:
            *errmsg = @"PIN格式错，请重新签到";
            break;
        case 3100:
            *errmsg = @"MAC校验错，请重新签到";
            break;
        case 3101:
            *errmsg = @"转账货币不一致";
            break;
        case 3102:
        case 3104:
        case 3105:
        case 3106:
            *errmsg = @"交易成功，请向发卡行确认";
            isSucc = YES;
            break;
        case 3103:
            *errmsg = @"账户不正确";
            break;
        case 3107:
            *errmsg = @"拒绝，交换中心异常，请稍后重试";
            break;
        default:
            break;
    }
    return isSucc;
}

+ (BOOL)doSetPwd: (NSString*)mobile newpwd:(NSString*)newpwd verify:(NSString*)verify errmsg:(NSString**)errmsg
{
    *errmsg = [[[NSString alloc]init]autorelease];
    *errmsg = @"请输入正确的验证码";
    return YES;
}

+ (BOOL)testNet: (NSString*)json result:(NSString**)result
{
//    int code = [NetIntf readPostData:@"http://192.168.56.177:9000/" json: json result:result ];
    //int code = [NetIntf readPostData:@"http://www.weather.com.cn/data/cityinfo/101200101.html" : @"" : @"" :result ];
    
    return YES;//(code == 200);
}


+ (BOOL)login: (NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf login:username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"登录密码错误，请重新输入！"];
    }
    
    return result;
}

+ (BOOL)login: (NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf login:username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname type:type errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"登录密码错误，请重新输入！"];
    }
    
    return result;
}
//提示更新
+ (BOOL)login: (NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type updateflag:(NSString **)updateflag errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf login:username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname type:type updateflag:updateflag errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"服务器繁忙，请稍后登录"];
    }
    
    return result;
}


+ (BOOL) systeminfo:(NSString*)shopid msgContent:(NSString**)msgContent errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf systeminfo:shopid msgContent:msgContent errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
    
}

+ (BOOL) systeminfo:(NSString*)shopid type: (NSString *)type msgContent:(NSString**)msgContent errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf systeminfo:shopid type:type msgContent:msgContent errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
    
}


+ (BOOL) feedback:(NSString*)shopid feedbackinfo:(NSString*)feedbackinfo errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf feedback:shopid feedbackinfo:feedbackinfo errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
}

+ (BOOL) getordercode: (NSString*)shopid userordercode:(NSString*)userordercode goodsid:(NSString*)goodsid amount:(NSString*)amount orderdesc:(NSString*)orderdesc ordercode:(NSString**)ordercode orderid:(NSString**)orderid errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf getordercode:shopid userordercode:userordercode goodsid:goodsid amount:amount orderdesc:orderdesc ordercode:ordercode orderid:orderid errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
}

+ (BOOL) getordercode: (NSString*)shopid userordercode:(NSString*)userordercode goodsid:(NSString*)goodsid amount:(NSString*)amount orderdesc:(NSString*)orderdesc ordercode:(NSString**)ordercode orderid:(NSString**)orderid type:(NSString *)type errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf getordercode:shopid userordercode:userordercode goodsid:goodsid amount:amount orderdesc:orderdesc ordercode:ordercode orderid:orderid type:type errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
}

+ (BOOL) checkcardinfo: (NSString*)cardnbr userid:(NSString**)userid goodsid:(NSString*)goodsid isreg:(BOOL*)isreg cardbank:(NSString **)cardbank  errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf checkcardinfo:cardnbr userid:userid goodsid:goodsid isreg:isreg cardbank:cardbank errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
}

+ (BOOL) checkcardinfo: (NSString*)cardnbr userid:(NSString**)userid goodsid:(NSString*)goodsid isreg:(BOOL*)isreg cardbank:(NSString **)cardbank ordercode:(NSString*)ordercode errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf checkcardinfo:cardnbr userid:userid goodsid:goodsid isreg:isreg cardbank:cardbank ordercode:ordercode errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
}


+ (BOOL) checkuserinfo: (NSString**)userid username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone bankcardno:(NSString*)bankcardno bankcardtype:(NSString*)bankcardtype bankname:(NSString*)bankname bankverify:(NSString*)bankverify bankcvv:(NSString*)bankcvv bankpwd:(NSString*)bankpwd orderid:(NSString*)orderid goodsid:(NSString*)goodsid errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf checkuserinfo:userid username:username usernbr:usernbr userphone:userphone
                       bankcardno:bankcardno bankcardtype:bankcardtype bankname:bankname bankverify:bankverify
                          bankcvv:bankcvv bankpwd:bankpwd orderid:orderid goodsid:goodsid errmsg:errmsg
            ];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:*errmsg];
    }
    
    return result;
}

+ (BOOL) checkuserinfo: (NSString**)userid username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone bankcardno:(NSString*)bankcardno bankcardtype:(NSString*)bankcardtype bankname:(NSString*)bankname bankverify:(NSString*)bankverify bankcvv:(NSString*)bankcvv bankpwd:(NSString*)bankpwd orderid:(NSString*)orderid goodsid:(NSString*)goodsid ordercode:(NSString*)ordercode errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf checkuserinfo:userid username:username usernbr:usernbr userphone:userphone
                       bankcardno:bankcardno bankcardtype:bankcardtype bankname:bankname bankverify:bankverify
                          bankcvv:bankcvv bankpwd:bankpwd orderid:orderid goodsid:goodsid ordercode:ordercode errmsg:errmsg
            ];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:*errmsg];
    }
    
    return result;
}


+ (BOOL) changepwd:(NSString*)shopid oldpwd:(NSString*)oldpwd userpwd:(NSString*)userpwd errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf changepwd:shopid oldpwd:oldpwd userpwd:userpwd errmsg:errmsg];
    if (code == 200)
    {
        result = YES;
        *errmsg = @"已成功修改密码！";
    }
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"修改密码错误！"];
    }
    
    return result;
    
}

+ (NSInteger) regfirst: (NSString*)regphone username:(NSString*)username userpwd:(NSString*)userpwd shopnbr:(NSString*)shopnbr shopid:(NSString**)shopid errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf regfirst:regphone username:username userpwd:userpwd shopnbr:shopnbr shopid:shopid errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        if (code == 401)
            *errmsg = @"号码已被其他用户注册";
        else if (code == 402)
            *errmsg = @"用户名已存在";
        else
            result = [self getErrorMsg:code errmsg:errmsg defmsg:@"未知错误！"];
    }
    
    return result;
    
}

+ (NSInteger) regcheck: (NSString*)mobile checkcode:(NSString**)checkcode errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf regcheck:mobile checkcode:checkcode errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        if (code == 401)
            *errmsg = @"号码已被其他用户注册";
        else
            result = [self getErrorMsg:code errmsg:errmsg defmsg:@"修改密码错误！"];
    }
    
    return result;
}

+ (NSInteger) shopinput: (NSString*)mobile username:(NSString*)username pwd:(NSString*)pwd errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf shopinput:mobile username:username pwd:pwd errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        if (code == 401)
            *errmsg = @"用户名重复";
        else
            result = [self getErrorMsg:code errmsg:errmsg defmsg:@"修改密码错误！"];
    }
    
    return result;
    
}


+ (NSInteger) shopcheck: (NSString*)phone photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3
               shopname:(NSString*)shopname shopbank:(NSString*)shopbank accountnbr:(NSString*)accountnbr errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf shopcheck:phone photo1:photo1 photo2:photo2 photo3:photo3
                     shopname:shopname shopbank:shopbank accountnbr:accountnbr errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"上传图片失败！"];
    }
    
    return result;
}

+ (NSInteger) regphoto: (NSString*)shopid photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3 photo4:(NSString*)photo4 photo5:(NSString*)photo5 photo6:(NSString*)photo6 errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf regphoto:shopid photo1:photo1 photo2:photo2 photo3:photo3
                      photo4:photo4 photo5:photo5 photo6:photo6 errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"上传图片失败！"];
    }
    
    return result;
}

+ (NSInteger) regphoto: (NSString*)shopid photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3 photo4:(NSString*)photo4 errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf regphoto:shopid photo1:photo1 photo2:photo2 photo3:photo3
                      photo4:photo4 errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"上传图片失败！"];
    }
    
    return result;
}

+ (NSInteger) regshop: (NSString*)shopid shopname:(NSString*)shopname shopbank:(NSString*)shopbank accountnbr:(NSString*)accountnbr accountname:(NSString*)accountname shopkey:(NSString*)shopkey  errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf regshop:shopid shopname:shopname shopbank:shopbank accountnbr:accountnbr
                accountname:accountname shopkey:shopkey errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"注册商户信息失败！"];
    }
    
    return result;
}

+ (NSInteger) regist: (NSString*)shopid errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf regist:shopid errmsg:errmsg];
    if (code == 200)
    {
        *errmsg = @"\
        您已经完成全部商户资料提交，请等待审核结果。\r\n\
        审核通过后，我们将以短信形式通知商户。";
        result = YES;
    }
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"注册信息失败！"];
    }
    
    return result;
    
}

+ (NSInteger) logout: (NSString*)shopid errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf logout:shopid errmsg:errmsg];
    if (code == 200)
    {
        *errmsg = @"";
        result = YES;
    }
    else{
        *errmsg = @"失败";
    }
    
    return result;
}

+ (NSInteger) usercheck: (NSString*)charnbr errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf usercheck:charnbr errmsg:errmsg];
    if (code == 200)
    {
        result = YES;
        *errmsg = @"已认证";
    }
    else{
        if (code == 401)
            *errmsg = @"未认证";
        else
            result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
        
    }
    
    return result;
}

+ (NSInteger) userreg: (NSString*)cardnbr cardtype:(NSString*)cardtype cardbank:(NSString*)cardbank
             username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf userreg:cardnbr cardtype:cardtype cardbank:cardbank
                   username:username usernbr:usernbr userphone:userphone errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger) ordersearch: (NSString*)shopid state:(NSString*)state
                dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf ordersearch:shopid state:state
                      dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger) ydddzf: (NSString*)username begindt:(NSString*)begindt enddt:(NSString*)enddt errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf ydddzf:username begindt:begindt
                     enddt:enddt errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger) ydddzfjlcx: (NSString*)username begindt:(NSString*)begindt enddt:(NSString*)enddt dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf ydddzfjlcx:username begindt:begindt
                         enddt:enddt dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}
+ (BOOL) orderpaycheck: (NSString*)shopid ordercode:(NSString*)ordercode userid:(NSString*)userid goodsid:(NSString*)goodsid amount:(NSString*)amount otheramount:(NSString*)otheramount orderdesc:(NSString*)orderdesc orderid:(NSString**)orderid merchantid:(NSString **)merchantID params: (NSString **)params errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf orderpaycheck:shopid ordercode:ordercode userid:userid goodsid:goodsid amount:amount otheramount:otheramount orderdesc:orderdesc
                          orderid:orderid merchantid:merchantID params: params errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (BOOL) orderpaycheck: (NSString*)shopid ordercode:(NSString*)ordercode userid:(NSString*)userid goodsid:(NSString*)goodsid amount:(NSString*)amount otheramount:(NSString*)otheramount orderdesc:(NSString*)orderdesc orderid:(NSString**)orderid merchantid:(NSString **)merchantID params: (NSString **)params url:(NSString**)url errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf orderpaycheck:shopid ordercode:ordercode userid:userid goodsid:goodsid amount:amount otheramount:otheramount orderdesc:orderdesc
                          orderid:orderid merchantid:merchantID params: params url:url errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}


+ (BOOL) payorder: (NSString*)orderid sms:(NSString*)sms isNeedSecond:(BOOL*)isNeedSecond errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    *isNeedSecond = NO;
    code = [NetIntf payorder:orderid sms:sms errmsg:errmsg];
    if (code == 200)
    {
        result = YES;
        *isNeedSecond = NO;
    }
    else if (code == 2002)
    {
        result = YES;
        *isNeedSecond = YES;
    }
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (BOOL) payordersecond: (NSString*)orderid sms:(NSString*)sms errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf payorder:orderid sms:sms errmsg:errmsg];
    if (code == 200)
    {
        result = YES;
    }
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (BOOL) querypay: (NSString*)shopid goodsid:(NSString*)goodsid begindt:(NSString*)begindt enddt:(NSString*)enddt orderdesc:(NSString*)orderdesc dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    if (![goodsid isEqualToString:GoodsID_CASH] && ![[BusiIntf curPayOrder].GoodsID isEqual: GoodsID_CASH1])
        code = [NetIntf querypay:shopid goodsid:goodsid begindt:begindt enddt:enddt orderdesc:orderdesc dataArray:dataArray errmsg:errmsg];
    else
        code = [NetIntf qxordersearch:shopid goodsid:goodsid begindt:begindt enddt:enddt dataArray:dataArray errmsg:errmsg];
        
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger) querypaybyid: (NSString*)ordercode goodsid:(NSString*)goodsid dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf querypaybyid:ordercode goodsid:goodsid dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

//photo6
+ (NSInteger) querypaybyid: (NSString*)ordercode goodsid:(NSString*)goodsid dataArray:(NSMutableArray*)dataArray uploadflag:(NSString **)uploadflag errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf querypaybyid:ordercode goodsid:goodsid dataArray:dataArray uploadflag:uploadflag errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)xykhz:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString**)amount errmsg:(NSString**)errmsg
{    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf xykhz:shopid goodsid:goodsid amount:amount errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)xykhz:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString**)amount otheramount: (NSString **)otheramount errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf xykhz:shopid goodsid:goodsid amount:amount otheramount:otheramount errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger) qxordersearch: (NSString*)shopid goodsid:(NSString*)goodsid begindt:(NSString*)begindt enddt:(NSString*)enddt dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf qxordersearch:shopid goodsid:goodsid begindt:begindt enddt:enddt dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)xyktx:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString*)amount dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf xyktx:shopid goodsid:goodsid amount:amount dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)delxyktx:(NSString*)orderid goodsid:(NSString*)goodsid errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf delxyktx:orderid goodsid:goodsid errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)getxyktxstate:(NSString*)shopid type:(NSString**)type errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf getxyktxstate:shopid type:type errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)setxyktxstate:(NSString*)shopid type:(NSString*)type errmsg:(NSString**)errmsg
{
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf setxyktxstate:shopid type:type errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger)jjkzz:(NSString *)shopid accountname:(NSString *)accountname accountnbr:(NSString *)accountnbr amount: (NSString *)amount orderdesc:(NSString *)orderdesc goodsid: (NSString *)goodsid dataArray:(NSMutableDictionary*)dataArray errmsg:(NSString**)errmsg {
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf jjkzz:shopid accountname:accountname accountnbr:accountnbr amount:amount orderdesc:orderdesc goodsid:goodsid dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}

+ (NSInteger) commitOrder: (NSString *)orderid cardnbr: (NSString *)cardnbr cardnbr2: (NSString *)cardnbr2 cardpwd: (NSString *)cardpwd goosid: (NSString *)goodsid dataArray: (NSMutableDictionary *)dataArray errmsg: (NSString **)errmsg {
    
    NSInteger code;
    BOOL result = NO;
    code = [NetIntf commitOrder:orderid cardnbr:cardnbr cardnbr2:cardnbr2 cardpwd:cardpwd goosid:goodsid dataArray:dataArray errmsg:errmsg];
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
    
}

+ (BOOL) queryshmx: (NSString*)shopid orgtype:(NSString*)orgtype dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    
    NSInteger code;
    BOOL result = NO;
    
    code = [NetIntf shmx:shopid orgtype:orgtype dataArray:dataArray errmsg:errmsg];
    
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    NSLog(@"%d", [dataArray count]);
    return result;
}


+ (NSInteger) getShopUrl:(NSString *)shopid goodsid: (NSString *)goodsid dataArray: (NSMutableDictionary *) dataArray errmsg: (NSString **)errmsg {
    
    NSInteger code;
    BOOL result = NO;
    
    code = [NetIntf getShopUrl:shopid goodsid:goodsid dataArray:dataArray errmsg:errmsg];
    
    if (code == 200)
        result = YES;
    else{
        result = [self getErrorMsg:code errmsg:errmsg defmsg:@"错误！"];
    }
    
    return result;
}


@end
