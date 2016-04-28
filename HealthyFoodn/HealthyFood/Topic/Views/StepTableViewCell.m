//
//  StepTableViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "StepTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation StepTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setDataWithStepItem:(StepItem *)item
{
    [_image sd_setImageWithURL:[NSURL URLWithString:item.dishes_step_image]];
    _desc.text=item.dishes_step_desc;
    _order.text=item.dishes_step_order;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
