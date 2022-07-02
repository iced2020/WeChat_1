//
//  FindModel.m
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import "FindModel.h"
#import <WCDB/WCDB.h>

WCTDatabase *findDB;

@interface FindModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(name)
WCDB_PROPERTY(img)

@end

@implementation FindModel

WCDB_IMPLEMENTATION(FindModel)

WCDB_SYNTHESIZE(FindModel, name)
WCDB_SYNTHESIZE(FindModel, img)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        findDB = [[WCTDatabase alloc] initWithPath:FindModel.databasePath];
        [findDB createTableAndIndexesOfName:FindModel.tableName withClass:self];
    });
}

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

#pragma mark - Getter

+ (NSString *)databasePath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)tableName {
    return @"Finder";
}

#pragma mark - WCDB

- (void)save {
    [findDB insertObject:self into:FindModel.tableName];
}

+ (NSArray *)allObj {
    return [findDB getAllObjectsOfClass:self.class fromTable:FindModel.tableName];
}

@end
