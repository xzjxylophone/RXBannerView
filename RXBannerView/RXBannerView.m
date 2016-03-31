//
//  RXBannerView.m
//  RXBannerViewExample
//
//  Created by Rush.D.Xzj on 16/2/29.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "RXBannerView.h"
@interface RXBannerView ()<UIScrollViewDelegate>



@property (nonatomic, strong) NSArray *itemViews;
@property (nonatomic, strong) NSArray *addItemViews;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) RXPageControl *rxPageControl;

@property (nonatomic, strong) NSTimer *autoTimer;

@property (nonatomic, assign) CGFloat animateDuration;

@end



@implementation RXBannerView

#pragma mark - Proverty
- (void)setCurrentPage:(NSInteger)currentPage
{
    [self updateWithCurrentPage:currentPage];
}
- (NSInteger)currentPage
{
    return self.rxPageControl.currentPage;
}

#pragma mark - Private
- (void)updateWithCurrentPage:(NSInteger)page
{
    if (page < 0) {
        page = self.rxPageControl.numberOfPages - 1;
    } else if (page > self.rxPageControl.numberOfPages - 1) {
        page = 0;
    } else {
        // Do Nothing
    }
    self.rxPageControl.currentPage = page;

    if (self.itemViews.count == 0) {
        return;
    }
    for (UIView *view in self.addItemViews) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *addItemViewAry = [NSMutableArray array];
    CGFloat width = self.frame.size.width;
    NSInteger count = 3;
    
    for (NSInteger i = 0; i < count; i++) {
        NSInteger addIndex = i + page - 1;
        UIView *view = nil;
        if (addIndex < 0) {
            addIndex = self.itemViews.count - 1;
            view = self.itemViews[addIndex];
        } else if (addIndex > self.itemViews.count - 1) {
            addIndex = 0;
            view = self.itemViews[addIndex];
        } else {
            addIndex = addIndex;
            view = self.itemViews[addIndex];
        }
        CGRect frame = view.frame;
        frame.origin.x = width * i;
        view.frame = frame;
        [self.scrollView addSubview:view];
        [addItemViewAry addObject:view];
    }
    self.addItemViews = addItemViewAry;
    self.scrollView.contentOffset = CGPointMake(width, 0);
    
    
}


#pragma mark - Public

- (void)reloadData
{
    for (UIView *view in self.itemViews) {
        [view removeFromSuperview];
    }
    NSInteger count = [self.dataSource numberOfPageInRXBannerView:self];
    if (count == 0) {
        return;
    }
    // 如果是两张图片,直接可以假设是4张图片
    NSInteger logicCount = count == 2 ? 4 : count;
    NSMutableArray *itemViewAry = [NSMutableArray array];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    for (NSInteger i = 0; i < logicCount; i++) {
        NSInteger index = logicCount == count ? i : i % 2;
        UIView *view = [self.dataSource rxBannerView:self viewAtIndex:index];
        CGRect frame = view.frame;
        frame.origin.x = width * i;
        view.frame = frame;
        [itemViewAry addObject:view];
    }
    self.itemViews = itemViewAry;
    self.rxPageControl.numberOfPages = count;
    [self.rxPageControl reloadView];
    
    //
    if (count == 1) {
        self.rxPageControl.hidden = YES;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.scrollView.contentSize = CGSizeMake(width, height);
        [self.scrollView addSubview:self.itemViews[0]];
    } else {
        self.rxPageControl.hidden = NO;
        self.scrollView.contentOffset = CGPointMake(width, 0);
        self.scrollView.contentSize = CGSizeMake(width * 3, height);
        [self updateWithCurrentPage:self.rxPageControl.currentPage];

    }
    
}



- (void)prePageAction
{
    NSInteger newPage = self.rxPageControl.currentPage - 1;
    [self updateWithCurrentPage:newPage];
}
- (void)nextPageAction
{
    NSInteger newPage = self.rxPageControl.currentPage + 1;
    [self updateWithCurrentPage:newPage];
}


- (void)prePageAnimationActionWithDuration:(NSTimeInterval)duration
{
    CGFloat x = self.scrollView.contentOffset.x;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationPreDidShowStop:finished:)];
    self.scrollView.contentOffset = CGPointMake(x - self.frame.size.width, 0);
    [UIView commitAnimations];
}
- (void)nextPageAnimationActionWithDuration:(NSTimeInterval)duration
{
    CGFloat x = self.scrollView.contentOffset.x;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidShowStop:finished:)];
    self.scrollView.contentOffset = CGPointMake(x + self.frame.size.width, 0);
    [UIView commitAnimations];
}

#pragma mark - Action
- (void)autoTimerAction:(id)sender
{
    
    CGFloat x = self.scrollView.contentOffset.x;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:self.animateDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidShowStop:finished:)];
    
    self.scrollView.contentOffset = CGPointMake(x + self.frame.size.width, 0);
    
    [UIView commitAnimations];
    
    
}
- (void)animationDidShowStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self nextPageAction];
}
- (void)animationPreDidShowStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self prePageAction];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    switch (page) {
        case 0:
        {
            // 上一页
            [self prePageAction];
        }
            break;
        case 2:
        {
            // 下一页
            [self nextPageAction];
        }
            break;
        case 1:
        default:
        {
            // 当前页
        }
            break;
    }
}

- (void)autoScrollWithSecond:(NSInteger)second
{
    [self autoScrollWithSecond:second duration:1.0f];
}


- (void)autoScrollWithSecond:(NSInteger)second duration:(CGFloat)duration
{
    
    [self.autoTimer invalidate];
    self.autoTimer = nil;
    if (second < 1.0) {
        return;
    }
    self.animateDuration = duration;
    self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:(second + duration) target:self selector:@selector(autoTimerAction:) userInfo:nil repeats:YES];
}

- (void)stopAutoScroll
{
    [self autoScrollWithSecond:0];
}

#pragma mark - Constructor And Destructor
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(width * 3, self.frame.size.height);
        self.scrollView.contentOffset = CGPointMake(width, 0);
        
        
        
        
        
        self.rxPageControl = [[RXPageControl alloc] initWithFrame:CGRectMake(width - 200, height - 50, 200, 50)];
        self.rxPageControl.currentPage = 0;
        self.rxPageControl.circleDistance = 20;
        self.rxPageControl.circleSize = 10;
        
        
        
        
        
        
        
        
        
        
        [self addSubview:self.scrollView];
        [self addSubview:self.rxPageControl];
    }
    return self;
}


@end
