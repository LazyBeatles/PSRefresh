//
//  PSBaseRefreshControl.m
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PSBaseRefreshControl.h"

@implementation PSBaseRefreshControl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.state = PSRefreshStatePullCanRefresh;
        [self addSubview:self.statusLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.activityView];
        
        self.stateLabelHidden = NO;
        
        WeakSelf(self)
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.statusLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerX.equalTo(weakSelf);
        }];
        
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.imageView);
        }];        
    }
    return self;
}

- (void)endRefreshing {

}

- (void)reloadDataWithState {
    switch (self.state) {
        case PSRefreshStatePullCanRefresh: {
            self.statusLabel.text = self.pullCanRefreshText;
            break;
        }
        case PSRefreshStateReleaseCanRefresh: {
            self.statusLabel.text = self.releaseCanRefreshText;
            break;
        }
        case PSRefreshStateRefreshing: {
            self.statusLabel.text = self.refreshingText;
            break;
        }
        case PSRefreshStateNoMoreData: {
            self.statusLabel.text = self.noMoreDataText;
            break;
        }
    }
}

- (void)setTitle:(NSString *)title forState:(PSRefreshState)state {
    if (!title) {
        return;
    }
    NSString *linefeedsTitle = [[title copy] insertLinefeeds];
    switch (state) {
        case PSRefreshStatePullCanRefresh: {
            self.pullCanRefreshText = linefeedsTitle;
            break;
        }
        case PSRefreshStateReleaseCanRefresh: {
            self.releaseCanRefreshText = linefeedsTitle;
            break;
        }
        case PSRefreshStateRefreshing: {
            self.refreshingText = linefeedsTitle;
            break;
        }
        case PSRefreshStateNoMoreData: {
            self.noMoreDataText = linefeedsTitle;
            break;
        }
    }
}

#pragma mark -
#pragma mark - setter methods
- (void)setState:(PSRefreshState)state {
    _state = state;
    [self reloadDataWithState];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.statusLabel.textColor = _textColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.statusLabel.font = font;
}

- (void)setStateLabelHidden:(BOOL)stateLabelHidden {
    _stateLabelHidden = stateLabelHidden;
    self.statusLabel.hidden = stateLabelHidden;
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont boldSystemFontOfSize:13];
        _statusLabel.textColor = [UIColor lightTextColor];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.numberOfLines = 0;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation NSString (PSRefresh)

- (NSString *)insertLinefeeds {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.length; i ++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        [string appendString:str];
        if (i != self.length - 1) { // 最后一位不加 '\n'
            [string appendString:@"\n"];            
        }
    }
    return string;
}

@end

