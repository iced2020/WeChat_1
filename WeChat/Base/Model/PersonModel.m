//
//  PersonModel.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/15.
//

#import "PersonModel.h"

@implementation PersonModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSLog(@"😀");
        NSLog(@"😃");
        NSLog(@"😄");
        NSLog(@"😁");
    }
    return self;
}

+ (instancetype)provinceWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
