//
//  ZZPSDInputView.m
//  ZZPSDInputViewDemo
//
//  Created by 刘威振 on 4/21/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ZZPSDInputView.h"
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ZZPSDInputView() <UITextFieldDelegate>

@property (nonatomic) UITextField *passField;
@property (nonatomic) NSMutableArray *psdIndicatorArray;
@end

@implementation ZZPSDInputView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 400, [[UIScreen mainScreen] bounds].size.width, 400)];
    [self commonInit];
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    
    // 输入密码
    CGFloat titleHeight = 50.0f;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, titleHeight)];
    [titleLabel setText:@"输入密码"];
    titleLabel.font = [UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    // ╳
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    // exitButton.backgroundColor = [UIColor redColor];
    [exitButton setTitle:@"╳" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    // [exitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [exitButton setFrame:CGRectMake(0, 0, titleHeight, titleHeight)];
    [exitButton addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exitButton];
    
    // Horizonal line
    UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.frame.size.width, 0.5)];
    hLine.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self addSubview:hLine];
    
    // Text Field
    CGRect passFieldFrame = CGRectMake(20, CGRectGetMaxY(hLine.frame) + 15, self.frame.size.width - 40, 0);
    CGFloat length = passFieldFrame.size.width / kInputCount;
    passFieldFrame.size.height = length;
    
    self.passField                        = [[UITextField alloc] initWithFrame:passFieldFrame];
    self.passField.borderStyle            = UITextBorderStyleNone;
    self.passField.keyboardType           = UIKeyboardTypeNumberPad;
    self.passField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passField.delegate               = self;
    // self.passField.hidden              = YES;
    self.passField.tintColor              = [UIColor clearColor];
    self.passField.textColor              = [UIColor clearColor];
    self.passField.layer.masksToBounds    = YES;
    self.passField.layer.cornerRadius     = 5.0f;
    self.passField.layer.borderColor      = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor;
    self.passField.layer.borderWidth      = 0.8;
    [self addSubview:self.passField];
    [self.passField becomeFirstResponder];
    
    // 线
    for (int i = 1; i < kInputCount; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*length, 2.0, 1.0, self.passField.frame.size.height - 4.0)];
        lineView.backgroundColor = UIColorFromRGB(0xEEEEEE);
        [self.passField addSubview:lineView];
    }
    
    // 点
    CGFloat dotLength = length / 3.0;
    self.psdIndicatorArray = [NSMutableArray arrayWithCapacity:kInputCount];
    for (int i = 0; i < kInputCount; i++) {
        UIView *dotView            = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dotLength, dotLength)];
        dotView.center             = CGPointMake(i*length + length / 2.0, self.passField.frame.size.height / 2.0);
        dotView.backgroundColor    = [UIColor blackColor];
        dotView.clipsToBounds      = YES;
        dotView.layer.cornerRadius = dotLength / 2.0;
        [self.passField addSubview:dotView];
        [self.psdIndicatorArray addObject:dotView];
        dotView.hidden = YES;
    }
    
    // Notification
    __weak __typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if ([note.object isEqual:weakSelf.passField]) {
            NSUInteger length = weakSelf.passField.text.length;
            [weakSelf setDotCount:weakSelf.passField.text.length];
            if (length == kInputCount) {
                if (weakSelf.finishHandler) {
                    weakSelf.finishHandler(weakSelf.passField.text);
                }
            }
        }
    }];
}

- (void)setDotCount:(NSUInteger)count {
    for (UIView *dotView in self.psdIndicatorArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < count; i++) {
        [self.psdIndicatorArray[i] setHidden:NO];
    }
}

- (void)exit:(UIButton *)button {
    NSLog(@"exit");
    if (self.cancelHandler) {
        self.cancelHandler();
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = textField.text;
    if (text.length + string.length == kInputCount) {
        return YES;
    }
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    if (string.length == 0) {
        // 判断是不是删除键
        return YES;
    }
    if(text.length >= kInputCount) {
        return NO;
    }
    return YES;
}

+ (instancetype)psdInputView {
    ZZPSDInputView *inputView = [[ZZPSDInputView alloc] init];
    inputView.backgroundColor = [UIColor yellowColor];
    return inputView;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
