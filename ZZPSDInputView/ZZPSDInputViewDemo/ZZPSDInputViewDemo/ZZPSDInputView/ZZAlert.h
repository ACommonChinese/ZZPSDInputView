//
//  ZZActionSheet.h
//  ZZPSDInputViewDemo
//
//  Created by 刘威振 on 4/21/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZAlert : UIView

/**
 * The content view that actionsheet hold
 */
@property (nonatomic) UIView *contentView;

/**
 * Dismiss when click blank area, default is NO
 */
@property (nonatomic) BOOL dismissWhenTouchBlank;

// For animation
@property (nonatomic) NSInteger animationStyle; // default is ZZAlert.animationStyleActionSheet
@property (class, nonatomic, readonly) NSInteger animationStyleActionSheet;
@property (class, nonatomic, readonly) NSInteger animationStyleTransform;

// Public APIs
- (void)show;
- (void)dismiss;
- (void)dismissWithCompletion:(dispatch_block_t)completion;

@end
