//
//  JieSuanCell.m
//  wujieNew
//
//  Created by rongfeng on 16/1/6.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "JieSuanCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation JieSuanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.TimeLable = [[UILabel alloc] init];
        self.TimeLable.font = [UIFont systemFontOfSize:15];
        self.TimeLable.textColor = Color(109, 109, 109);
        [self.contentView addSubview:self.TimeLable];
        self.TimeLable.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10.5).widthIs(160).heightIs(19.5);
        self.AmountLable = [[UILabel alloc] init];
        self.AmountLable.font = [UIFont systemFontOfSize:13];
        self.AmountLable.textColor = BlueColor;
        [self.contentView addSubview:self.AmountLable];
        self.AmountLable.sd_layout.leftSpaceToView(self.contentView,203.5).topSpaceToView(self.contentView,10.5).widthIs(50).heightIs(19.5);
        self.TypeLable = [[UILabel alloc] init];
        self.TypeLable.font = [UIFont systemFontOfSize:13];
        self.TypeLable.textColor = Color(109, 109, 109);
        [self.contentView addSubview:self.TypeLable];
        self.TypeLable.sd_layout.leftSpaceToView(self.contentView,243.5).topSpaceToView(self.contentView,10.5).widthIs(50).heightIs (19.5);
        
        self.Line = [[UIImageView alloc] init];
        self.Line.backgroundColor = Color(151, 151, 151);
        [self.contentView addSubview:self.Line];
        self.Line.sd_layout.leftSpaceToView(self.contentView,16).bottomSpaceToView(self.contentView,0.5).widthIs(KscreenWidth - 16).heightIs(0.5);
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}
@end
