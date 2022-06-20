//
//  MineModel.m
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/20.
//

#import "ListModel.h"

@implementation ListModel

+ (instancetype)setWithimage:(NSString *)image title:(NSString *)title{
    ListModel *List = [[self alloc]init];
    List.image = image;
    List.title = title;
    return List;
}

@end
