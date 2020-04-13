//
//  MainViewModel.m
//  DVDataBindDemo
//
//  Created by David on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

- (NSDictionary<NSString *,NSString *> *)tableItems {
    return @{
        @"模块间 - 对象事件"  : @"BaseViewController",
        @"层间 - 类事件"     : @"DemoViewController",
    };
}

@end
