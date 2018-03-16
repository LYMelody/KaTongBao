//
//  TDWalletCell.m
//  POS
//
//  Created by syd on 15/11/27.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDWalletCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation TDWalletCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.ImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.ImageView];
        self.ImageView.sd_layout.leftSpaceToView(self.contentView,20).centerYEqualToView(self.contentView).widthIs(25).heightIs(25);
        self.Leftlabel = [[UILabel alloc] init];
        self.Leftlabel.textAlignment = NSTextAlignmentLeft;
        self.Leftlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.Leftlabel];
        self.Leftlabel.sd_layout.leftSpaceToView(self.contentView,58).centerYEqualToView(self.contentView).widthIs(140).heightIs(22);
        self.RightLabel = [[UILabel alloc] init];
        self.RightLabel.textAlignment = NSTextAlignmentRight;
        self.RightLabel.font = [UIFont systemFontOfSize:15];
        self.RightLabel.textColor = [UIColor colorWithRed:63/255.0 green:166/255.0 blue:200/255.0 alpha:1];
        [self.contentView addSubview:self.RightLabel];
        self.RightLabel.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.contentView).widthIs(80).heightIs(22);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}
@end
