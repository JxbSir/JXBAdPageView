//
//  ViewController.m
//  XBAdPageView
//
//  Created by Peter on 15/5/13.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "ViewController.h"
#import "JXBAdPageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()<JXBAdPageViewDelegate>
{
}
@property(nonatomic,strong)JXBAdPageView    *adView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //使用资源Image
//    _adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 100)];
//    _adView.iDisplayTime = 2;
//    [_adView startAdsWithBlock:@[@"m1",@"m2",@"m3",@"m4",@"m5"] block:^(NSInteger clickIndex){
//        NSLog(@"%d",(int)clickIndex);
//    }];
//    [self.view addSubview:_adView];
    
    //使用SDWebImage
    _adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 100)];
    _adView.iDisplayTime = 2;
    _adView.bWebImage = YES;
    _adView.delegate = self;
    [_adView startAdsWithBlock:@[@"http://img0.bdstatic.com/img/image/2016ss1.jpg",@"http://img0.bdstatic.com/img/image/dac851da0acb309ff997dfba8184d4781418016764.jpg",@"http://img0.bdstatic.com/img/image/1165fa709c98224247f6f9f81b45a4ab1409118681.jpg"] block:^(NSInteger clickIndex){
        NSLog(@"%d",(int)clickIndex);
    }];
    [self.view addSubview:_adView];
}


- (void)setWebImage:(UIImageView *)imgView imgUrl:(NSString *)imgUrl {
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}
@end
