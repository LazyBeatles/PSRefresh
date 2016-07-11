//
//  PSBaseRefreshControl.h
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+PSFrame.h"
#import "Masonry.h"
#import "PSRefreshConfig.h"

typedef NS_ENUM(NSUInteger, PSRefreshState) {
    PSRefreshStatePullCanRefresh = 1, // 拖拽可以刷新状态
    PSRefreshStateReleaseCanRefresh = 2, // 松开即可刷新状态
    PSRefreshStateRefreshing = 3, // 正在刷新状态
    PSRefreshStateNoMoreData = 4, // 没有更多数据状态
};

static NSString *const kContentOffsetKey = @"contentOffset";
static NSString *const kContentSizeKey = @"contentSize";

/// 刷新控件的宽度，在这里调整
static CGFloat const kPSRefreshControlWidth = 44.0;
static CGFloat const kPSRefreshFastAnimationDuration = 0.25;
static CGFloat const kPSRefreshSlowAnimationDuration = 0.4;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * */

@interface PSBaseRefreshControl : UIView

/// 基础控件
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *gifImageView;

/**
 * 状态显示文字
 */
// 拉动可以（刷新/加载）
@property (nonatomic, copy) NSString *pullCanRefreshText;
// 松开可以（刷新/加载）
@property (nonatomic, copy) NSString *releaseCanRefreshText;
// 正在（刷新/加载）
@property (nonatomic, copy) NSString *refreshingText;
// 没有更多数据
@property (nonatomic, copy) NSString *noMoreDataText;

/// 基本属性
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

/// 状态
@property (nonatomic, assign) PSRefreshState state;
/// 父视图（scrollView）
@property (nonatomic, weak) UIScrollView *scrollView;

/// 设置状态相应文字
- (void)setTitle:(NSString *)title forState:(PSRefreshState)state;

/// 拖拽的比例
@property (nonatomic, assign) CGFloat pullingPercent;
/// 原边距
@property (nonatomic, assign) UIEdgeInsets originInsets;

- (void)endRefreshing;

/// 是否隐藏状态label，注意：如果要隐藏状态label，要先设置这个属性
@property (nonatomic, assign) BOOL stateLabelHidden;

@end

@interface NSString (PSRefresh)

- (NSString *)insertLinefeeds;

@end
