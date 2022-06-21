//
//  FindModel.m
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import "FindData.h"
#import "FindData+WCTTableCoding.h"

@implementation FindData{
    
}

// 利用这个宏定义绑定到表的类
WCDB_IMPLEMENTATION(FindData)

// 下面四个宏定义绑定到表中的字段
WCDB_SYNTHESIZE(FindData, localID)
WCDB_SYNTHESIZE(FindData, content)
WCDB_SYNTHESIZE(FindData, createTime)
WCDB_SYNTHESIZE(FindData, modifiedTime)

// 约束宏定义数据库的主键
WCDB_PRIMARY(FindData, localID)

// 定义数据库的索引属性，它直接定义createTime字段为索引
// 同时 WCDB 会将表名 + "_index" 作为该索引的名称
WCDB_INDEX(FindData, "_index", createTime)
//
//
/////获取数据库路径
//+ (NSString *)getFilePath {
//    //获取沙盒根目录
//       NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//       
//       // 文件路径
//       NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
//       NSLog(@"path = %@",filePath);
//
//    return filePath;
//}
//
//- (BOOL)creatWCDBData{
//    dataBase = [[WCTDatabase alloc] initWithPath:[AvatarDatabaseManager wcdbFilePath]];
//    if ([dataBase canOpen]) {
//        if ([dataBase isOpened]) {
//            if ([dataBase isTableExists:AvatarTableName]) {
//                NSLog(@"表格已存在");
//                return NO;
//            }else {
//                return [dataBase createTableAndIndexesOfName:AvatarTableName withClass:AvatarDatabase.class];
//            }
//        }
//    }
//    return NO;
//}
@end
