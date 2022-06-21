//
//  FindModel.h
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindData : NSObject

@property int localID;
@property(retain) NSString *content;
@property(retain) NSDate *createTime;
@property(retain) NSDate *modifiedTime;

//获取数据库路径
+ (NSString *)getFilePath;

///创建数据库
- (BOOL)creatWCDBData;

@end

NS_ASSUME_NONNULL_END
