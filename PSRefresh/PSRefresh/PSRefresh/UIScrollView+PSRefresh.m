//
//  UIScrollView+PSRefresh.m
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UIScrollView+PSRefresh.h"
#import <objc/runtime.h>

@interface UIScrollView ()

@property (nonatomic, strong) PSNormalRefreshHeader *header;
@property (nonatomic, strong) PSNormalRefreshFooter *footer;
@property (nonatomic, strong) PSGifRefreshHeader *gifHeader;
@property (nonatomic, strong) PSGifRefreshFooter *gifFooter;

@end

@implementation UIScrollView (PSRefresh)

YYSYNTH_DYNAMIC_PROPERTY_OBJECT(header, setHeader, RETAIN_NONATOMIC, PSNormalRefreshHeader *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(footer, setFooter, RETAIN_NONATOMIC, PSNormalRefreshFooter *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(gifHeader, setGifHeader, RETAIN_NONATOMIC, PSGifRefreshHeader *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(gifFooter, setGifFooter, RETAIN_NONATOMIC, PSGifRefreshFooter *)

- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)closure {
    if (!self.header && !self.gifHeader) {
        self.header = [PSNormalRefreshHeader header];
        [self.header setTitle:@"右拉即可刷新" forState:PSRefreshStatePullCanRefresh];
        [self.header setTitle:@"松开即可刷新" forState:PSRefreshStateReleaseCanRefresh];
        [self.header setTitle:@"正在为您刷新" forState:PSRefreshStateRefreshing];
        [self addSubview:self.header];
        [self.header addRefreshHeaderWithClosure:closure];
    }
}

- (void)addRefreshFooterWithClosure:(PSRefreshClosure)closure {
    if (!self.footer && !self.gifFooter) {
        self.footer = [PSNormalRefreshFooter footer];
        [self.footer setTitle:@"左拉即可加载" forState:PSRefreshStatePullCanRefresh];
        [self.footer setTitle:@"松开即可加载" forState:PSRefreshStateReleaseCanRefresh];
        [self.footer setTitle:@"正在为您加载" forState:PSRefreshStateRefreshing];
        [self.footer setTitle:@"已经是最后一页" forState:PSRefreshStateNoMoreData];
        [self addSubview:self.footer];
        [self.footer addRefreshFooterWithClosure:closure];
    }
}

- (void)addGifRefreshHeaderWithClosure:(PSRefreshClosure)closure {
    if (!self.header && !self.gifHeader) {
        self.gifHeader = [PSGifRefreshHeader header];
        // 是否隐藏状态label
        self.gifHeader.stateLabelHidden = NO;
        [self.gifHeader setTitle:@"右拉即可刷新" forState:PSRefreshStatePullCanRefresh];
        [self.gifHeader setTitle:@"松开即可刷新" forState:PSRefreshStateReleaseCanRefresh];
        [self.gifHeader setTitle:@"正在为您刷新" forState:PSRefreshStateRefreshing];
        // 这里根据自己的需求来调整图片 by liang;
        NSMutableArray *_idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            [_idleImages addObject:image];
        }
        [self.gifHeader setImages:_idleImages forState:PSRefreshStatePullCanRefresh];
        NSMutableArray *_refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [_refreshingImages addObject:image];
        }
        [self.gifHeader setImages:_refreshingImages forState:PSRefreshStateRefreshing];
        [self addSubview:self.gifHeader];
        [self.gifHeader addRefreshHeaderWithClosure:closure];
    }
}

- (void)addGifRefreshFooterWithClosure:(PSRefreshClosure)closure {
    if (!self.footer && !self.gifFooter) {
        self.gifFooter = [PSGifRefreshFooter footer];
        self.gifFooter.stateLabelHidden = NO;
        [self.gifFooter setTitle:@"左拉即可加载" forState:PSRefreshStatePullCanRefresh];
        [self.gifFooter setTitle:@"松开即可加载" forState:PSRefreshStateReleaseCanRefresh];
        [self.gifFooter setTitle:@"正在为您加载" forState:PSRefreshStateRefreshing];
        [self.gifFooter setTitle:@"已经是最后一页" forState:PSRefreshStateNoMoreData];
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            [idleImages addObject:image];
        }
        [self.gifFooter setImages:idleImages forState:PSRefreshStatePullCanRefresh];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [refreshingImages addObject:image];
        }
        [self.gifFooter setImages:refreshingImages forState:PSRefreshStateRefreshing];
        [self addSubview:self.gifFooter];
        [self.gifFooter addRefreshFooterWithClosure:closure];
    }
}

- (void)addGifRefreshHeaderNoStatusWithClosure:(PSRefreshClosure)closure {
    if (!self.header && !self.gifHeader) {
        self.gifHeader = [PSGifRefreshHeader header];
        // 是否隐藏状态label
        self.gifHeader.stateLabelHidden = YES;
        NSMutableArray *_idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            [_idleImages addObject:image];
        }
        [self.gifHeader setImages:_idleImages forState:PSRefreshStatePullCanRefresh];
        NSMutableArray *_refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [_refreshingImages addObject:image];
        }
        [self.gifHeader setImages:_refreshingImages forState:PSRefreshStateRefreshing];
        [self addSubview:self.gifHeader];
        [self.gifHeader addRefreshHeaderWithClosure:closure];
    }
}

- (void)addGifRefreshFooterNoStatusWithClosure:(PSRefreshClosure)closure {
    if (!self.footer && !self.gifFooter) {
        self.gifFooter = [PSGifRefreshFooter footer];
        self.gifFooter.stateLabelHidden = YES;
        [self.gifFooter setTitle:@"已经是最后一页" forState:PSRefreshStateNoMoreData];
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            [idleImages addObject:image];
        }
        [self.gifFooter setImages:idleImages forState:PSRefreshStatePullCanRefresh];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [refreshingImages addObject:image];
        }
        [self.gifFooter setImages:refreshingImages forState:PSRefreshStateRefreshing];
        [self addSubview:self.gifFooter];
        [self.gifFooter addRefreshFooterWithClosure:closure];
    }
}

- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(PSRefreshClosure)footerClosure {
    [self addRefreshHeaderWithClosure:headerClosure];
    [self addRefreshFooterWithClosure:footerClosure];
}

- (void)addGifRefreshHeaderWithClosure:(PSRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(PSRefreshClosure)footerClosure {
    [self addGifRefreshHeaderWithClosure:headerClosure];
    [self addGifRefreshFooterWithClosure:footerClosure];
}

- (void)addGifRefreshHeaderNoStatusWithClosure:(PSRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(PSRefreshClosure)footerClosure {
    [self addGifRefreshHeaderNoStatusWithClosure:headerClosure];
    [self addGifRefreshFooterNoStatusWithClosure:footerClosure];
}

- (void)endRefreshing {
    if (self.header) { [self.header endRefreshing]; }
    if (self.footer) { [self.footer endRefreshing]; }
    if (self.gifHeader) { [self.gifHeader endRefreshing]; }
    if (self.gifFooter) { [self.gifFooter endRefreshing]; }
}

- (void)setIsLastPage:(BOOL)isLastPage {
    if (self.footer) {
        self.footer.isLastPage = isLastPage;
        return;
    }
    self.gifFooter.isLastPage = isLastPage;
}

- (BOOL)isLastPage {
    if (self.footer) {
        return self.footer.isLastPage;
    }
    return self.gifFooter.isLastPage;
}

- (void)setRefreshHeaderBackgroundColor:(UIColor *)refreshHeaderBackgroundColor {
    if (self.header) {
        self.header.backgroundColor = refreshHeaderBackgroundColor;
    }
    if (self.gifHeader) {
        self.gifHeader.backgroundColor = refreshHeaderBackgroundColor;
    }
}

- (UIColor *)refreshHeaderBackgroundColor {
    if (self.header) {
        return self.header.backgroundColor;
    }
    if (self.gifHeader) {
        return self.gifHeader.backgroundColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshFooterBackgroundColor:(UIColor *)refreshFooterBackgroundColor {
    if (self.footer) {
        self.footer.backgroundColor = refreshFooterBackgroundColor;
    }
    if (self.gifFooter) {
        self.gifFooter.backgroundColor = refreshFooterBackgroundColor;
    }
}

- (UIColor *)refreshFooterBackgroundColor {
    if (self.footer) {
        return self.footer.backgroundColor;
    }
    if (self.gifFooter) {
        return self.gifFooter.backgroundColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshHeaderFont:(UIFont *)refreshHeaderFont {
    if (self.header) {
        self.header.font = refreshHeaderFont;
    }
    if (self.gifHeader) {
        self.gifHeader.font = refreshHeaderFont;
    }
}

- (UIFont *)refreshHeaderFont {
    if (self.header) {
        return self.header.font;
    }
    if (self.gifHeader) {
        return self.gifHeader.font;
    }
    return [UIFont systemFontOfSize:13];
}

- (void)setRefreshHeaderTextColor:(UIColor *)refreshHeaderTextColor {
    if (self.header) {
        self.header.textColor = refreshHeaderTextColor;
    }
    if (self.gifHeader) {
        self.gifHeader.textColor = refreshHeaderTextColor;
    }
}

- (UIColor *)refreshHeaderTextColor {
    if (self.header) {
        return self.header.textColor;
    }
    if (self.gifHeader) {
        return self.gifHeader.textColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshFooterFont:(UIFont *)refreshFooterFont {
    if (self.footer) {
        self.footer.font = refreshFooterFont;
    }
    if (self.gifFooter) {
        self.gifFooter.font = refreshFooterFont;
    }
}

- (UIFont *)refreshFooterFont {
    if (self.footer) {
        return self.footer.font;
    }
    if (self.gifFooter) {
        return self.gifFooter.font;
    }
    return [UIFont systemFontOfSize:13];
}

- (void)setRefreshFooterTextColor:(UIColor *)refreshFooterTextColor {
    if (self.footer) {
        self.footer.textColor = refreshFooterTextColor;
    }
    if (self.gifFooter) {
        self.gifFooter.textColor = refreshFooterTextColor;
    }
}

- (UIColor *)refreshFooterTextColor {
    if (self.footer) {
        return self.footer.textColor;
    }
    if (self.gifFooter) {
        return self.gifFooter.textColor;
    }
    return [UIColor clearColor];
}

@end
