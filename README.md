# JXBAdPageView
一个广告图片无限轮播控件

-------
##支持CocoaPods引入
`pod 'JXBAdPageView'`

-------
##调用接口
``` object-c
@protocol JXBAdPageViewDelegate <NSObject>
/**
 *  加载网络图片使用回调自行调用SDImage
 *
 *  @param imgView
 *  @param imgUrl
 */
- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl;
@end


/**
 *  启动函数
 *
 *  @param imageArray 设置图片数组
 *  @param block      block，回调点击
 */
- (void)startAdsWithBlock:(NSArray*)imageArray block:(JXBAdPageCallback)block;
``` 

##创建代码
```object-c
JXBAdPageView* adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 150)];
[adView startAdsWithBlock:@[@"m1",@"m2",@"m3",@"m4",@"m5"] block:^(NSInteger clickIndex){
    NSLog(@"%d",clickIndex);
}];
[self.view addSubview:adView];
```

##控件展示图
![](https://raw.githubusercontent.com/JxbSir/JXBAdPageView/master/screen/screenshot.gif)
