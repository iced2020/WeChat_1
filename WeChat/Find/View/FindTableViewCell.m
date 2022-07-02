//
//  FindTableViewCell.m
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import "FindTableViewCell.h"
#import <Masonry.h>

@interface FindTableViewCell()

//头像框
@property (nonatomic, strong) UIImageView *userImageView;

//第一个YYLabel：动态信息
@property (nonatomic, strong) YYLabel *yyTextLab;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) NSMutableAttributedString *nameAtt;
@property (nonatomic, strong) NSMutableAttributedString *textAtt;
@property (nonatomic, strong) NSMutableAttributedString *maintext;

//评论按钮
@property (nonatomic, strong) UIButton *commentBtn;
//自己发的朋友圈的删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;

//第二个YYLabel：评论信息
@property (nonatomic, strong) YYLabel *yyCommentsLab;

//评论详情
@property (nonatomic, strong) NSMutableArray <NSString *> *commentsTextArray;

@end

@implementation FindTableViewCell

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
        [self setupUI];
    }
    return self;
}


#pragma mark - 重写setter方法。【此处才能赋值】
-(void)setFinds:(FindModel *)finds {
    if (_finds != finds) {
        _finds = finds;
        self.userImageView.image = [UIImage imageNamed:_finds.img];
        self.lab.text = self.finds.name;
        self.nameAtt = [NSMutableAttributedString
            yy_attachmentStringWithContent:self.lab
            contentMode:UIViewContentModeLeft
            attachmentSize:CGSizeMake(SCREEN_WIDTH - 80 - 15, 30)  //图片占位符
            alignToFont:[UIFont systemFontOfSize:20]
            alignment:YYTextVerticalAlignmentBottom
        ];
        
        self.textAtt = [[NSMutableAttributedString alloc] initWithString:@"用555555555555555555555555555555555555555555555\n"];
        self.textAtt.yy_font = [UIFont systemFontOfSize:18];
        self.textAtt.yy_color = [UIColor darkGrayColor];
        self.maintext = [NSMutableAttributedString new];
        [self.maintext appendAttributedString:self.nameAtt];
        [self.maintext appendAttributedString:self.textAtt];
        
        self.finds.imagesArray = @[@"A",@"A",@"A",@"A",@"A",@"A",@"A"];
        [self setupImg];//添加图片
        
        self.yyTextLab.attributedText = self.maintext;
        }
}
    //注意：这里不能写成 self.tLable = tLable;
    //因为这样会无限的调用自己，叫做递归；

#pragma mark - 布局UI
- (void)setupUI{
    self.yyTextLab = [[YYLabel alloc] init];
    [self mainBody];

    //有评论
    if (self.commentsTextArray.count != 0) {
        [self yesCom];
    }

}

//点击事件
- (void)Actionbutton{
    NSLog(@"点击了内容");
}

#pragma mark - 布局UI子方法
//主体布局
- (void)mainBody{
//    1.用户头像【重点】必须在创建第一块控件的时候约束：contentView
    self.userImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.userImageView];
//    对用户头像布局
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.bottom.equalTo(self.userImageView.mas_top).offset(50);
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.userImageView.mas_left).offset(50);
    }];

//    2.1.用户动态（昵称）
    self.lab = [[UILabel alloc] init];
    self.lab.font = [UIFont boldSystemFontOfSize:20];
    self.lab.textColor = [UIColor blackColor];
    self.lab.frame = CGRectMake(80, 20, 200, 30);
       
//    2.2.用户动态（正文）
    
    
//    2.3.用户动态（图片）
//    由于图片数量此时不能确定，赋值后再添加
    
//    4.评论按钮
    //评论或点赞的按钮(多功能按钮)
    self.commentBtn = [[UIButton alloc] init];
    [self.commentBtn setBackgroundImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    self.commentBtn.layer.masksToBounds = YES;
    self.commentBtn.layer.cornerRadius = 5;
    [self.commentBtn addTarget:self action:@selector(Comment) forControlEvents:UIControlEventTouchUpInside];//还没写
    [self.yyTextLab addSubview:self.commentBtn];
    
//    设置YYText属性
    self.yyTextLab.numberOfLines = 0;  //设置多行
    self.yyTextLab.preferredMaxLayoutWidth = SCREEN_WIDTH *0.8; //这个属性必须设置，多行才有效
    self.yyTextLab.textAlignment = NSTextAlignmentLeft;
//    对用户动态进行布局
    [self.contentView addSubview:self.yyTextLab];
    //动态约束
    [self.yyTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView);
        make.left.equalTo(self.userImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.bottom.equalTo(self.contentView).with.offset(-25);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.yyTextLab).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.size.mas_equalTo(CGSizeMake(35, 25));
    }];
}


//有评论时
- (void)yesCom{
    
}

- (void)Comment{
    
}

#pragma mark - 设置图片
- (void)setupImg{
    
        for (int i = 0; i < self.finds.imagesArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.finds.imagesArray[i]]];

            imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH/4.5, SCREEN_WIDTH/4.5);
    
            //图片拉伸
            imageView.clipsToBounds = YES;
            [imageView setContentMode:UIViewContentModeScaleAspectFill];

            NSMutableAttributedString *imageAtt = [[NSMutableAttributedString alloc] init];

            imageAtt = [NSMutableAttributedString
                yy_attachmentStringWithContent:imageView
                contentMode:UIViewContentModeScaleAspectFill
                attachmentSize:imageView.frame.size
                alignToFont:[UIFont systemFontOfSize:20]
                alignment:YYTextVerticalAlignmentBottom];
            [self.maintext appendAttributedString:imageAtt];
//            每3张图片换行
            if (i == 2||i == 5||i == self.finds.imagesArray.count - 1) {
                NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc] initWithString:@"\n"];
                textAtt.yy_font = [UIFont systemFontOfSize:20];
                [self.maintext appendAttributedString:textAtt];
            }
        }
}

@end

