//
//  DemoOtherService.m
//  DVEventBusDemo
//
//  Created by mlgPro on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoOtherService.h"

@implementation DemoOtherService

+ (NSDictionary<NSString *,NSString *> *)event_classMethod_map {
    return @{
        kEVENT_SERVICE_DEMO_MUTIL_METHOD : _sel(@selector(mutilMethod1)),
    };
}

+ (void)mutilMethod1 {
    NSLog(@"[DemoOtherService LOG]: 触发方法1");
}


@end
