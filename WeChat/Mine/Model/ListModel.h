//
//  MineModel.h
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel: NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;

+(instancetype)setWithimage:(NSString *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
