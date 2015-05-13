//
//  ViewController.m
//  XBAdPageView
//
//  Created by Peter on 15/5/13.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "ViewController.h"
#import "JXBAdPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JXBAdPageView* adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 150)];
    [adView startAdsWithBlock:@[@"m1",@"m2",@"m3",@"m4",@"m5"] block:^(NSInteger clickIndex){
        NSLog(@"%d",clickIndex);
    }];
    [self.view addSubview:adView];
}
@end
