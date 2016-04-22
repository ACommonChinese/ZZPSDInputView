//
//  ZZPSDInputView.h
//  ZZPSDInputViewDemo
//
//  Created by 刘威振 on 4/21/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kInputCount 6

@interface ZZPSDInputView : UIView

@property (nonatomic, copy) dispatch_block_t cancelHandler;
@property (nonatomic, copy) void (^finishHandler)(NSString *passStr);

+ (instancetype)psdInputView;

@end
