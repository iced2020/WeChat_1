//
//  FindModel.h
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindModel : NSObject

//昵称头像
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;

//正文文字
@property (nonatomic, copy) NSString *text;

//图片数组
@property (nonatomic, strong) NSArray *imagesArray;

///评论情况
@property (nonatomic, strong) NSMutableArray <NSString *> *commentsTextArray;

///查看该cell的标号，用于判断是否为自己发布的朋友圈
@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
