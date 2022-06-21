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

@interface FindViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSDictionary *data;
@end

@implementation FindViewController

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

@end
