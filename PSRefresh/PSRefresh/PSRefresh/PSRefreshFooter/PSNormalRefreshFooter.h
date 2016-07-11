//
//  PSNormalRefreshFooter.h
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PSBaseRefreshControl.h"

@interface PSNormalRefreshFooter : PSBaseRefreshControl

+ (instancetype)footer;

// 如果是最后一页，则禁止刷新动作
@property (nonatomic, assign) BOOL isLastPage;

- (void)addRefreshFooterWithClosure:(PSRefreshClosure)closure;

@end
