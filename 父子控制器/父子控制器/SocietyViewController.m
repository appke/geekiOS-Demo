//
//  SocietyViewController.m
//  父子控制器
//
//  Created by 穆良 on 2018/4/22.
//  Copyright © 2018年 穆良. All rights reserved.
//

#import "SocietyViewController.h"

@interface SocietyViewController ()

@end

@implementation SocietyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorHex(0x00BEE0);
    self.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64); 
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
