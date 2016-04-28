//
//  LoginViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "LoginViewController.h"
#import "InterFace.h"
#import "RegisterViewController.h"
#import "UMSocial.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *_accountTextField;
    UITextField *_passwordTextField;
   
    
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self configUI];
    
    
}

-(void)configUI
{
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.height)];
    imageView.image=[UIImage imageNamed:@"lunch.png"];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    
    UIImageView *accountImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 30, 30)];
    accountImageView.image=[UIImage imageNamed:@"login_username_icon@2x.png"];
    [imageView addSubview:accountImageView];
  
    
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 70, 240, 30)];
    _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    _accountTextField.placeholder = @"请输入邮箱账号或手机号";
    _accountTextField.clearsOnBeginEditing = YES;
    _accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _accountTextField.delegate  = self;
    
    [imageView addSubview:_accountTextField];
    
    UIImageView *passwordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 110, 30, 30)];
    passwordImageView.image=[UIImage imageNamed:@"login_password_icon@2x.png"];
    [imageView addSubview:passwordImageView];
    
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 110, 240, 30)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.placeholder = @"密码不小于6位,限字母和数字";
    _passwordTextField.clearsOnBeginEditing = YES;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTextField.delegate  = self;
    
    [imageView addSubview:_passwordTextField];
    
    //注册按钮
    UIButton * registButton = [UIButton buttonWithType:UIButtonTypeSystem];
    registButton.frame = CGRectMake(60, 160, 80, 30);
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    [registButton addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:registButton];
    
    //登陆按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(180, 160, 80, 30);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:loginButton];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 220, ScreenBounds.size.width-40, 30)];
    label.text=@"----------- 还可以第三方登录-----------";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor lightGrayColor];
    
    [imageView addSubview:label];
    
    
    NSArray *array=@[@"share_platform_wechat@2x.png",@"share_platform_qqfriends2.png",@"share_platform_sina@2x.png"];
    
    for (int i=0; i<array.count;i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(60+i*(50+25), 280, 50, 50);
        [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        button.tag=1000+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
    }
}



-(void)btnClick:(UIButton *)button
{
    
    if (button.tag==1001)
    {
//        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//        
//        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//            
//            //          获取微博用户名、uid、token等
//            
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                
//                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
//                
//                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//                
//            }});
        
    }
    else if (button.tag==1002)
    {
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //          获取微博用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
            }});
        
    }
    
}
-(void)registButtonClick
{
    RegisterViewController *reg=[[RegisterViewController alloc]init];
    [self presentViewController:reg animated:YES completion:nil];
    
}
-(void)loginButtonClick:(UIButton *)btn
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
