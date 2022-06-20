//
//  AddressModel.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/17.
//

#import "AddressModel.h"

@implementation AddressModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)provinceWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
