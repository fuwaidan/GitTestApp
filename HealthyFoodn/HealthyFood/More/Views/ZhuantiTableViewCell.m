//
//  ZhuantiTableViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZhuantiTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZhuantiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDataWithZhuantiItem:(ZhuantiItem *)item
{
    
    [_image sd_setImageWithURL:[NSURL URLWithString:item.image]];
    _titleLabel.text=item.title;
    _descriptionLabel.text=item.descrip;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
