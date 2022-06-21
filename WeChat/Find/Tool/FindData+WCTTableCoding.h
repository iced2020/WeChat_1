//
//  FindModel+WCTTableCoding.h
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindData (WCTTableCoding)<WCTTableCoding>

// 需要绑定到表中的字段在这里声明，在.mm中去绑定
WCDB_PROPERTY(localID)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)
@end

NS_ASSUME_NONNULL_END
