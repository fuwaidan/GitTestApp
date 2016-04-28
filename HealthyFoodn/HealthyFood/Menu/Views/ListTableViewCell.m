//
//  ListTableViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ListTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setDataWithListItem:(ListItem *)item
{
    _categoryLabel.text=item.category;
    _effectLabel.text=item.effect;
    _ageLabel.text=item.age;
    [_thumbImage sd_setImageWithURL:[NSURL URLWithString:item.thumb]];
    _titleLabel.text=item.title;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
