//
//  NetIntf.h
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetIntf : NSObject



+ (NSInteger) login:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname errmsg:(NSString**)errmsg;

+ (NSInteger) login:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type errmsg:(NSString**)errmsg;
//updateflag
+ (NSInteger) login:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type updateflag:(NSString **) updateflag errmsg:(NSString**)errmsg;

+ (NSInteger) systeminfo:(NSString*)shopid msgContent:(NSString**)msgContent errmsg:(NSString**)errmsg;

+ (NSInteger) systeminfo:(NSString*)shopid type: (NSString *)type msgContent:(NSString**)msgContent errmsg:(NSString**)errmsg;

+ (NSInteger) feedback:(NSString*)shopid feedbackinfo:(NSString*)feedbackinfo errmsg:(NSString**)errmsg;
+ (NSInteger) changepwd:(NSString*)shopid oldpwd:(NSString*)oldpwd userpwd:(NSString*)userpwd errmsg:(NSString**)errmsg;
+ (NSInteger) regfirst: (NSString*)regphone username:(NSString*)username userpwd:(NSString*)userpwd shopnbr:(NSString*)shopnbr shopid:(NSString**)shopid errmsg:(NSString**)errmsg;
+ (NSInteger) regphoto: (NSString*)shopid photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3 photo4:(NSString*)photo4 errmsg:(NSString**)errmsg;
//上传5张照片
+ (NSInteger) regphoto: (NSString*)shopid photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3 photo4:(NSString*)photo4 photo5:(NSString*)photo5 photo6:(NSString*)photo6 errmsg:(NSString**)errmsg;

+ (NSInteger) regshop: (NSString*)shopid shopname:(NSString*)shopname shopbank:(NSString*)shopbank accountnbr:(NSString*)accountnbr accountname:(NSString*)accountname shopkey:(NSString*)shopkey errmsg:(NSString**)errmsg;
+ (NSInteger) regcheck: (NSString*)mobile checkcode:(NSString**)checkcode errmsg:(NSString**)errmsg;
+ (NSInteger) regist: (NSString*)shopid errmsg:(NSString**)errmsg;
+ (NSInteger) logout: (NSString*)shopid errmsg:(NSString**)errmsg;
+ (NSInteger) shopinput: (NSString*)mobile username:(NSString*)username pwd:(NSString*)pwd errmsg:(NSString**)errmsg;
+ (NSInteger) shopcheck: (NSString*)phone photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3
   shopname:(NSString*)shopname shopbank:(NSString*)shopbank accountnbr:(NSString*)accountnbr errmsg:(NSString**)errmsg;
+ (NSInteger) usercheck: (NSString*)charnbr errmsg:(NSString**)errmsg;
+ (NSInteger) userreg: (NSString*)cardnbr cardtype:(NSString*)cardtype cardbank:(NSString*)cardbank
             username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone errmsg:(NSString**)errmsg;

+ (NSInteger) ordersearch: (NSString*)shopid state:(NSString*)state dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;
+ (NSInteger) ydddzf: (NSString*)username begindt:(NSString*)begindt enddt:(NSString*)enddt errmsg:(NSString**)errmsg;
+ (NSInteger) ydddzfjlcx: (NSString*)username begindt:(NSString*)begindt enddt:(NSString*)enddt dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;
+ (NSInteger) getordercode: (NSString*)shopid userordercode:(NSString*)userordercode goodsid:(NSString*)goodsid amount:(NSString*)amount orderdesc:(NSString*)orderdesc ordercode:(NSString**)ordercode orderid:(NSString**)orderid errmsg:(NSString**)errmsg;
+ (NSInteger) getordercode: (NSString*)shopid userordercode:(NSString*)userordercode goodsid:(NSString*)goodsid amount:(NSString*)amount orderdesc:(NSString*)orderdesc ordercode:(NSString**)ordercode orderid:(NSString**)orderid type:(NSString *) type errmsg:(NSString**)errmsg;

+ (NSInteger) checkcardinfo: (NSString*)cardnbr userid:(NSString**)userid goodsid:(NSString*)goodsid isreg:(BOOL*)isreg cardbank: (NSString **) cardbank errmsg:(NSString**)errmsg;
+ (NSInteger) checkuserinfo: (NSString**)userid username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone bankcardno:(NSString*)bankcardno bankcardtype:(NSString*)bankcardtype bankname:(NSString*)bankname bankverify:(NSString*)bankverify bankcvv:(NSString*)bankcvv bankpwd:(NSString*)bankpwd orderid:(NSString*)orderid goodsid:(NSString*)goodsid errmsg:(NSString**)errmsg;

+ (NSInteger) checkcardinfo: (NSString*)cardnbr userid:(NSString**)userid goodsid:(NSString*)goodsid isreg:(BOOL*)isreg cardbank: (NSString **) cardbank ordercode:(NSString*)ordercode errmsg:(NSString**)errmsg;
+ (NSInteger) checkuserinfo: (NSString**)userid username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone bankcardno:(NSString*)bankcardno bankcardtype:(NSString*)bankcardtype bankname:(NSString*)bankname bankverify:(NSString*)bankverify bankcvv:(NSString*)bankcvv bankpwd:(NSString*)bankpwd orderid:(NSString*)orderid goodsid:(NSString*)goodsid ordercode:(NSString*)ordercode errmsg:(NSString**)errmsg;


+ (NSInteger) orderpaycheck: (NSString*)shopid ordercode:(NSString*)ordercode userid:(NSString*)userid goodsid:(NSString*)goodsid amount:(NSString*)amount otheramount:(NSString*)otheramount orderdesc:(NSString*)orderdesc orderid:(NSString**)orderid merchantid:(NSString **)merchantID params: (NSString **)params errmsg:(NSString**)errmsg;
+ (NSInteger) orderpaycheck: (NSString*)shopid ordercode:(NSString*)ordercode userid:(NSString*)userid goodsid:(NSString*)goodsid amount:(NSString*)amount otheramount:(NSString*)otheramount orderdesc:(NSString*)orderdesc orderid:(NSString**)orderid merchantid:(NSString **)merchantID params: (NSString **)params url:(NSString **)request_url errmsg:(NSString**)errmsg;

+ (NSInteger) payorder: (NSString*)orderid sms:(NSString*)sms errmsg:(NSString**)errmsg;
+ (NSInteger) payordersecond: (NSString*)orderid sms:(NSString*)sms errmsg:(NSString**)errmsg;
+ (NSInteger) querypay: (NSString*)shopid goodsid:(NSString*)goodsid begindt:(NSString*)begindt enddt:(NSString*)enddt orderdesc:(NSString*)orderdesc dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;
+ (NSInteger) querypaybyid: (NSString*)ordercode goodsid:(NSString*)goodsid dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;

//photo6
+ (NSInteger) querypaybyid: (NSString*)ordercode goodsid:(NSString*)goodsid dataArray:(NSMutableArray*)dataArray uploadflag:(NSString **)uploadflag errmsg:(NSString**)errmsg;

+ (NSString*)getM1:(NSString*)icon logo:(NSString*)logo contact:(NSString*)contact;
+ (NSInteger)xykhz:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString**)amount errmsg:(NSString**)errmsg;
+ (NSInteger)xykhz:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString**)amount otheramount: (NSString **) otheramount errmsg:(NSString**)errmsg;

+ (NSInteger) qxordersearch: (NSString*)shopid goodsid:(NSString*)goodsid begindt:(NSString*)begindt enddt:(NSString*)enddt dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;
+ (NSInteger)xyktx:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString*)amount dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;
+ (NSInteger)delxyktx:(NSString*)orderid goodsid:(NSString*)goodsid errmsg:(NSString**)errmsg;
+ (NSInteger)getxyktxstate:(NSString*)shopid type:(NSString**)type errmsg:(NSString**)errmsg;
+ (NSInteger)setxyktxstate:(NSString*)shopid type:(NSString*)type errmsg:(NSString**)errmsg;
+ (NSInteger)jjkzz:(NSString *)shopid accountname:(NSString *)accountname accountnbr:(NSString *)accountnbr amount: (NSString *)amount orderdesc:(NSString *)orderdesc goodsid: (NSString *)goodsid dataArray:(NSMutableDictionary*)dataArray errmsg:(NSString**)errmsg;
+ (NSInteger) commitOrder: (NSString *)orderid cardnbr: (NSString *)cardnbr cardnbr2: (NSString *)cardnbr2 cardpwd: (NSString *)cardpwd goosid: (NSString *)goodsid dataArray: (NSMutableDictionary *)dataArray errmsg: (NSString **)errmsg ;

+ (NSInteger) shmx: (NSString*)shopid orgtype:(NSString*)orgtype dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg;

//获取url
+ (NSInteger) getShopUrl:(NSString *)shopid goodsid: (NSString *)goodsid dataArray: (NSMutableDictionary *) dataArray errmsg: (NSString **)errmsg;

@end
