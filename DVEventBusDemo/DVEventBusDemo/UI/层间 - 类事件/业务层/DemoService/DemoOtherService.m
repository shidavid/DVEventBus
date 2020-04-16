//
//  DemoOtherService.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoOtherService.h"

@implementation DemoOtherService

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        [DVEventSubscriber registerClassEvents:[DemoOtherService class]];
    });
}

+ (NSDictionary<NSString *,NSString *> *)event_classMethod_map {
    return @{
        kEVENT_SERVICE_DEMO_MUTIL_METHOD : _sel(@selector(mutilMethod1)),
    };
}

+ (void)mutilMethod1 {
    NSLog(@"[DemoOtherService LOG]: 触发方法1");
}


@end
