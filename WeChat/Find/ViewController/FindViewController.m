//
//  FindViewController.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/12.
//

#import "FindViewController.h"
#import "FindModel.h"
#import "FindTableViewCell.h"
#import <Masonry.h>
#import "PublishViewController.h"

@interface FindViewController ()<
UITableViewDataSource,
UITableViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSDictionary *data;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) NSData *imageWithData;//背景数据
@end

@implementation FindViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self loadUserInfo];
    //配置导航栏
    [self setupNav];
    
}
   
- (void)viewDidLoad {
    [super viewDidLoad];
    //    读取plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.tableView.tableHeaderView = self.topView;
    [self.view addSubview:self.tableView];
}

#pragma mark 配置导航栏
- (void)setupNav{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = item;
    
}

#pragma mark - UITableViewDataSource
//设置每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (unsigned long)self.data.count;
}

//具体数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusedId = @"finds";
    FindTableViewCell *cell = (FindTableViewCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:reusedId];
    if (!cell) {
        cell = [[FindTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.row] ;
    NSDictionary *tmpInfo = [self.data objectForKey:key];
    FindModel *model = [FindModel provinceWithDictionary:tmpInfo];
//   显示所有内容
    cell.finds = model;
    return cell;
}

//点击时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//抬起手指颜色改变回来
}
#pragma mark - lan加载
- (UITableView *) tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];//初始化并设置分组显示（Groupd）/不分组(plain）
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;//垂直方向的滚动条

        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
    }
    return _tableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
        [_topView addSubview:self.topImageView];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_topView);
            make.width.equalTo(_topView);
        }];
        
        [_topView addSubview:self.userImageView];
        _topView.backgroundColor = [UIColor greenColor];
        [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_topView).offset(15);
            make.right.equalTo(_topView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(75, 75));
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
        _userImageView.layer.cornerRadius = 20;
    }
    return _userImageView;
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.backgroundColor = [UIColor redColor];
//        中心裁剪
        _topImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _topImageView.clipsToBounds = YES;
    }
    return _topImageView;
}

#pragma mark - 选择背景图
- (void)headImageEvent{
    NSLog(@"上传背景像");
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

//当选择一张图片后进入这里(将获取的照片修改到头视图位置)
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.topImageView.image = image;
    [self saveUserInfo];
}

#pragma mark - 导航栏点击
- (void)rightClick{
    
    PublishViewController *view = [[PublishViewController alloc]init];
    view.block = ^(FindModel *message){
        if (message) {

            //进行刷新
            [self.tableView reloadData];
        }
    };
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:view];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - 保存用户名头像
//把头视图保存到沙盒中（用户偏好设置）
- (void)saveUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSImage需要先转成NSDada再储存
    NSData *imageData = UIImageJPEGRepresentation(self.topImageView.image, 1);
    [userDefaults setObject:imageData forKey:@"topImage"];
    //立即保存数据
    [userDefaults synchronize];
}
//当重新加载应用，读取沙盒中的用户信息
- (void)loadUserInfo{
    //NSUserDefaults特殊的初始化
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userImageData = [userDefaults objectForKey:@"userImage"];
    self.userImageView.image = [UIImage imageWithData:userImageData];
    NSData *topImageData = [userDefaults objectForKey:@"topImage"];
    self.topImageView.image = [UIImage imageWithData:topImageData];
}

@end
