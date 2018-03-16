//
//  TDViewsCell.m
//  POS
//
//  Created by syd on 15/11/26.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDViewsCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
@implementation TDViewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.ImageView = [[UIImageView alloc] init];
        self.ImageView.backgroundColor = LightGrayColor;
        
        [self.contentView addSubview:self.ImageView];
        self.ImageView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).rightEqualToView(self.contentView).bottomEqualToView(self.contentView);
        UIImageView *LineImg = [[UIImageView alloc] init];
        LineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:LineImg];
        LineImg.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(0.5);
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
@end
