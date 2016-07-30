//
//  PSGifRefreshHeader.h
//  PSRefresh
//
//  Created by 雷亮 on 16/7/9.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PSNormalRefreshHeader.h"

@interface PSGifRefreshHeader : PSNormalRefreshHeader

+ (instancetype)header;

- (void)setImages:(NSArray <UIImage *>*)images forState:(PSRefreshState)state;

@end
