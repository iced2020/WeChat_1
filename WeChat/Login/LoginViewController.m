//
//  LoginViewController.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/12.
//


#import "LoginViewController.h"
#import "BaseViewController.h"
#import "Masonry.h"

@interface LoginViewController ()
@property (nonatomic, strong)UILabel *loginLabel;
@property (nonatomic, strong)UILabel *welcomeLabel;
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *pwdTextField;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIButton *resetButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUserInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginLabel];
    [self.view addSubview:self.welcomeLabel];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.resetButton];
    self.Logined = NO;
    [self saveUserInfo];
    
    [_loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT *0.2);
    }];
    
    [_welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginLabel);
        make.top.equalTo(self.loginLabel.mas_bottom).offset(20);
    }];
    
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.welcomeLabel.mas_bottom).offset(20);
        make.left.mas_offset(80);
    }];
    
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(20);
        make.left.mas_offset(80);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    [_resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.equalTo(self.loginButton.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark - lan加载
- (UILabel *)loginLabel{
    if(_loginLabel == nil){
        _loginLabel = [[UILabel alloc]init];
        _loginLabel.text =@"登录";
        _loginLabel.frame =CGRectMake(15, 110, 88, 68);
        _loginLabel.font = [UIFont boldSystemFontOfSize:40];
        _loginLabel.textColor = [UIColor blueColor];
    }
    return _loginLabel;
}

- (UILabel *)welcomeLabel{
    if(_welcomeLabel == nil){
        _welcomeLabel = [[UILabel alloc]init];
        _welcomeLabel.text =@"欢迎登录微信！";
        _welcomeLabel.frame =CGRectMake(15, 175, 216, 28);
        _welcomeLabel.font = [UIFont boldSystemFontOfSize:16];
        _welcomeLabel.textColor = [UIColor grayColor];
        _welcomeLabel.numberOfLines = 0;
    }
    return _welcomeLabel;
}

- (UITextField *)nameTextField{
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 210, 270, 40)];
        _nameTextField.placeholder = @"请输入账号（默认admin）";
        _nameTextField.font = [UIFont systemFontOfSize:20];
        _nameTextField.borderStyle = UITextBorderStyleRoundedRect;//边框样式
    }
    return _nameTextField;
}

- (UITextField *)pwdTextField{
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 270, 270, 40)];
        _pwdTextField.placeholder = @"请输入密码（默认admin）";
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.font = [UIFont systemFontOfSize:20];
        _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _pwdTextField.clearButtonMode = UITextFieldViewModeAlways;//显示一次性清除的×
    }
    return _pwdTextField;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc]init];
        _loginButton.frame =CGRectMake(30, 360, 315, 52);
        //给控件加圆角
        _loginButton.layer.cornerRadius = 25;
        [_loginButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录中..." forState:UIControlStateHighlighted];
        _loginButton.backgroundColor = [UIColor blueColor];
    }
    return _loginButton;
}

- (UIButton *)resetButton{
    if (_resetButton == nil) {
        _resetButton = [[UIButton alloc]init];
        _resetButton.frame =CGRectMake(30, 420, 315, 52);
        //给控件加圆角
        _resetButton.layer.cornerRadius = 25;
        [_resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
        [_resetButton setTitle:@"清空账号所有数据" forState:UIControlStateNormal];
        [_resetButton setTitle:@"清空中..." forState:UIControlStateHighlighted];
        _resetButton.backgroundColor = [UIColor blueColor];
    }
    return _resetButton;
}


#pragma mark - 点击登录按钮调用的方法
- (void)buttonClick{
    NSString *name = self.nameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    [self login:name pwd:pwd];
}

- (void)login:(NSString *)name pwd:(NSString *)pwd {
    NSLog(@"%@",pwd);
    if ([name isEqual: @""] || [pwd isEqual: @""]) {
        [self showError:@"用户名和密码不能为空！"];
    }else if ([name isEqual: @"admin"] && [pwd isEqual: @"admin"]){
        NSLog(@"成功登录");
        self.Logined = YES;
        [self saveUserInfo];
        [self dismissVC];
    }else{
        [self showError:@"用户名与密码输入错误！默认用户名与密码均为admin"];
    }
}

- (void)reset{
    [self resetDefaults];
    self.nameTextField.text = nil;
    self.pwdTextField.text = nil;
    self.Logined = NO;
}

#pragma mark -弹框提醒
- (void)showError:(NSString *)errorMsg {
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - 返回上一页面
- (void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存用户名和密码
//登录成功后把密码保存到沙盒中（用户偏好设置）
- (void)saveUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.nameTextField.text forKey:@"name"];
    [userDefaults setObject:self.pwdTextField.text forKey:@"pwd"];
    [userDefaults setBool:self.Logined forKey:@"logined"];
    //立即保存数据
    [userDefaults synchronize];
}
//当重新加载应用，读取沙盒中的用户信息
- (void)loadUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.nameTextField.text = [userDefaults objectForKey:@"name"];
    self.pwdTextField.text = [userDefaults objectForKey:@"pwd"];
    self.Logined = [userDefaults boolForKey:@"logined"];
}
//重置用户信息
- (void)resetDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}
@end
