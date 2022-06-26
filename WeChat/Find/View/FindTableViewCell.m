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

///自己发的朋友圈的删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;

//评论或点赞的按钮(多功能按钮)
@property (nonatomic, strong) UIButton *likeOrCommentBtn;

//第一个YYLabel：动态信息
@property (nonatomic, strong) YYLabel *yyTextLab;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) NSMutableAttributedString *nameAtt;
@property (nonatomic, strong) NSMutableAttributedString *textAtt;
@property (nonatomic, strong) NSMutableAttributedString *maintext;
//第二个YYLabel：点赞信息
@property (nonatomic, strong) YYLabel *yylikesLab;

//分割线
@property (nonatomic, strong) UIView *separator;

//第三个YYLabel：评论信息
@property (nonatomic, strong) YYLabel *yyCommentsLab;

//点赞情况
@property (nonatomic, strong) NSMutableArray <NSString *> *likesTextArray;

//评论情况
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
            attachmentSize:CGSizeMake(SCREEN_WIDTH - Right - LeftAndRightMargin, 30)  //图片占位符
            alignToFont:[UIFont systemFontOfSize:20]
            alignment:YYTextVerticalAlignmentBottom
        ];
        self.textAtt = [[NSMutableAttributedString alloc] initWithString:@"用户1动态用户1动态用户1动态用户1动态用户1动态用户1动态用户1动态用户1动态用户1动态用户1动态用户1动态2222"];
        self.textAtt.yy_font = [UIFont systemFontOfSize:18];
        self.textAtt.yy_color = [UIColor darkGrayColor];
        self.maintext = [NSMutableAttributedString new];
        [self.maintext appendAttributedString:self.nameAtt];
        [self.maintext appendAttributedString:self.textAtt];
        self.yyTextLab.attributedText = self.maintext;
        }
}
    //注意：这里不能写成 self.tLable = tLable;
    //因为这样会无限的调用自己，叫做递归；

//布局UI
- (void)setupUI{
    self.yyTextLab = [[YYLabel alloc] init];
    [self mainBody];
//    //标题 【重点】必须在创建第一块控件的时候约束：contentView
//    UILabel * labeltitle = [[UILabel alloc]init];
//    labeltitle.backgroundColor = [UIColor whiteColor];
//    self.labeltitle = labeltitle;
//    labeltitle.text = @"标题";
//    labeltitle.textAlignment = NSTextAlignmentLeft;
//    labeltitle.numberOfLines = 0;
//    [self.contentView addSubview:labeltitle];
//
//    unsigned long likesNumbers = self.likesTextArray.count;
//    unsigned long commentsNumbers = self.commentsTextArray.count;
//    //1.没有点赞也没有评论
//    if (likesNumbers == 0 && commentsNumbers == 0) {
//        [self noLikeNoCom];
//    }
//    //2.有点赞没评论
//    if (likesNumbers != 0 && commentsNumbers == 0) {
//        [self likeNoCom];
//    }
//    //3.有评论没有点赞
//    if (likesNumbers == 0 && commentsNumbers != 0) {
//        [self noLikeButCom];
//    }
//    //3.有点赞有评论(有分割线）
//    if (likesNumbers != 0 && commentsNumbers != 0) {
//        [self likeAndCom];
//    }
//
//
//    //大图
//    UIImageView *pictureView = [[UIImageView alloc]init];
//    self.pictureView = pictureView;
//    pictureView.image = [UIImage imageNamed:@"A"];
//    pictureView.contentMode = UIViewContentModeScaleAspectFill;
//    pictureView.clipsToBounds = YES;
//    [self.contentView addSubview:pictureView];
//
    //内容
//    UILabel * labelContont = [[UILabel alloc]init];
//    labelContont.backgroundColor = [UIColor whiteColor];
//    self.labelContont = labelContont;
//    labelContont.text = @"内容";
//    labelContont.textAlignment = NSTextAlignmentLeft;
//    labelContont.numberOfLines = 0;
//    labelContont.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actionbutton)];
//    [labelContont addGestureRecognizer:tap];
//    [self.contentView addSubview:labelContont];
//
//    //标题约束
//    [labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).with.offset(15);
//        make.left.equalTo(self.contentView).with.offset(10);
//        make.right.equalTo(self.contentView).with.offset(-10);
//    }];
//
//    [self setImgPosition];
//
    //设置内容约束  //内容 【重点】必须在创建最后一块控件的时候约束：contentView
//    [labelContont mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.yyTextLab.mas_bottom).with.offset(20);
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.bottom.equalTo(self.contentView).with.offset(-10);
//    }];
}

//点击事件
- (void)Actionbutton{
    NSLog(@"点击了内容");
}

//对图片位置单独设置布局
- (void)setImgPosition {
    //图片约束
//    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.labeltitle.mas_bottom).with.offset(20);
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
////        make.height.mas_equalTo(200);
//    }];
}


#pragma mark - 不同情况相同布局
- (void)mainBody{
//    1.用户头像【重点】必须在创建第一块控件的时候约束：contentView
    self.userImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.userImageView];
//    对用户头像布局
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.bottom.equalTo(self.userImageView.mas_top).offset(60);
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.userImageView.mas_left).offset(60);
    }];

//    2.1.用户动态（昵称）
    self.lab = [[UILabel alloc] init];
    self.lab.font = [UIFont boldSystemFontOfSize:20];
    self.lab.textColor = [UIColor blackColor];
    self.lab.frame = CGRectMake(Right, TopAndBottomMargin, SCREEN_WIDTH - Right - LeftAndRightMargin, 30);
       
//    2.2.用户动态（正文）

    
////    2.3.用户动态（图片）
//    for (int i = 0; i < self.finds.imagesArray.count; i++) {
//        UIImageView *imageView = [self getImageView:i];
//        if (self.finds.imagesArray.count == 1) {
//            imageView.frame = [self oneImageFit:imageView];
//        }else {
//            //九宫格最大宽高 35:多功能按钮的宽，5:多功能按钮右间距 10:图片间隔总和
//            CGFloat maxSize = (SCREEN_WIDTH - Right - LeftAndRightMargin - 35 - 5 - 10) / 3;
//            imageView.frame = CGRectMake(0, 0, maxSize, maxSize);
//        }
//
//        //图片宽高适配
//        imageView.clipsToBounds = YES;
//        [imageView setContentMode:UIViewContentModeScaleAspectFill];
//
//        NSMutableAttributedString *imageAtt = [[NSMutableAttributedString alloc] init];
//        //正常情况，一张图片的占位符应该是该图片本身的size
//        imageAtt =
//        [NSMutableAttributedString
//            yy_attachmentStringWithContent:imageView
//            contentMode:UIViewContentModeLeft
//            attachmentSize:CGSizeMake(imageView.frame.size.width + 5, imageView.frame.size.height + 5) //图片占位符
//            alignToFont:[UIFont systemFontOfSize:20]
//            alignment:YYTextVerticalAlignmentBottom];
//        [maintext appendAttributedString:imageAtt];
//        //最后一张时需要回车换行
//        if (i == self.finds.imagesArray.count - 1) {
//            NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
//            textAtt.yy_font = [UIFont systemFontOfSize:20];
//            [maintext appendAttributedString:textAtt];
//        }
//    }
    
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
        make.bottom.equalTo(self.contentView).with.offset(-15);
    }];
}


#pragma mark - 不同情况不同布局
- (void)noLikeNoCom{
    
}

- (void)likeNoCom{
    
}

- (void)noLikeButCom{
    
}

- (void)likeAndCom{
    
}


@end

