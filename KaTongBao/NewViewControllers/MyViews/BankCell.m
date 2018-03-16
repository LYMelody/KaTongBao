//
//  BankCell.m
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "BankCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
#import "BusiIntf.h"
@implementation BankCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //NSString *BankName = [BusiIntf curPayOrder].BankName;
        //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15.5, 34, 34)];
        //imageView.backgroundColor = Gray151;
//        imageView.image = [UIImage imageNamed:@"iconfont-yinxing.png"];
//        NSLog(@"银行名字:%@",BankName);
//        //imageView.image = [UIImage imageNamed:@"iconfont-minshengyinxing.png"];
//        if ([BankName isEqualToString:@"广发银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-guangfayinxing.png"];
//        }
//        if ([BankName isEqualToString:@"招商银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-zhaoshangyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"工商银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-gongshangyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"华夏银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-huaxiayinxing.png"];
//        }
//        if ([BankName isEqualToString:@"建设银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-jiansheyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"光大银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-guangdayinxing.png"];
//        }
//        if ([BankName isEqualToString:@"民生银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-minshengyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"中国银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-zhongguoyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"农业银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-nongyeyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"渤海银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-bohaiyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"交通银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-jiaotongyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"浙商银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-zheshangyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"中信银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-zhongxinyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"成都银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-cdbank.png"];
//        }
//        if ([BankName isEqualToString:@"兴业银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-xingyeyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"储蓄银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-zhongguochuxuyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"浦发银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-pufayinxing.png"];
//        }
//        if ([BankName isEqualToString:@"上海银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-iconcopy.png"];
//        }
//        if ([BankName isEqualToString:@"杭州银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-hangzhouyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"南京银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-nanjingyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"温州银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-wenzhouyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"平安银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-pinganyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"青岛银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-qingdaoyinxing.png"];
//        }
//        if ([BankName isEqualToString:@"中国人民银行"]) {
//            imageView.image = [UIImage imageNamed:@"iconfont-iconfontrenmin.png"];
//        }
        
        //[self.contentView addSubview:imageView];
        
        UILabel *bankLabel = [[UILabel alloc] init];
        bankLabel.text = [BusiIntf curPayOrder].BankName;
        bankLabel.backgroundColor = [UIColor clearColor];
        bankLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:bankLabel];
        UILabel *bankNoLabel = [[UILabel alloc] init];
        NSString *type = [[NSString alloc] init];
        if ([[BusiIntf curPayOrder].BankCardType isEqual:@"1"]) {
            type = @"信用卡";
        }else {
            type = @"储蓄卡";
        }
        //[BusiIntf curPayOrder].BankCardNo
        bankNoLabel.text = [NSString stringWithFormat:@"尾号%d    %@", [[[BusiIntf curPayOrder].BankCardNo substringWithRange:NSMakeRange([BusiIntf curPayOrder].BankCardNo.length - 4, 4)] intValue],type]  ;
        bankNoLabel.backgroundColor = [UIColor clearColor];
        bankNoLabel.font = [UIFont systemFontOfSize:13];
        bankNoLabel.textColor = Gray151;
        [self.contentView addSubview:bankNoLabel];
        //imageView.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,15.5).bottomSpaceToView(self,15.5).widthIs(34).heightIs(34);
        bankLabel.sd_layout.topSpaceToView(self.contentView,12).leftSpaceToView(self.contentView,20).widthIs(56).heightIs(20);
        bankNoLabel.sd_layout.topSpaceToView(self.contentView,34).leftSpaceToView(self.contentView,20).widthIs(120).heightIs(18.5);
    }
    //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
@end
