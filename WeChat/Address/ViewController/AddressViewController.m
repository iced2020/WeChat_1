//
//  AddressViewController.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/12.
//

#import "AddressViewController.h"
#import "AddressModel.h"
#import "AddressTableViewCell.h"

@interface AddressViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSDictionary *data;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
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
    return 60;
}

//具体数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *reusedId = @"address";
    AddressTableViewCell *cell = (AddressTableViewCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:reusedId];
    if (!cell) {
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.row] ;
    NSDictionary *tmpInfo = [self.data objectForKey:key];
    AddressModel *model = [AddressModel provinceWithDictionary:tmpInfo];
//   显示所有内容
    cell.address = model;
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
