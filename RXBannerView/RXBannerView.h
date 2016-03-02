//
//  RXBannerView.h
//  RXBannerViewExample
//
//  Created by Rush.D.Xzj on 16/2/29.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXPageControl.h"

@class RXBannerView;

@protocol RXBannerViewDataSource <NSObject>

- (NSInteger)numberOfPageInRXBannerView:(RXBannerView *)rxBannerView;

- (UIView *)rxBannerView:(RXBannerView *)rxBannerView viewAtIndex:(NSInteger)index;

@end


// 需要把vc的edgesForExtendedLayout = UIRectEdgeNone;
@interface RXBannerView : UIView






@property (nonatomic, weak) id<RXBannerViewDataSource> dataSource;


- (void)reloadData;


@property (nonatomic, readonly) RXPageControl *rxPageControl;


// 滚动间隔小于1秒,直接表示停止滚动, 动画持续时间是1秒,
- (void)autoScrollWithSecond:(NSInteger)second;
// 滚动间隔小于1秒,直接表示停止滚动,
- (void)autoScrollWithSecond:(NSInteger)second duration:(CGFloat)duration;

- (void)stopAutoScroll;



@end
