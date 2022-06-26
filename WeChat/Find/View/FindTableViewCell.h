//
//  FindTableViewCell.h
//  WeChat
//
//  Created by 潘申冰 on 2022/6/21.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "YYText.h"  //富文本布局工具
NS_ASSUME_NONNULL_BEGIN

@interface FindTableViewCell : UITableViewCell

@property (nonatomic, strong) FindModel *finds;

@end

NS_ASSUME_NONNULL_END
