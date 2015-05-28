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
@property(nonatomic,strong)JXBAdPageView    *adView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 100)];
    _adView.iDisplayTime = 2;
    [_adView startAdsWithBlock:@[@"m1",@"m2",@"m3",@"m4",@"m5"] block:^(NSInteger clickIndex){
        NSLog(@"%d",(int)clickIndex);
    }];
    [self.view addSubview:_adView];
}

//- (BOOL)shouldAutorotate {
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
//    {
//        CGFloat w = [UIScreen mainScreen].bounds.size.width;
//        _adView.frame = CGRectMake(0, 20, w, 100);
//    }
//    else
//    {
//        CGFloat w = [UIScreen mainScreen].bounds.size.width;
//        _adView.frame = CGRectMake(0, 20, w, 100);
//    }
//    return YES ;
//}
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}
@end
