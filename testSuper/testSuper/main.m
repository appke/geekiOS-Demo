//
//  main.m
//  testSuper
//
//  Created by MGBook on 2018/3/27.
//  Copyright © 2018年 MGBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"
#import "NSObject+Sark.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
//        Son *son = [[Son alloc] init];
//        [son test];

        // 理解＋和-方法
        [NSObject foo];
//        [[NSObject new] foo];
        id x = [NSObject new];
        [x foo];
    }
    return 0;
}
