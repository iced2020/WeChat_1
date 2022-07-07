//
//  PublishViewController.m
//  WeChat
//
//  Created by 潘申冰 on 2022/7/6.
//

#import "PublishViewController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUserInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //初始化数组
    self.assets = [[NSMutableArray alloc] init];
    
    self.phoneIndex = 9;
    
    //添加导航栏
    [self setupNav];
    //添加输入框
    [self.view addSubview:self.textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)setupNav{
    
    self.navigationItem.title = @"发布动态";
    
    //左上角
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
    //右上角
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:nil action:@selector(rightClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
}

- (void)leftClick{
    [self saveUserInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightClick:(UIButton *)btn{
    BOOL isSingle =  CGColorEqualToColor(self.navigationItem.rightBarButtonItem.tintColor.CGColor, UIColor.grayColor.CGColor);
    if (isSingle) {
        return;
    }
    
    NSLog(@"\n 图片数组：%@ \n 输入文字：%@",self.assets,self.textView.text);
    
    if (self.textView.text.length || self.assets.count) {//内容存在或者图片存在
        if (self.block) {
            FindModel *model = [[FindModel alloc]init];
            model.name = @"User";
            model.text = self.textView.text;
         
            self.block(model);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 懒加载
#pragma mark - 输入框
- (PublshTextView *)textView{
    if (!_textView) {
        // 添加输入控件
        // 1.创建输入控件
        _textView = [[PublshTextView alloc] init];
        _textView.frame = CGRectMake(15,100,SCREEN_WIDTH - 30,140);
        _textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
        
        _textView.layer.cornerRadius = 1;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.delegate = self;
        // 2.设置提醒文字（占位文字）
        _textView.placehoder = @"说点什么吧...";
        // 3.设置字体
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.delegate = self;
    }
    return _textView;
}

- (void)itemChange{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSString*str = textView.text;
    if (!str.length) {
        self.navigationItem.rightBarButtonItem.tintColor = UIColor.grayColor;
    } else {
        self.navigationItem.rightBarButtonItem.tintColor = UIColor.blueColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 保存用户名头像
//把头视图保存到沙盒中（用户偏好设置）
- (void)saveUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSImage需要先转成NSDada再储存
    NSString *OutText = self.textView.text;
    [userDefaults setObject:OutText forKey:@"OutText"];
    //立即保存数据
    [userDefaults synchronize];
}
//当重新加载应用，读取沙盒中的用户信息
- (void)loadUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *OutText = [userDefaults objectForKey:@"OutText"];
    self.textView.text = OutText;
}

@end
