//
//  ViewController.m
//  ZZPSDInputViewDemo
//
//  Created by 刘威振 on 4/21/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

#import "ZZPSDInputView.h"
#import "ZZActionSheet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (IBAction)test_1:(id)sender {
    ZZActionSheet *sheet        = [[ZZActionSheet alloc] init];
    sheet.dismissWhenTouchBlank = YES;
    
    ZZPSDInputView *psdView     = [ZZPSDInputView psdInputView];
    psdView.backgroundColor     = [UIColor whiteColor];
    __weak __typeof(self) weakSelf = self;
    __weak __typeof(sheet) weakSheet = sheet;
    psdView.cancelHandler = ^() {
        [weakSheet dismiss];
    };
    psdView.finishHandler = ^(NSString *passStr) {
        // [weakSheet dismiss];
        [weakSheet dismissWithCompletion:^{
            NSLog(@"完成: %@", passStr);
            weakSelf.infoLabel.text = passStr;
        }];
    };
    
    sheet.contentView = psdView;
    [sheet show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
