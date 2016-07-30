//
//  PSGifRefreshHeader.m
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PSGifRefreshHeader.h"

@interface PSGifRefreshHeader ()

@property (nonatomic, strong) NSMutableDictionary *imagesDic;

@end

@implementation PSGifRefreshHeader

+ (instancetype)header {
    return [[PSGifRefreshHeader alloc] init];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.imageView removeFromSuperview];
    [self.activityView removeFromSuperview];
    
    self.gifImageView = [[UIImageView alloc] init];
    self.gifImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.gifImageView];
    
    self.gifImageView.frame = self.bounds;
    
    if (!self.stateLabelHidden) {
        self.gifImageView.center = CGPointMake(self.width / 2, self.height / 2 + 120);
    }
}

- (void)setState:(PSRefreshState)state {
    if (self.state == state) { return; }
    [super setState:state];
    
    NSArray *images = self.imagesDic[@(state)];
    switch (state) {
        case PSRefreshStatePullCanRefresh: {
            [self.gifImageView stopAnimating];
            self.gifImageView.hidden = NO;
            break;
        }
        case PSRefreshStateReleaseCanRefresh:
        case PSRefreshStateRefreshing: {
            [self.gifImageView stopAnimating];
            if (images.count == 1) {
                self.gifImageView.image = images.lastObject;
            } else {
                self.gifImageView.animationImages = images;
                self.gifImageView.animationDuration = images.count * 0.1;
                [self.gifImageView startAnimating];
            }
            break;
        }
        case PSRefreshStateNoMoreData: {
            self.gifImageView.hidden = YES;
            self.stateLabelHidden = NO;
            [self.gifImageView stopAnimating];
            break;
        }
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.imagesDic[@(self.state)];
    switch (self.state) {
        case PSRefreshStatePullCanRefresh: {
            [self.gifImageView stopAnimating];
            NSUInteger index = images.count * self.pullingPercent;
            if (index >= images.count) index = images.count - 1;
            self.gifImageView.image = images[index];
            break;
        }
        default:
            break;
    }
}

- (void)setImages:(NSArray <UIImage *>*)images forState:(PSRefreshState)state {
    if (images == nil) { return; }
    self.imagesDic[@(state)] = images;
    
    // 根据图片设置控件的高度
    UIImage *image = images.firstObject;
    if (image.size.width > self.width) {
        self.width = image.size.width;
    }
}

- (NSMutableDictionary *)imagesDic {
    if (!_imagesDic) {
        _imagesDic = [NSMutableDictionary dictionary];
    }
    return _imagesDic;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
