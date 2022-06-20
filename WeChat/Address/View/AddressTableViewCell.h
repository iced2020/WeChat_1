//
//  AddressTableViewCell.h
//  WeChat_v1
//
//  Created by 潘申冰 on 2022/6/17.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) AddressModel *address;

@end

NS_ASSUME_NONNULL_END
