//
//  StepTableViewCell.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StepItem.h"
@interface StepTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *order;

@property (weak, nonatomic) IBOutlet UILabel *desc;


-(void)setDataWithStepItem:(StepItem *)item;

@end
