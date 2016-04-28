//
//  SaveTableViewCell.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^playMovie)();

@interface SaveTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;


@property(nonatomic,copy)playMovie playMovie;

@end
