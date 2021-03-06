//
//  FirstViewController.m
//  Objc 实现UINavigation全屏滑动返回(一)
//
//  Created by 林洵锋 on 2017/5/4.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "LxDBAnything.h"
#import "NSObject+DLIntrospection.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // 添加按钮
    [self addBtn];
    
    
    // 打印手势属性
    id gesture = [UIGestureRecognizer class];
    
//    LxDBAnyVar([gesture classes]);
//    LxDBAnyVar([gesture properties]);
//    LxDBAnyVar([gesture instanceVariables]);
//    
//    UIGestureRecognizer *recognizer = self.navigationController.interactivePopGestureRecognizer;
//    NSArray *_targets = [recognizer valueForKey:@"_targets"];
//    id gestureTarget = [_targets lastObject];
//    LxDBAnyVar(_targets);
//    LxDBAnyVar(gestureTarget);
//    LxDBAnyVar([gestureTarget valueForKey:@"_target"]);
//    LxDBAnyVar([gestureTarget valueForKey:@"_action"]); // 报错！
    
    
    LxDBAnyVar(self.navigationController.interactivePopGestureRecognizer.delegate);
    

    
}

// 隐藏导航栏
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//// 消失时还原，否则都没有
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//}




- (void)addBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
}

- (void)btnPress {
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}

@end
