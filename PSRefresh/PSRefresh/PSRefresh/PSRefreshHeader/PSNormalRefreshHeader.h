//
//  PSNormalRefreshHeader.h
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PSBaseRefreshControl.h"

@interface PSNormalRefreshHeader : PSBaseRefreshControl

+ (instancetype)header;

- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)closure;

@end
