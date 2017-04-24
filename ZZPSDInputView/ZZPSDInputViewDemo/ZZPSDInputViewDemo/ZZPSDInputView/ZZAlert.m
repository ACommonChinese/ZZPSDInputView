//
//  ZZActionSheet.m
//  ZZPSDInputViewDemo
//
//  Created by 刘威振 on 4/21/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ZZAlert.h"

@interface ZZAlert ()

@property (nonatomic) CGRect originFrame;
@end

@implementation ZZAlert

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
}

- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    if (self.animationStyle == ZZAlert.animationStyleActionSheet) {
        NSAssert(self.contentView, @"The contentView must not be nil");
        NSAssert(self.contentView.frame.size.width == self.bounds.size.width, @"The contentView's width must be same as window, may be you should try animationStyle = LBAlertAnimationStyleTransform?");
        CGRect frame = self.contentView.frame;
        self.originFrame = frame;
        frame.origin.y = self.bounds.size.height;
        self.contentView.frame = frame;
        [self addSubview:self.contentView];
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = self.originFrame;
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        } completion:^(BOOL finished) {}];
    } else {
        self.contentView.center = self.center;
        [self addSubview:self.contentView];
        
        self.contentView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        } completion:^(BOOL finished) {}];
    }
}

- (void)dismiss {
    return [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(dispatch_block_t)completion {
    if (self.animationStyle == ZZAlert.animationStyleActionSheet) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.originFrame;
            frame.origin.y = self.bounds.size.height;
            self.contentView.frame = frame;
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (completion) {
                completion();
            }
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(0.2, 0.2);
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (completion) {
                completion();
            }
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.dismissWhenTouchBlank) {
        [self dismiss];
    }
}

+ (NSInteger)animationStyleActionSheet {
    return 0;
}

+ (NSInteger)animationStyleTransform {
    return 1;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
