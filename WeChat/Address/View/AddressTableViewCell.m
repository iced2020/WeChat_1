//
//  AddressTableViewCell.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/17.
//

#import "AddressTableViewCell.h"
#import <Masonry.h>

@implementation AddressTableViewCell

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
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        //头像图片宽高适配
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        self.imgView.clipsToBounds = YES;
        //contentView是cell自带的view
        [self.contentView addSubview:self.imgView];
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLable.numberOfLines = 0;//换行
        self.nameLable.font = [UIFont boldSystemFontOfSize:18];
        self.nameLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameLable];
    }
    return self;
}

//在这个方法写子视图的布局代码
- (void)layoutSubviews {
    //调用父类的方法
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 10, 40, 40);

    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(20);
        make.top.equalTo(self.imgView).offset(10);
    }];

}

//重写setter方法。
-(void)setAddress:(AddressModel *)address {
    if (_address != address) {
        _address = address;
        //给视图赋值，
        self.nameLable.text = address.name;
//        判断有无图片
        if (address.img != nil) {
       self.imgView.image = [UIImage imageNamed:address.img];
        }
    }
    //注意：这里不能写成 self.tLable = tLable;
    //因为这样会无限的调用自己，叫做递归；
}

@end
