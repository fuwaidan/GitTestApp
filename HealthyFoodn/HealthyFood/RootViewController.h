//
//  RootViewController.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

//@property(nonatomic,strong)NSString *viewControllerTitle;
//@property(nonatomic,strong)NSString *viewControllerURL;

- (void)createMyNavigationBarTitle:(NSString *)title andTitleView:(UIView *)view andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)rightItems andSEL:(SEL)sel andClass:(id)classObject;
@end
