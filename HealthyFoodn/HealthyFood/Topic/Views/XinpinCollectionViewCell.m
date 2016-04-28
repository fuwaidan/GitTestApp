//
//  XinpinCollectionViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "XinpinCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation XinpinCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDataWithRemen:(Remenitem *)remenItem
{
    _titleLabel.text=remenItem.title;
    _descriptionLabel.text=remenItem.descrip;
    
    [_image sd_setImageWithURL:[NSURL URLWithString:remenItem.image]];
    
}
- (IBAction)moviePlay:(id)sender
{
    self.playMovie();
}



@end
