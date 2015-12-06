//
//  JXBAdPageView.h
//  XBAdPageView
//
//  Created by Peter Jin mail:i@Jxb.name on 15/5/13.
//  Github ---- https://github.com/JxbSir
//  Copyright (c) 2015年 Peter. All rights reserved.
//


#import <UIKit/UIKit.h>

@class JXBAdPageView;
typedef void (^JXBAdPageCallback)(NSInteger clickIndex);

@protocol JXBAdPageViewDelegate <NSObject>
/**
 *  加载网络图片使用回调自行调用SDImage
 *
 *  @param imgView
 *  @param imgUrl
 */
- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl;
@end

@interface JXBAdPageView : UIView
@property(nonatomic,assign)NSInteger                iDisplayTime; //广告图片轮播时停留的时间，默认0秒不会轮播
@property(nonatomic,assign)BOOL                     bWebImage; //设置是否为网络图片
@property(nonatomic,strong)UIPageControl            *pageControl;
@property(nonatomic,assign)id<JXBAdPageViewDelegate>  delegate;
@property(nonatomic) UIViewContentMode contentMode;
/**
 *  启动函数
 *
 *  @param imageArray 设置图片数组
 *  @param block      block，回调点击
 */
- (void)startAdsWithBlock:(NSArray*)imageArray block:(JXBAdPageCallback)block;
/**
 *  停止广告轮播，释放内存
 *  不再使用 JXBAdPageView 时，先调用 stopAds，释放 timer占用，从runloop中退出。否则会常驻内存。
 */
- (void)stopAds;
@end
