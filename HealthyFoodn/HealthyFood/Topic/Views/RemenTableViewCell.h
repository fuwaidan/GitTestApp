//
//  RemenTableViewCell.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remenitem.h"

typedef void(^playMovie)();

@interface RemenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (copy, nonatomic) playMovie playMovie;

-(void)setDataWithRemen:(Remenitem *)remenItem;
@end
