//
//  MyNavigationBar.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationBar : UIView

- (instancetype)initWithClass:(id)classObject andSEL:(SEL)sel;

@property(nonatomic,strong)NSString *navigationTitle;
@property(nonatomic,strong)UIView *navigationTitleView;
@property(nonatomic,strong)NSArray *leftItems;
@property(nonatomic,strong)NSArray *rightItems;

@end
