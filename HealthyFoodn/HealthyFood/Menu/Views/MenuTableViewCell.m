//
//  MenuTableViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setDataWithMenuItem:(RootItem *)item
{
    [_thumbImage sd_setImageWithURL:[NSURL URLWithString:item.thumb]];
    _titleLabel.text=item.title;
    _likesLabel.text=[NSString stringWithFormat:@"%@次浏览  %@次赞",item.views,item.likes];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
