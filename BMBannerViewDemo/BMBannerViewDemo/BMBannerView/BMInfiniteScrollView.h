//
//  BMInfiniteScrollView.h
//  BMBannerViewDemo
//
//  Created by liuweizhen on 2018/10/31.
//  Copyright © 2018年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMInfiniteScrollViewProtocol <NSObject>

/**
 * @brief get target item view at index
 *
 * @param index index of item view
 * @param view the item view for re-use
 * @return item view
 */
- (UIView *)itemViewForIndex:(NSInteger)index reusableItemView:(UIView *)view;

/**
 * @brief amount of cycle item views
 *
 * @return amount
 */
- (NSInteger)itemViewsCount;

@end

@interface BMInfiniteScrollView : UIScrollView

/// the datasource for scrollview to show item views
@property (nonatomic, weak) id<BMInfiniteScrollViewProtocol> dataSource;

/// enable infinite cycle or not, YES as default
@property (nonatomic, assign, getter=isEnableInfinite) BOOL enableInfinite;

/// current item view
@property (readonly, weak, nonatomic) UIView *currentContentView;

/// current item view index
@property (nonatomic, assign, readonly) NSInteger currentIndex;

/**
 * @brief slide to next item view
 */
- (void)slideNext;

/**
 * slide to previous item view
 */
- (void)slidePrevious;

/**
 * reload item views
 */
- (void)reloadData;

@end
