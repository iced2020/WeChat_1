//
//  ChatTableViewCell.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/13.
//

#import "ChatTableViewCell.h"
#import <Masonry.h>

@implementation ChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - 自定义TableViewCell
//重写cell的方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置图片
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        self.imgView.backgroundColor = [UIColor systemBlueColor];
        self.imgView.contentMode=UIViewContentModeScaleAspectFill;
        self.imgView.clipsToBounds=YES;
        //contentView是cell自带的view，
        [self.contentView addSubview:self.imgView];
        //设置标题
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLable.numberOfLines = 0;//换行
        self.nameLable.font = [UIFont boldSystemFontOfSize:20];
        self.nameLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameLable];
//        设置对话内容
        self.sayLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.sayLable.font = [UIFont systemFontOfSize:15];
        self.sayLable.textColor = [UIColor grayColor];

        [self.contentView addSubview:self.sayLable];
//        设置时间内容
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLable.font = [UIFont systemFontOfSize:15];
        self.timeLable.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.timeLable];
    }
    return self;
}

//在这个方法写子视图的布局代码
- (void)layoutSubviews {
    //调用父类的方法
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 10, 60, 60);

//    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.window);
//    }];
 
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(20);
        make.top.equalTo(self.imgView).offset(10);
    }];
    
    [_sayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLable);
        make.top.equalTo(self.nameLable.mas_bottom).offset(5);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).offset(-50);
        make.center.equalTo(self.nameLable);
    }];
    
}

//重写setter方法。
-(void)setChat:(PersonModel *)chat {
    if (_chat != chat) {
        _chat = chat;
        //给视图赋值，
        self.nameLable.text = chat.name;
        self.sayLable.text = chat.say;
        self.timeLable.text = chat.time;
//        判断有无图片
        if (chat.img != nil) {
            self.imgView.image = [UIImage imageNamed:chat.img];
        }
    }
    //注意：这里不能写成 self.tLable = tLable;
    //因为这样会无限的调用自己，叫做递归；
}

@end
