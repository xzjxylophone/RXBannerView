//
//  MainViewController.m
//  RXBannerViewExample
//
//  Created by Rush.D.Xzj on 16/2/29.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "MainViewController.h"
#import "RXBannerView.h"
@interface MainViewController ()<RXBannerViewDataSource>
@property (nonatomic, strong) RXBannerView *rxBannerView;
@end

@implementation MainViewController

#pragma mark - RXBannerViewDataSource
- (NSInteger)numberOfPageInRXBannerView:(RXBannerView *)rxBannerView
{
    return 5;
    return 4;
    return 3;
    return 1;
    return 2;
}

- (void)btnTouchUpInside:(id)sender
{
    [self.rxBannerView nextPageAnimationActionWithDuration:0.3];
    
//    [self.rxBannerView prePageAnimationActionWithDuration:0.3];
}

- (UIView *)rxBannerView:(RXBannerView *)rxBannerView viewAtIndex:(NSInteger)index
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 200;
    
    NSArray *ary = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], [UIColor purpleColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = ary[index];
    
    return view;
}


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.rxBannerView = [[RXBannerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.rxBannerView.dataSource = self;
    
    [self.rxBannerView reloadData];
    [self.rxBannerView autoScrollWithSecond:0];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 240, 200, 40);
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:self.rxBannerView];
    [self.view addSubview:btn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
