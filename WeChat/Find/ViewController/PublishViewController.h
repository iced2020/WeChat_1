//
//  PublishViewController.h
//  WeChat
//
//  Created by 潘申冰 on 2022/7/6.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
#import "PublshTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublishViewController : UIViewController <UITextViewDelegate>

//回调
@property (nonatomic, strong) void(^block)(FindModel *message);

//输入框
@property (nonatomic, strong) PublshTextView *textView;
//图片位置
@property (nonatomic, strong) UIScrollView *scrollView;
//下方权限按钮
@property (nonatomic, strong) UIButton *selectBtn;
//图片数组
@property (nonatomic, strong) NSMutableArray *assets;
//图片数量
@property (nonatomic, assign) int phoneIndex;

//当前点击
@property (nonatomic, copy) NSString *index;

@end

NS_ASSUME_NONNULL_END
