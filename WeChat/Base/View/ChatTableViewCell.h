//
//  ChatTableViewCell.h
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/13.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *sayLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) PersonModel *chat;
@end

NS_ASSUME_NONNULL_END
