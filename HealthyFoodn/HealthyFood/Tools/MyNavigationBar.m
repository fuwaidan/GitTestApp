//
//  MyNavigationBar.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "MyNavigationBar.h"

#import "MyNavigationItem.h"
#import "InterFace.h"
@implementation MyNavigationBar
{
    id _classObject;
    SEL _sel;
    
}
-(instancetype)initWithClass:(id)classObject andSEL:(SEL)sel
{
    if (self=[super init]) {
        _classObject=classObject;
        _sel=sel;
        
        self.frame=CGRectMake(0, 0,ScreenBounds.size.width , 64);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor=[UIColor colorWithRed:0.33f green:0.58f blue:0.98f alpha:1.00f];
        
        imageView.frame = self.bounds;
        
        [self addSubview:imageView];
        
    }
    return self;
}
- (void)setNavigationTitle:(NSString *)navigationTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenBounds.size.width/2-100, 30, 200 , 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = navigationTitle;
    label.textColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    [self addSubview:label];
}

- (void)setNavigationTitleView:(UIView *)navigationTitleView
{
    navigationTitleView.frame = CGRectMake((self.frame.size.width-navigationTitleView.frame.size.width)/2, (self.frame.size.height-navigationTitleView.frame.size.height), navigationTitleView.frame.size.width, navigationTitleView.frame.size.height);
    [self addSubview:navigationTitleView];
}

- (void)setLeftItems:(NSArray *)leftItems
{
    int index = 0;
    float btnX = 0.0f;
    for(MyNavigationItem *item in leftItems)
    {
        UIImage *image = [UIImage imageNamed:item.itemImageName];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX+5.f, 17, image.size.width, image.size.height);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn setTitle:item.itemTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 1000+index;
        [btn addTarget:_classObject action:_sel forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        btnX = btnX + 10.f + image.size.width;
        index++;
    }
}


- (void)setRightItems:(NSArray *)rightItems
{
    int index = 0;
    float btnX = [[UIScreen mainScreen] bounds].size.width;
    for(MyNavigationItem *item in rightItems)
    {
        UIImage *image = [UIImage imageNamed:item.itemImageName];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX-10.f-image.size.width, 17, image.size.width, image.size.height);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn setTitle:item.itemTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 2000+index;
        [btn addTarget:_classObject action:_sel forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        btnX = btn.frame.origin.x;
        index++;
    }
}



@end
