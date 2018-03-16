//
//  PayMeathodCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/10/19.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "PayMeathodCell.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
@implementation PayMeathodCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *BackImg = [[UIImageView alloc] init];
        BackImg.backgroundColor = [UIColor whiteColor];
        BackImg.layer.borderWidth = 1;
        BackImg.layer.borderColor = Color(198, 198, 200).CGColor;
        [self.contentView addSubview:BackImg];
        
        BackImg.sd_layout.leftSpaceToView(self.contentView,16).rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5);
        self.LogoImg = [[UIImageView alloc] init];
        [BackImg addSubview:self.LogoImg];
        self.LogoImg.sd_layout.leftSpaceToView(BackImg,16).widthIs(60).centerYEqualToView(BackImg).heightIs(60);
        
        self.PayLab = [[UILabel alloc] init];
        self.PayLab.font = [UIFont systemFontOfSize:18];
        self.PayLab.textAlignment = NSTextAlignmentLeft;
        [BackImg addSubview:self.PayLab];
        self.PayLab.sd_layout.leftSpaceToView(self.LogoImg,40).centerYEqualToView(BackImg).widthIs(180).heightIs(60);
        
        UIImageView *Arrow = [[UIImageView alloc] init];
        Arrow.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:Arrow];
        Arrow.sd_layout.rightSpaceToView(self.contentView,30).centerYEqualToView(BackImg).widthIs(26).heightIs(26);
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}



@end
