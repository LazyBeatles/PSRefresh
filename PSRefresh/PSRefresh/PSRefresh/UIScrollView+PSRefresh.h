//
//  UIScrollView+PSRefresh.h
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSGifRefreshHeader.h"
#import "PSGifRefreshFooter.h"

@interface UIScrollView (PSRefresh)

/**
 * 是否是最后一页
 */
@property (nonatomic, assign) BOOL isLastPage;

/**
 * header背景色
 */
@property (nonatomic, strong) UIColor *refreshHeaderBackgroundColor;

/**
 * footer背景色
 */
@property (nonatomic, strong) UIColor *refreshFooterBackgroundColor;

/**
 * header 字体
 */
@property (nonatomic, strong) UIFont *refreshHeaderFont;

/**
 * header 字体颜色
 */
@property (nonatomic, strong) UIColor *refreshHeaderTextColor;

/**
 * footer 字体
 */
@property (nonatomic, strong) UIFont *refreshFooterFont;

/**
 * footer 字体颜色
 */
@property (nonatomic, strong) UIColor *refreshFooterTextColor;

/**
 * ********************** 以下是调用的方法 **********************
 */
/**
 * 普通的刷新及加载
 */
- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)closure;

- (void)addRefreshFooterWithClosure:(PSRefreshClosure)closure;

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(PSRefreshClosure)closure;

- (void)addGifRefreshFooterWithClosure:(PSRefreshClosure)closure;

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(PSRefreshClosure)closure;

- (void)addGifRefreshFooterNoStatusWithClosure:(PSRefreshClosure)closure;


/**
 * ****************** 以下三个方法是对上面方法的再次封装 ******************
 */
/**
 * 普通的刷新及加载
 */
- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(PSRefreshClosure)footerClosure;

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(PSRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(PSRefreshClosure)footerClosure;

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(PSRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(PSRefreshClosure)footerClosure;

/**
 * 结束刷新
 */
- (void)endRefreshing;

@end
