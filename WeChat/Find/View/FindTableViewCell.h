//
//  FindTableViewCell.h
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "YYText.h"  //富文本布局工具
NS_ASSUME_NONNULL_BEGIN

@interface FindTableViewCell : UITableViewCell

@property (nonatomic, strong) FindModel *finds;
#pragma mark - 不同高度设置
///只有内容的的高度
@property (nonatomic, assign) CGFloat singleHeight;

///有点赞的高度
@property (nonatomic, assign) CGFloat likesHeight;

///有评论的高度
@property (nonatomic, assign) CGFloat commentsHeight;

///cell总高度
@property (nonatomic, assign) CGFloat cellHeight;

///不包括头像在内的最大宽度
@property (nonatomic, assign) CGSize maxSize;

///评论的高度
@property (nonatomic, assign) CGFloat singleCommentsHeight;


//@property (nonatomic, weak) id <MomentsCellDelegate> cellDelegate;

/// 设置数据
/// @param avatarImageViewData 头像数据
/// @param name 名字
/// @param text 正文内容
/// @param imagesArray 图片
/// @param dateText 发布时间
/// @param likesTextArray 点赞人数组
/// @param commentsTextArray 评论数组
/// @param index cell标号

@end

NS_ASSUME_NONNULL_END
