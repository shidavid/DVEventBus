//
//  DemoService.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoService.h"

@implementation DemoService

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
