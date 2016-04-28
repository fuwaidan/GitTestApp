//
//  RegisterViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "RegisterViewController.h"
#import "InterFace.h"
@interface RegisterViewController ()
{
    UITextField * _accountTextField;
    UITextField * _passwordTextField;
    UITextField * _emailTextField;
    
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self configUI];
    
}




-(void)configUI
{
    
    UIImageView *emailImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 30, 30)];
    emailImage.image=[UIImage imageNamed:@"register_email@2x.png"];
    [self.view addSubview:emailImage];
    
    //邮件
    _emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 70, 240, 30)];
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextField.placeholder = @"请输入Email";
    _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _emailTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_emailTextField];
    
    
    
    UIImageView *accountImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 110, 30, 30)];
    accountImageView.image=[UIImage imageNamed:@"login_username_icon@2x.png"];
    [self.view addSubview:accountImageView];
    
    
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 110, 240, 30)];
    _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    _accountTextField.placeholder = @"请输入邮箱账号或手机号";
    _accountTextField.clearsOnBeginEditing = YES;
    _accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    //_accountTextField.delegate  = self;
    
    [self.view addSubview:_accountTextField];
    
    UIImageView *passwordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 150, 30, 30)];
    passwordImageView.image=[UIImage imageNamed:@"login_password_icon@2x.png"];
    [self.view addSubview:passwordImageView];
    
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 150, 240, 30)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.placeholder = @"密码不小于6位,限字母和数字";
    _passwordTextField.clearsOnBeginEditing = YES;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    //_passwordTextField.delegate  = self;
    
    [self.view addSubview:_passwordTextField];
    
    
    //两个按钮
    //取消
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(50, 210, 80, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    //提交
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    commitButton.frame = CGRectMake(170, 210, 80, 30);
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    
   
                    
}
-(void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)commitButtonClick
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
