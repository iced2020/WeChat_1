//
//  PersonModel.h
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *say;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
