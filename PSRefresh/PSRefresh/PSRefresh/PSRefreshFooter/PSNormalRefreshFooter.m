//
//  PSNormalRefreshFooter.m
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PSNormalRefreshFooter.h"

@interface PSNormalRefreshFooter ()

@property (nonatomic, copy) PSRefreshClosure closure;

@end

@implementation PSNormalRefreshFooter

+ (instancetype)footer {
    return [[PSNormalRefreshFooter alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isLastPage = NO;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:kContentSizeKey context:nil];
    [self.superview removeObserver:self forKeyPath:kContentOffsetKey context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.size = CGSizeMake(kPSRefreshControlWidth, newSuperview.height);
        if (self.scrollView.contentSize.width >= self.scrollView.width) {
            self.left = self.scrollView.contentSize.width;
        } else {
            self.left = self.scrollView.width;
        }
        self.top = 0;
        
        self.originInsets = self.scrollView.contentInset;
        self.state = PSRefreshStatePullCanRefresh;
        self.statusLabel.text = self.pullCanRefreshText;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentSizeKey]) {
        // 刷新完成后调整控件位置
        if (self.scrollView.contentSize.width >= self.scrollView.width) {
            self.left = self.scrollView.contentSize.width;
        } else {
            self.left = self.scrollView.width;
        }
    } else if ([keyPath isEqualToString:kContentOffsetKey]) {
        if (self.state == PSRefreshStateRefreshing || self.state == PSRefreshStateNoMoreData) {
            return;
        }
        // 调整控件状态
        [self reloadStateWithContentOffsetX];
    }
}

- (void)reloadStateWithContentOffsetX {
    // 当前偏移量
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    // 刚好出现刷新footer的偏移量
    CGFloat appearOffsetX = self.scrollView.contentSize.width - self.scrollView.width;
    // 松开即可刷新的偏移量
    CGFloat releaseToRefreshOffsetX = appearOffsetX + self.width;
    
    // 如果是向下滚动，看不到尾部footer，直接return
    if (contentOffsetX <= appearOffsetX) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        // 拖拽的百分比
        self.pullingPercent = (contentOffsetX - appearOffsetX) / self.width;
        
        if (self.state == PSRefreshStatePullCanRefresh && contentOffsetX > releaseToRefreshOffsetX) {
            // 转为松开即可刷新状态
            self.state = PSRefreshStateReleaseCanRefresh;
        } else if (self.state == PSRefreshStateReleaseCanRefresh && contentOffsetX <= releaseToRefreshOffsetX) {
            // 转为拖拽可以刷新状态
            self.state = PSRefreshStatePullCanRefresh;
        }
    } else if (self.state == PSRefreshStateReleaseCanRefresh && !self.scrollView.isDragging) {
        // 开始刷新
        self.state = PSRefreshStateRefreshing;
        self.pullingPercent = 1.f;
        
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.right += self.width;
        self.scrollView.contentInset = insets;
        
        // 回调
        BLOCK_EXE(_closure)
    } else {
        self.pullingPercent = (contentOffsetX - appearOffsetX) / self.width;
    }
}

- (void)setState:(PSRefreshState)state {
    [super setState:state];
    
    switch (state) {
        case PSRefreshStatePullCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            self.imageView.image = [UIImage imageNamed:@"arrow.png"];
            [UIView animateWithDuration:kPSRefreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(0);
            }];
            break;
        }
        case PSRefreshStateReleaseCanRefresh: {
            self.imageView.hidden = NO;
            self.activityView.hidden = YES;
            [UIView animateWithDuration:kPSRefreshFastAnimationDuration animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            break;
        }
        case PSRefreshStateRefreshing: {
            self.imageView.hidden = YES;
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
            break;
        }
        case PSRefreshStateNoMoreData: {
            self.imageView.hidden = YES;
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
            break;
        }
    }
}

- (void)endRefreshing {
    [UIView animateWithDuration:kPSRefreshFastAnimationDuration animations:^{
        self.scrollView.contentInset = self.originInsets;        
    }];
    if (self.state == PSRefreshStateNoMoreData) {
        return;
    }
    self.state = PSRefreshStatePullCanRefresh;
}

- (void)addRefreshFooterWithClosure:(PSRefreshClosure)closure {
    self.closure = closure;
}

- (void)setIsLastPage:(BOOL)isLastPage {
    _isLastPage = isLastPage;
    if (_isLastPage) {
        self.state = PSRefreshStateNoMoreData;
    } else {
        self.state = PSRefreshStatePullCanRefresh;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
