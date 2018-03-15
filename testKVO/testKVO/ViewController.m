//
//  ViewController.m
//  testKVO
//
//  Created by MGBook on 2018/2/24.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import "ViewController.h"
#import "MGPerson.h"
#import "NSObject+MGKVO.h"

@interface ViewController ()

@property (nonatomic, strong) MGPerson *p;

@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, copy) NSString *address;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwitch *swi = [[UISwitch alloc] init];
    [self.view addSubview:swi];
    
    NSLog(@"=====%@", NSStringFromCGRect(self.view.frame));
    
    NSDictionary *dict = @{@"address" : self.address?: @""};
    
//    LxDBAnyVar(self.longitude?:@"");
    NSLog(@"%@", dict);
    
    self.address = @"hubei";
    NSDictionary *dict2 = @{@"address" : self.address?: @""};
    NSLog(@"%@", dict2);
    
    
//    MGPerson *p = [[MGPerson alloc] init];
//    p.name = @"lisa";
//    _p = p;
//
//    [p MG_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    
}


// 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"object-----%@", object);
    NSLog(@"-----%@", change);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *randomStr = [NSString stringWithFormat:@"%d", arc4random()%10];
    _p.name = randomStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
