
//
//  WalletView.m
//  JingXuan
//
//  Created by wj on 16/5/26.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "WalletView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation WalletView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = LightGrayColor;
    if (self) {
        [self init_UI];
        
    }
    return self;
}
- (void)init_UI {
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    view.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,20).rightSpaceToView(self,20).heightIs(140);
    
    UILabel *gatheringLabel = [[UILabel alloc] init];
    gatheringLabel.text = @"无界支付普通收款";
    gatheringLabel.backgroundColor = [UIColor whiteColor];
    gatheringLabel.textColor = [UIColor colorWithRed:236.0/255.0 green:96.0/255.0 blue:4.0/255.0 alpha:1];
    [view addSubview:gatheringLabel];
    gatheringLabel.sd_layout.topSpaceToView(view,0).leftSpaceToView(view,10).widthIs(140).heightIs(40);
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    _moneyLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:_moneyLabel];
    _moneyLabel.sd_layout.topSpaceToView(gatheringLabel,0).leftSpaceToView(view,10).widthIs(160).heightIs(40);
    
    _clearingLabel = [[UILabel alloc] init];
    _clearingLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    _clearingLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:_clearingLabel];
    _clearingLabel.sd_layout.topSpaceToView(_moneyLabel,0).leftSpaceToView(view,10).widthIs(160).heightIs(40);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"无界1"];
    [view addSubview:imageView];
    imageView.sd_layout.centerYEqualToView(view).rightSpaceToView(view,20).widthIs(50).heightIs(50);
    
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    [self addSubview:view1];
    view1.sd_layout.topSpaceToView(view,20).leftSpaceToView(self,20).rightSpaceToView(self,20).heightIs(100);
    
    UILabel *gathering= [[UILabel alloc] init];
    gathering.text = @"收款宝";
    gathering.textColor = [UIColor colorWithRed:236.0/255.0 green:96.0/255.0 blue:4.0/255.0 alpha:1];
    [view1 addSubview:gathering];
    gathering.sd_layout.topSpaceToView(view1,0).leftSpaceToView(view1,10).widthIs(140).heightIs(30);
    
    UILabel *reminder= [[UILabel alloc] init];
    reminder.text = @"收款宝余额T+1自动到账";
    reminder.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    [view1 addSubview:reminder];
    reminder.sd_layout.topSpaceToView(gathering,10).rightSpaceToView(view1,10).widthIs(190).heightIs(30);
    
    UILabel *reminder1= [[UILabel alloc] init];
    reminder1.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    reminder1.text = @"账单详情请前往收款宝查看";
    [view1 addSubview:reminder1];
    reminder1.sd_layout.topSpaceToView(reminder,0).rightSpaceToView(view1,10).widthIs(210).heightIs(30);
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    [self addSubview:view2];
    view2.sd_layout.topSpaceToView(view1,20).leftSpaceToView(self,20).rightSpaceToView(self,20).heightIs(140);
    
    UILabel *gatheringLabel1 = [[UILabel alloc] init];
    gatheringLabel1.text = @"无界支付快捷收款";
    gatheringLabel1.textColor = [UIColor colorWithRed:236.0/255.0 green:96.0/255.0 blue:4.0/255.0 alpha:1];
    gatheringLabel1.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:gatheringLabel1];
    gatheringLabel1.sd_layout.topSpaceToView(view2,10).leftSpaceToView(view2,10).widthIs(140).heightIs(40);
    
    _moneyLabel1 = [[UILabel alloc] init];
    _moneyLabel1.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    _moneyLabel1.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:_moneyLabel1];
    _moneyLabel1.sd_layout.topSpaceToView(gatheringLabel1,0).leftSpaceToView(view2,10).widthIs(160).heightIs(40);
    
    _clearingLabel1 = [[UILabel alloc] init];
    _clearingLabel1.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    _clearingLabel1.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:_clearingLabel1];
    _clearingLabel1.sd_layout.topSpaceToView(_moneyLabel1,0).leftSpaceToView(view2,10).widthIs(160).heightIs(40);
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.image = [UIImage imageNamed:@"无界1"];
    [view2 addSubview:imageView1];
    imageView1.sd_layout.centerYEqualToView(view2).rightSpaceToView(view2,20).widthIs(50).heightIs(50);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
