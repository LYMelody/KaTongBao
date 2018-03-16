//
//  Header.h
//  CFT
//
//  Created by 德古拉丶 on 14-10-24.
//  Copyright (c) 2014年 TangDi. All rights reserved.
//

#ifndef CFT_Header_h
#define CFT_Header_h


//#define ZMK @"11111111111111110123456789ABCDEF"//畅付通
//#define ZMK @"4F8C0FA83B9A7DE79ACF2D6D54A6789D"//晕支付
//#define ZMK @"11111111111111110123456789ABCDEF"  //乐事通
#define ZMK @"11111111111111110123456789ABCDEF"  //盈智

//#define gkey @"b0326c4f1e0e2c2970584b14a5a36d1886b4b115"
//#define gkey @"11111111111111110123456789ABCDEF"
//刷卡器

//#define APPPPOSCF200      //是否需要这款刷卡器  bbpos




//-----------代码控制--------

#define APPYINGZHIPOS       //盈智刷卡

//#define APPYUNZHIFU       // 云智付

//#define APPYIFUTONG         //移付通   创联  乐事通   闪福  神州  易支付  mimi宝

//#define CFT   //畅付通

//#define BS    //宝刷

//---------参数控制---------- 用于控制下面参数的选取    云智付 直接用上面的控制





#ifdef APPYIFUTONG

//#define YFT   //移付通

//#define CLT  //创联通

//#define YLS  //易乐刷  //快捷支付

//#define SFT  //闪付宝

//#define SZT  //神州支付

//#define YSF   //易收付

//#define MMB   //麦麦宝

//#define EFT     // e付通

//#define SFB     // 硕付宝

//#define YST     //银商通

//#define APPP01           @"pic01.jpg"
//#define APPP02           @"pic02.jpg"
//#define APPP03           @"pic03.jpg"
//#define APPP04           @"pic04.png"
#define APPPTITLE        @"logo"
#define APPLOGONAME      @"logo96.png"        //logo图片名称 用于分享功能/版本信息LOGO


#endif


//****************盈智**************

#ifdef APPYINGZHIPOS

#define APPLIACTIONNAME  @"融丰信息"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"9009998"         //客服电话
#define APPOHONEMESSAGE  @"9009998"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPLOGONAME      @"logo96.png"        //logo图片名称 用于分享功能/版本信息LOGO
#define APPURLMESSAGE    @"V1.0"                    //版本信息message
#define APPP01           @"信用卡图片6.png"
#define APPP02           @"拍拍贷广告.png"
#define APPP03           @"拍拍贷广告New.png"
#define APPP04           @"AD04.png"
#define APPP05           @"APP05.png"
#define APPPTITLE        @"logo.png"


#endif
//多应用兼容
//*****************宝刷*************

#ifdef BS

#define APPLIACTIONNAME  @"宝刷"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"02153899999"         //客服电话
#define APPOHONEMESSAGE  @"021-53899999"        //电话显示
#define APPSHAREURL      @"http://www.baoshua.cn"                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPLOGONAME      @"logo96.png"        //logo图片名称 用于分享功能/版本信息LOGO
#define APPURLMESSAGE    @"http://www.baoshua.com.cn"                    //版本信息message
#define APPP01           @"p01.png"
#define APPP02           @"p02.png"
#define APPP03           @"p03.png"
#define APPP04           @"p04.png"
#define APPPTITLE        @"logo.png"

#endif
//*****************畅付通*************

#ifdef CFT

#define APPLIACTIONNAME  @"畅付通个人版"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"02150270319"         //客服电话
#define APPOHONEMESSAGE  @"021-50270319"        //电话显示
#define APPSHAREURL      @"http://www.cftmpay.com"                    //分享网址
#define APPMESSAGE       @"first@example.com"   //意见反馈邮箱
#define APPLOGONAME      @"logo96.png"        //logo图片名称 用于分享功能/版本信息LOGO
#define APPURLMESSAGE    @"http://www.cftmpay.com"                    //版本信息message
#define APPP01           @"p01.png"
#define APPP02           @"p02.png"
#define APPP03           @"p03.png"
#define APPP04           @"p04.png"
#define APPPTITLE        @"logo.png"

#endif
//****************移付通**************

#ifdef YFT

#define APPLIACTIONNAME  @"移付通"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4000665000"         //客服电话
#define APPOHONEMESSAGE  @"400-066-5000"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif
//****************创联通**************

#ifdef CLT

#define APPLIACTIONNAME  @"创联支付"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4000333484"         //客服电话
#define APPOHONEMESSAGE  @"4000-333-484"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message



#endif
//****************易乐刷**************

#ifdef YLS

#define APPLIACTIONNAME  @"快捷支付"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @""         //客服电话
#define APPOHONEMESSAGE  @""        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif
//****************闪付宝**************

#ifdef SFT

#define APPLIACTIONNAME  @"闪富宝"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4000293938"         //客服电话
#define APPOHONEMESSAGE  @"400-0293-938"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif
//****************神州通**************

#ifdef SZT

#define APPLIACTIONNAME  @"神州支付"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4006189777"         //客服电话
#define APPOHONEMESSAGE  @"400-618-9777"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif
//****************易收付**************

#ifdef YSF

#define APPLIACTIONNAME  @"易收付"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4008959288"         //客服电话
#define APPOHONEMESSAGE  @"400-8959-288"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""   //意见反馈邮箱
#define APPURLMESSAGE    @"www.posj88.com"                    //版本信息message



#endif
//****************mimi宝**************

#ifdef MMB

#define APPLIACTIONNAME  @"MiNi宝"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4008939377"         //客服电话
#define APPOHONEMESSAGE  @"400-8939-377"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""                    //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif

//****************e付通 **************

#ifdef EFT

#define APPLIACTIONNAME  @"E付通"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4008939377"         //客服电话
#define APPOHONEMESSAGE  @"400-8939-377"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""                    //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif

//****************硕付宝**************

#ifdef SFB

#define APPLIACTIONNAME  @"硕付宝"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4000017371"         //客服电话
#define APPOHONEMESSAGE  @"400-001-7371"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""                    //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif

//****************银商通**************

#ifdef YST

#define APPLIACTIONNAME  @"银商通"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4006189777"         //客服电话
#define APPOHONEMESSAGE  @"400-618-9777"        //电话显示
#define APPSHAREURL      @""                    //分享网址
#define APPMESSAGE       @""                    //意见反馈邮箱
#define APPURLMESSAGE    @""                    //版本信息message


#endif


//**************云智付****************

#ifdef APPYUNZHIFU

#define APPLIACTIONNAME  @"云智付"                    //代码里用到与应用名相关词汇
#define APPPHONENUMBER   @"4006155577"         //客服电话
#define APPOHONEMESSAGE  @"400-615-5577"        //电话显示
#define APPSHAREURL      @"www.yzf.com"                    //分享网址
#define APPMESSAGE       @"first@example.com"   //意见反馈邮箱
#define APPLOGONAME      @"logo96.png"        //logo图片名称 用于分享功能/版本信息LOGO
#define APPURLMESSAGE    @"http://www.cftmpay.com"                    //版本信息message
#define APPP01           @"YUNP01.jpg"
#define APPP02           @"YUNP02.jpg"
#define APPP03           @"YUNP03.jpg"
#define APPP04           @"YUNP04.jpg"
#define APPPTITLE        @"logo"

#endif

//**********************************

#endif
