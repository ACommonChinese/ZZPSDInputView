//
//  BMInfiniteScrollView.m
//  BMBannerViewDemo
//
//  Created by liuweizhen on 2018/10/31.
//  Copyright © 2018年 liuxing8807@126.com. All rights reserved.
//

#import "BMInfiniteScrollView.h"

@implementation BMInfiniteScrollView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.dataSource itemViewsCount] <= 0) {
        return;
    }
    if (self.isEnableInfinite) {
        
    }
}

@end
