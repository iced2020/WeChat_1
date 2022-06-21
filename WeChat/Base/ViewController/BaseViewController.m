//
//  BaseViewController.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/12.
//

#import "BaseViewController.h"
#import "ChatTableViewCell.h"
#import "PersonModel.h"

@interface BaseViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSDictionary *data;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    读取plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ChatLog" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
//设置每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (unsigned long)self.data.count;
}

//设置一行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

//具体数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *reusedId = @"chat";
    ChatTableViewCell *cell = (ChatTableViewCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:reusedId];
    if (!cell) {
        cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.row] ;
    NSDictionary *tmpInfo = [self.data objectForKey:key];
    PersonModel *model = [PersonModel provinceWithDictionary:tmpInfo];
//   显示所有内容
    cell.chat = model;
//    NSLog(@"%@",cell.chat.name);
    return cell;
}

#pragma mark - lan加载
- (UITableView *) tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];//初始化并设置分组显示（Groupd）/不分组(plain）
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
