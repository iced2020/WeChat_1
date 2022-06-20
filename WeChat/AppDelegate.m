//
//  AppDelegate.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/12.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseViewController.h"
#import "AddressViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化窗体
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    // 创建Tab所属的ViewController
    BaseViewController *mainVC = [[BaseViewController alloc] init];
    mainVC.title = @"微信";
    mainVC.tabBarItem.title = @"微信";
    mainVC.tabBarItem.image = [UIImage systemImageNamed:@"message"];
    mainVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"message.fill"];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainNav.navigationBar.translucent = YES;
    
    AddressViewController *addressVC = [[AddressViewController alloc] init];
    addressVC.title = @"通讯录";
    addressVC.tabBarItem.title = @"通讯录";
    addressVC.tabBarItem.image = [UIImage systemImageNamed:@"person.3"];
    addressVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.3.fill"];
    UINavigationController *addressNav = [[UINavigationController alloc] initWithRootViewController:addressVC];
    addressNav.navigationBar.translucent = YES;
    
    FindViewController *findVC = [[FindViewController alloc] init];
    findVC.title = @"发现";
    findVC.tabBarItem.title = @"发现";
    findVC.tabBarItem.image = [UIImage systemImageNamed:@"safari"];
    UINavigationController *findNav = [[UINavigationController alloc] initWithRootViewController:findVC];
    findNav.navigationBar.translucent = YES;
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.title = @"我";
    mineVC.tabBarItem.title = @"我";
    mineVC.tabBarItem.image = [UIImage systemImageNamed:@"person"];
    mineVC.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.fill"];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.navigationBar.translucent = YES;
    
    NSArray *vcsArray = [NSArray arrayWithObjects:mainNav, addressNav,  findNav, mineNav, nil];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    //深色模式下
    UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor whiteColor];
            }
            else {
                return [UIColor darkGrayColor];
            }
        }];
    [[UITabBar appearance] setBackgroundColor:dyColor];
    
    //设置多个Tab的ViewController到TabBarViewController
    tabBarVC.viewControllers = vcsArray;
    
    //将UITabBarController设置为Window的RootViewController
    self.window.rootViewController = tabBarVC;
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"logined"] == YES){
        //进入主页
        NSLog(@"自动登录");
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.modalPresentationStyle = 0;//全屏显示？
        [self.window.rootViewController presentViewController:loginVC animated:NO completion:nil];
        NSLog(@"未登录");
    }
}

@end
