//
//  SaveTableViewCell.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "SaveTableViewCell.h"

@implementation SaveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)video:(id)sender {
    
    self.playMovie();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
