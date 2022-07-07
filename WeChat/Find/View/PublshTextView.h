//
//  PublshTextView.h
//  WeChat
//
//  Created by 潘申冰 on 2022/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublshTextView : UITextView <UITextViewDelegate>
//提示文字
@property (nonatomic, copy) NSString *placehoder;
//提示文字颜色
@property (nonatomic, strong) UIColor *placehoderColor;

@property (nonatomic, weak) UILabel *placehoderLabel;

@end

NS_ASSUME_NONNULL_END
