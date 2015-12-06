//
//  JXBAdPageView.m
//  XBAdPageView
//
//  Created by Peter Jin mail:i@Jxb.name on 15/5/13.
//  Github ---- https://github.com/JxbSir
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "JXBAdPageView.h"

@interface JXBAdPageView()<UIScrollViewDelegate>
@property (nonatomic,assign)int                 indexShow;
@property (nonatomic,copy)NSArray               *arrImage;
@property (nonatomic,strong)UIScrollView        *scView;
@property (nonatomic,strong)UIImageView         *imgPrev;
@property (nonatomic,strong)UIImageView         *imgCurrent;
@property (nonatomic,strong)UIImageView         *imgNext;
@property (nonatomic,strong)NSTimer             *myTimer;
@property (nonatomic,strong)JXBAdPageCallback   myBlock;
@end

@implementation JXBAdPageView
@synthesize myBlock;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self initUI];
}

- (void)initUI {
    _scView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [_scView setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:_scView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];
    
    
    _imgPrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgNext = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    
    [_scView addSubview:_imgPrev];
    [_scView addSubview:_imgCurrent];
    [_scView addSubview:_imgNext];
    
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 10, self.frame.size.width, 10)];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
}
-(void)setContentMode:(UIViewContentMode)contentMode {
    _contentMode = contentMode;
    //设置图片填充模式
    NSArray * imageViews = @[_imgPrev,_imgCurrent,_imgNext];
    for (UIImageView * imageView in imageViews) {
        if (_contentMode) {
            imageView.contentMode = _contentMode;
        }
    }
}
-(void)layoutSubviews {
    _imgPrev.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _imgCurrent.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    _imgNext.frame = CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
}
/**
 *  启动函数
 *
 *  @param imageArray 图片数组
 *  @param block      click回调
 */
- (void)startAdsWithBlock:(NSArray*)imageArray block:(JXBAdPageCallback)block {
    if(imageArray.count <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        _pageControl.hidden = true;
    }else {
        _pageControl.hidden = false;
    }
    
    _pageControl.numberOfPages = imageArray.count;
    _arrImage = imageArray;
    self.myBlock = block;
    [self reloadImages];
}
- (void)stopAds {
    if (_myTimer) {
        [_myTimer invalidate];
    }
}
/**
 *  点击广告
 */
- (void)tapAds
{
    if (self.myBlock != NULL) {
        self.myBlock(_indexShow);
    }
    if (_myTimer)
        [_myTimer invalidate];
    if (_iDisplayTime > 0)
        [self startTimerPlay];
}

/**
 *  加载图片顺序
 */
- (void)reloadImages {
    if (_indexShow >= (int)_arrImage.count)
        _indexShow = 0;
    if (_indexShow < 0)
        _indexShow = (int)_arrImage.count - 1;
    int prev = _indexShow - 1;
    if (prev < 0)
        prev = (int)_arrImage.count - 1;
    int next = _indexShow + 1;
    if (next > _arrImage.count - 1)
        next = 0;
    _pageControl.currentPage = _indexShow;
    NSString* prevImage = [_arrImage objectAtIndex:prev];
    NSString* curImage = [_arrImage objectAtIndex:_indexShow];
    NSString* nextImage = [_arrImage objectAtIndex:next];
    if(_bWebImage)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(setWebImage:imgUrl:)])
        {
            [_delegate setWebImage:_imgPrev imgUrl:prevImage];
            [_delegate setWebImage:_imgCurrent imgUrl:curImage];
            [_delegate setWebImage:_imgNext imgUrl:nextImage];
        }
        else
        {
            _imgPrev.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:prevImage]]];
            _imgCurrent.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curImage]]];
            _imgNext.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextImage]]];
        }
    }
    else
    {
        _imgPrev.image = [UIImage imageNamed:prevImage];
        _imgCurrent.image = [UIImage imageNamed:curImage];
        _imgNext.image = [UIImage imageNamed:nextImage];
    }
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
    if (_iDisplayTime > 0)
        [self startTimerPlay];
}

/**
 *  切换图片完毕事件
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_myTimer)
        [_myTimer invalidate];
    if (scrollView.contentOffset.x >=self.frame.size.width*2)
        _indexShow++;
    else if (scrollView.contentOffset.x < self.frame.size.width)
        _indexShow--;
    [self reloadImages];
}

- (void)startTimerPlay {
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:_iDisplayTime target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:NO];
}

/**
 *  轮播图片
 */
- (void)doImageGoDisplay {
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    _indexShow++;
    [self performSelector:@selector(reloadImages) withObject:nil afterDelay:0.3];
}

@end
