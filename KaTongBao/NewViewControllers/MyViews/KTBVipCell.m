//
//  KTBVipCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBVipCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation KTBVipCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.LogoImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.LogoImg];
        self.LogoImg.sd_layout.leftSpaceToView(self.contentView,24).topSpaceToView(self.contentView,22).widthIs(14).heightIs(18);
        
        self.TitleLab = [[UILabel alloc] init];
        self.TitleLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_TitleLab];
        
        _TitleLab.sd_layout.leftSpaceToView(_LogoImg,5).topSpaceToView(self.contentView,14).widthIs(200).heightIs(30);
        self.InfoLab = [[UILabel alloc] init];
        _InfoLab.font = [UIFont systemFontOfSize:13];
        _InfoLab.textColor = TextColor;
        [self.contentView addSubview:self.InfoLab];
        _InfoLab.sd_layout.leftSpaceToView(_LogoImg,5).topSpaceToView(_TitleLab,-7).widthIs(200).heightIs(30);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}

@end
