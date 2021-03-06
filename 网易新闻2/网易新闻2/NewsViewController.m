//
//  NewsViewController.m
//  网易新闻
//
//  Created by MGBook on 2018/5/2.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "NewsViewController.h"
#import "BNViewController.h"

static CGFloat const labelW = 100;
static CGFloat const radio = 1.3;

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface NewsViewController () <UIScrollViewDelegate>
/// 选中的Label
@property (nonatomic, weak) UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *containView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易新闻";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 头条 热点 视频 社会 阅读 科技
    [self setupAllViewController];
    [self setupHeaderTitle];
    
    [self setupScrollView];
}


/**
 初始化ScrollView
 */
- (void)setupScrollView
{
    // 标题ScrollView
    NSUInteger count = self.childViewControllers.count;
    self.titleScrollView.contentSize = CGSizeMake(labelW * count, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    

    // 内容ScrollView
    self.containView.contentSize = CGSizeMake(count * kScreenWidth, 0);
    self.containView.showsHorizontalScrollIndicator = NO;
    self.containView.pagingEnabled = YES;
    self.containView.delegate = self;
}

/**
 所有标题文字
 */
- (void)setupHeaderTitle
{
    NSUInteger count = self.childViewControllers.count;
    
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UILabel *label = [[UILabel alloc] init];
        
        CGFloat labelX = i * labelW;
        label.frame =CGRectMake(labelX, 0, labelW, 44);
        label.text = vc.title;
        label.textAlignment = NSTextAlignmentCenter;

        label.textColor = [UIColor blackColor];
//        label.highlightedTextColor = [UIColor redColor];
        label.tag = i;
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickWithTap:)];
        [label addGestureRecognizer:tap];
        
        [self.titleScrollView addSubview:label];
        
        // 默认选中第一个
        if (i == 0) {
            [self labelClickWithTap:tap];
        }
    }
}

#pragma mark - UIScrollViewDelegate
/// 一滚动就调用，处理标题文字收缩
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 当前,缩放比例
    CGFloat curPage = scrollView.contentOffset.x / kScreenWidth;
    NSInteger leftIndex = curPage;
    NSInteger rightIndex = curPage + 1;
    
    // 获得标题label
    UILabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    UILabel *rightLabel;
    if (rightIndex < self.titleScrollView.subviews.count - 1) {
        rightLabel = self.titleScrollView.subviews[rightIndex];
    }
    
    // 计算缩放比例
    // 0 ~ 1
    CGFloat rightScale = curPage - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    // 形变 1 ~ 1.3
    leftLabel.transform = CGAffineTransformMakeScale(leftScale*0.3 + 1, leftScale * 0.3 + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale*0.3 + 1, rightScale*0.3 + 1);
    
    // 文字颜色渐变
    /*
            R G B
        黑色 0 0 0
        红色 1 0 0
     */
    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    
//    NSLog(@"leftScale----%lf，rightScale----%lf", leftScale, rightScale);
    NSLog(@"----%lf", curPage);
}

/// 滚动完成做事情
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    
    // 选中标题
    UILabel *label = self.titleScrollView.subviews[index];
    [self titleDidClick:label];
}

/**
 点击标题
 */
- (void)labelClickWithTap:(UITapGestureRecognizer *)tap
{
    // label文字变红色
    UILabel *label = (UILabel *)tap.view;
    [self titleDidClick:label];
}


/// 都在这里做事情
- (void)titleDidClick:(UILabel *)label
{
    // 标题scrollView滚动到中间位置
    [self setupTitleCenter:label];
    
    // 取消高亮 - 控制不了颜色渐变 - 是2种状态
//    _selectLabel.highlighted = NO;
    // 颜色还原
    _selectLabel.textColor = [UIColor blackColor];
    // 取消形变
    _selectLabel.transform = CGAffineTransformIdentity;
    
//    label.highlighted = YES;
    label.textColor = [UIColor redColor];
    label.transform = CGAffineTransformMakeScale(radio , radio);
    _selectLabel = label;
    
    // 滚到对应的位置
    NSInteger index = label.tag;
    CGFloat offsetX = index * kScreenWidth;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.containView setContentOffset:offset animated:NO];
    
    // 在对应位置添加子控制器
    UIViewController *vc = self.childViewControllers[index];
    // 如果控制器已经 加载过
    if (vc.isViewLoaded) return;
    
    // 设置尺寸
//    vc.view.frame = self.containView.bounds;
//    vc.view.left = offsetX;
    
    CGRect frame = self.containView.bounds;
    frame.origin.x = offsetX;
    vc.view.frame = frame;
    
    [self.containView addSubview:vc.view];
}


/**
 让标题居中
 */
- (void)setupTitleCenter:(UILabel *)centerLabel
{
    // 滚动距离 = label的中点 - 屏幕的一半
    CGFloat tOffsetX = centerLabel.center.x - kScreenWidth * 0.5;
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - kScreenWidth;
    if (tOffsetX < 0 ) {
        tOffsetX = 0;
    } else if (maxOffsetX < 0) {
        tOffsetX = 0;
    } else if (tOffsetX > maxOffsetX) {
        tOffsetX = maxOffsetX;
    }
    CGPoint titleOffset = CGPointMake(tOffsetX, 0);
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
}


/**
 初始化所有子控制器
 */
- (void)setupAllViewController
{
    // 头条
    BNViewController *topic = [[BNViewController alloc] init];
    topic.title = @"头条";
    [self addChildViewController:topic];
    
    // 热点
    BNViewController *hot = [[BNViewController alloc] init];
    hot.title = @"热点";
    [self addChildViewController:hot];
    
    // 视频
    BNViewController *vedio = [[BNViewController alloc] init];
    vedio.title = @"视频";
    [self addChildViewController:vedio];

    // 社会
    BNViewController *society = [[BNViewController alloc] init];
    society.title = @"社会";
    [self addChildViewController:society];
    
    // 阅读
    BNViewController *read = [[BNViewController alloc] init];
    read.title = @"阅读";
    [self addChildViewController:read];

    // 科技
    BNViewController *science = [[BNViewController alloc] init];
    science.title = @"科技";
    [self addChildViewController:science];
}

@end
