//
//  DetailView.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (void)createDetailViewWithClass:(id)classObject andSEL:(SEL)sel
{
   // [self createBgImageView];
    
    NSArray *names = @[@"收藏@2x.png",@"分享@2x.png"];
    int index = 0;
    for(NSString *imageName in names)
    {
        [self createButtonWithImageName:imageName andIndex:index andCount:names.count andSEL:sel andClass:classObject];
        index++;
    }
    
}

//- (void)createBgImageView
//{
//    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ad_title_bg.png"]];
//    UIImageView *imageView=[[UIImageView alloc]init];
//    imageView.backgroundColor=[UIColor blackColor];
//    
//    imageView.frame = self.bounds;
//    [self addSubview:imageView];
//}

- (void)createButtonWithImageName:(NSString *)imageName andIndex:(int)index andCount:(int)count andSEL:(SEL)sel andClass:(id)classObject
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.frame.size.width/count*index, 0, self.frame.size.width/count, self.frame.size.height);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.tag = index;
    [self addSubview:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
