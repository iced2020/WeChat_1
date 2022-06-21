//
//  MineViewController.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/12.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "Masonry.h"
#import "ListModel.h"
#import "ListGroupModel.h"
// 系统相机
#import <AVFoundation/AVFoundation.h>
// 系统相册
#import <AssetsLibrary/AssetsLibrary.h>

//宏定义 屏幕大小
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface MineViewController ()<
    UITableViewDataSource,
    UITableViewDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) NSArray *group;
@property (nonatomic, strong) NSData *imageWithData;//头像数据
@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
//    不想要留出状态栏的高度或者 navibar的高度
    if (@available(iOS 11.0, *)){
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserInfo];
    self.tableView.tableHeaderView = self.topView;
    [self.view addSubview:self.tableView];

}

#pragma mark - 模型导入数据
- (NSArray *)group{
    ListGroupModel *group0 = [[ListGroupModel alloc] init];
    group0.lists = @[
        [ListModel setWithimage:@"service" title:@"服务"]
    ];
    
    ListGroupModel *group1 = [[ListGroupModel alloc] init];
    group1.lists = @[
        [ListModel setWithimage:@"collect" title:@"收藏"],
        [ListModel setWithimage:@"find" title:@"朋友圈"],
        [ListModel setWithimage:@"cardBag" title:@"卡包"],
        [ListModel setWithimage:@"expression" title:@"表情"]
    ];
    
    ListGroupModel *group2 = [[ListGroupModel alloc] init];
    group2.lists =@[
        [ListModel setWithimage:@"" title:@"退出登录"]
    ];
    
    _group = @[group0,group1,group2];
    return _group;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       ListGroupModel *tmp = self.group[section];
    return tmp.lists.count;
}

//设置一行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//        cell从复用池里面获取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
//        无cell时创建
    if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mine"];
        }
//        设置指示图标
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        取出indexPath.section组数据
    ListGroupModel *group = self.group[indexPath.section];
//        取出indexPath.row对应的设置模型
    ListModel *list = group.lists[indexPath.row];
//        设置数据
    cell.textLabel.text = list.title;
    cell.imageView.image = [UIImage imageNamed:list.image];
    if (indexPath.section == 2) {
//        设置指示图标
        cell.accessoryType = NO;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return cell;
}

//点击时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//抬起手指颜色改变回来
    if (indexPath.section == 2) {
        NSLog(@"退出登录");
        [self exit];
    }
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.17)];
        //深色模式下
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return [UIColor whiteColor];
                }
                else {
                    return [UIColor darkGrayColor];
                }
            }];
        _topView.backgroundColor = dyColor;
        
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.text = @"User";
        nameLable.font = [UIFont boldSystemFontOfSize:22];
        nameLable.textAlignment = NSTextAlignmentLeft;
        
        [_topView addSubview:nameLable];
        [_topView addSubview:self.userImageView];

        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topView).offset(30);
            make.left.equalTo(_topView).offset(30);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        //nameLab
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userImageView);
            make.left.equalTo(self.userImageView.mas_right).offset(30);
            make.size.mas_equalTo(CGSizeMake(200, 50));
        }];

        //设置点击手势
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageEvent)];
        [_topView addGestureRecognizer:tapGestureRecognizer];
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}

- (UIImageView *)userImageView {
    if (_userImageView == nil) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.backgroundColor = [UIColor blueColor];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = 35;
    }
    return _userImageView;
}

#pragma mark - 退出登录
- (void)exit{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.modalPresentationStyle = 0;
    loginVC.Logined = NO;
    [self presentViewController:loginVC animated:YES completion:Nil];
}

#pragma mark - 选择头像

- (void)headImageEvent{
    NSLog(@"上传头像");
    [self selectPhotoAlbumWithSelectPhotoHandle:^(UIImage *img) {
        self.userImageView.image = img;
        NSData *dataWithImage;
        dataWithImage = UIImageJPEGRepresentation(img, 0.3);
        self.imageWithData = dataWithImage;
    }];
}

//弹出提示框 选择相机或者相册
- (void)selectPhotoAlbumWithSelectPhotoHandle:(void (^)(UIImage *))selectPhotoHandle{
    //创建sheet提示框，提示选择相机还是相册
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    //拍照按钮
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    //相册按钮
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self LocalPhoto];
    }];
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //添加各个按钮事件
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancelAction];

    //弹出sheet提示框
    [self presentViewController:alert animated:YES completion:nil];
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里(将获取的照片修改到头像位置)
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.userImageView.image = image;
    [self saveUserInfo];
}

#pragma mark - 保存用户名头像
//登录成功后把密码保存到沙盒中（用户偏好设置）
- (void)saveUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSImage需要先转成NSDada再储存
    NSData *imageData = UIImageJPEGRepresentation(self.userImageView.image, 1);
    [userDefaults setObject:imageData forKey:@"userImage"];
    //立即保存数据
    [userDefaults synchronize];
}
//当重新加载应用，读取沙盒中的用户信息
- (void)loadUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = [userDefaults objectForKey:@"userImage"];
    self.userImageView.image = [UIImage imageWithData:imageData];
}
@end
