//
//  ZaoCanTableViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZaoCanTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZaoCanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setDataWithZaoCanItem:(ZaoCanListItem *)item
{
   [_image sd_setImageWithURL:[NSURL URLWithString:item.thumbnail]];

    _titleLabel.text=item.title;
    _tasteLabel.text=item.taste;
    _timeLabel.text=item.cooking_time;
    _likesLabel.text=[NSString stringWithFormat:@"%ld",item.likes];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
