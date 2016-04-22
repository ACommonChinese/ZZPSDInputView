//
//  ZZActionSheet.h
//  ZZPSDInputViewDemo
//
//  Created by 刘威振 on 4/21/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZActionSheet : UIView

/**
 * 内容视图
 */
@property (nonatomic) UIView *contentView;

/**
 * 点击空白处是否消失，默认NO
 */
@property (nonatomic) BOOL dismissWhenTouchBlank;

- (void)show;
- (void)dismiss;
- (void)dismissWithCompletion:(dispatch_block_t)completion;

@end
