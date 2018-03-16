//
//  const.h
//  Kuaifu
//
//  Created by yangmx on 13-1-24.
//  Copyright (c) 2013年 ND. All rights reserved.
//

#ifndef Kuaifu_const_h
#define Kuaifu_const_h

#define QDFLAG  20
#define VER_STR  @"2.4.6"
//"2.3.6"
#define INNER_TEST  0
//#define try_net

#define COLOR_FONT_DEFAULT [UIColor blackColor]
#define CHANNEL  QDFLAG


//易付通(中金通宝)
#if (QDFLAG == 302)
//{
#define QUDAO   @"yft"
#define APPKEY  @"5218661356240b5cfe044c61"
#undef  CHANNEL
#define CHANNEL  2
//}
#endif

//无界
#if (QDFLAG == 20)
//{
#define QUDAO   @"yft"
//#define APPKEY  @"559101aa67e58eeac4002fc0" //正式
#define APPKEY  @"5656671667e58e5b26008662"   //测试
#undef  CHANNEL
#define CHANNEL  20
//}
#endif

#define url_param  [NSString stringWithFormat:@"?devfrom=2&channel=%d&version=%@", CHANNEL, VER_STR]
#define url_param_error  [NSString stringWithFormat:@"?devfrom=2&channel=%d&version=%@", 0, VER_STR]

#define COLOR_VIEW_BACKGROUND [UIColor whiteColor]
//#define COLOR_VIEW_BACKGROUND [UIColor colorWithRed:241/255.0 green:236/255.0 blue:233/255.0 alpha:1.0f]
#define COLOR_VIEW_TEXT [UIColor colorWithRed:0 green:94/255.0 blue:174/255.0 alpha:1.0]



#endif
