//
//  DemoService.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoService.h"

@implementation DemoService

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        // 1. 注册方法1: 类必须继承'DVEventBusClassDelegate', 和实现 'event_classMethod_map'
        [DVEventSubscriber registerClassEvents:[DemoService class]];
        
        
        // 2. 注册方法2:
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_LOGIN subscriber:[DemoService class] action:@selector(loginWithUserName:password:success:)];
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_ADD subscriber:[DemoService class] action:@selector(addWithA:b:)];
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_GET_STRING subscriber:[DemoService class] action:@selector(getString)];
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_GET_OBJECT subscriber:[DemoService class] action:@selector(getObject)];
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD subscriber:[DemoService class] action:@selector(mutilMethod1)];
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD subscriber:[DemoService class] action:@selector(mutilMethod2)];
//        [DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD subscriber:[DemoService class] action:@selector(mutilMethod3)];
    });
}

// 类事件 绑定 类方法
+ (NSDictionary<NSString *,NSString *> *)event_classMethod_map {
    return @{
        kEVENT_SERVICE_DEMO_LOGIN        : _sel(@selector(loginWithUserName:password:success:)),
        kEVENT_SERVICE_DEMO_ADD          : _sel(@selector(addWithA:b:)),
        kEVENT_SERVICE_DEMO_GET_STRING   : _sel(@selector(getString)),
        kEVENT_SERVICE_DEMO_GET_OBJECT   : _sel(@selector(getObject)),
        kEVENT_SERVICE_DEMO_MUTIL_METHOD : _sel(@selector(mutilMethod1))
                                          ._sel(@selector(mutilMethod2))
                                          ._sel(@selector(mutilMethod3))
    };
}

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password success:(void(^)(BOOL status))success {
    NSLog(@"[DemoService LOG]: 登录成功, userName-> %@, password-> %@", userName, password);
    success(YES);
}

+ (NSNumber *)addWithA:(NSNumber *)a b:(NSNumber *)b {
    int ret = [a intValue] + [b intValue];
    return @(ret);
}

+ (NSString *)getString {
    return @"Hello world";
}

+ (UserModel *)getObject {
    UserModel *model = [[UserModel alloc] init];
    model.userName = @"David";
    model.password = @"123456";
    return model;
}

+ (void)mutilMethod1 {
    NSLog(@"[DemoService LOG]: 触发方法1");
}

+ (void)mutilMethod2 {
    NSLog(@"[DemoService LOG]: 触发方法2");
}

+ (void)mutilMethod3 {
    NSLog(@"[DemoService LOG]: 触发方法3");
}


@end
