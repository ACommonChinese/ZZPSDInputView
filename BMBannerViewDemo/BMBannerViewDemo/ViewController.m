//
//  ViewController.m
//  BMBannerViewDemo
//
//  Created by liuweizhen on 2018/10/31.
//  Copyright © 2018年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "PowerfulBannerView.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet PowerfulBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self testXibBannerView];
    // [self testBannerView];
    // [self testScrollViewBounds];
}

- (void)testXibBannerView {
    self.bannerView.items = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    self.bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        UILabel *label = (UILabel *)reusableView;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textColor = [UIColor whiteColor];
            label.contentMode = UIViewContentModeScaleAspectFit;
            label.font = [UIFont boldSystemFontOfSize:30];
            label.textAlignment = NSTextAlignmentCenter;
        }
        if ([self.bannerView.items indexOfObject:item] % 2 == 0) {
            label.backgroundColor = [UIColor blackColor];
        }
        else {
            label.backgroundColor = [UIColor redColor];
        }
        label.text = item;
        return label;
    };
}

- (void)testScrollViewBounds {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 200)];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    [scrollView setContentSize:CGSizeMake(2*(self.view.frame.size.width-20), 200)];
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"------- offset.x: %lf, ======= bounds.origin.x: %lf", scrollView.contentOffset.x, scrollView.bounds.origin.x); // 这两个值是相等的
}

- (void)testBannerView {
    PowerfulBannerView *bannerView = [[PowerfulBannerView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 200)];
     //bannerView.autoLooping = YES;
     //bannerView.loopingInterval = 2.0;
     // bannerView.infiniteLooping = YES;
    bannerView.items = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        UILabel *label = (UILabel *)reusableView;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textColor = [UIColor whiteColor];
            label.contentMode = UIViewContentModeScaleAspectFit;
            label.font = [UIFont boldSystemFontOfSize:30];
            label.textAlignment = NSTextAlignmentCenter;
        }
        if ([bannerView.items indexOfObject:item] % 2 == 0) {
            label.backgroundColor = [UIColor blackColor];
        }
        else {
            label.backgroundColor = [UIColor redColor];
        }
        label.text = item;
        return label;
    };
    [self.view addSubview:bannerView];
}

@end
